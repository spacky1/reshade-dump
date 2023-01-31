//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ReShade effect file
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Multi-LUT shader, using a texture atlas with multiple LUTs
// by Otis / Infuse Project.
// Based on Marty's LUT shader 1.0 for ReShade 3.0
// Copyright © 2008-2016 Marty McFly
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#ifndef fSpackLUT_TextureName
	#define fSpackLUT_TextureName "spack_multilut.png"
#endif
#ifndef fSpackLUT_TileSizeXY
	#define fSpackLUT_TileSizeXY 64
#endif
#ifndef fSpackLUT_TileAmount
	#define fSpackLUT_TileAmount 64
#endif
#ifndef fSpackLUT_LutAmount
	#define fSpackLUT_LutAmount 3
#endif

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

uniform int fSpackLUT_LutSelector < 
	ui_type = "combo";
	ui_min= 0; ui_max=16;
	ui_items="spackin\0Continuum\0Skyfall\0";
	ui_label = "The LUT to use";
	ui_tooltip = "The LUT to use for color transformation.";
> = 0;

uniform float fSpackLUT_AmountChroma <
	ui_type = "drag";
	ui_min = 0.00; ui_max = 1.00;
	ui_label = "LUT chroma amount";
	ui_tooltip = "Intensity of color/chroma change of the LUT.";
> = 1.00;

uniform float fSpackLUT_AmountLuma <
	ui_type = "drag";
	ui_min = 0.00; ui_max = 1.00;
	ui_label = "LUT luma amount";
	ui_tooltip = "Intensity of luma change of the LUT.";
> = 1.00;

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#include "ReShade.fxh"
texture spackTexMultiLUT < source = fSpackLUT_TextureName; > { Width = fSpackLUT_TileSizeXY*fSpackLUT_TileAmount; Height = fSpackLUT_TileSizeXY * fSpackLUT_LutAmount; Format = RGBA8; };
sampler	spackSamplerMultiLUT { Texture = spackTexMultiLUT; };

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void PS_spackMultiLUT_Apply(float4 vpos : SV_Position, float2 texcoord : TEXCOORD, out float4 res : SV_Target0)
{
	float4 color = tex2D(ReShade::BackBuffer, texcoord.xy);
	float2 texelsize = 1.0 / fSpackLUT_TileSizeXY;
	texelsize.x /= fSpackLUT_TileAmount;

	float3 lutcoord = float3((color.xy*fSpackLUT_TileSizeXY-color.xy+0.5)*texelsize.xy,color.z*fSpackLUT_TileSizeXY-color.z);
	lutcoord.y /= fSpackLUT_LutAmount;
	lutcoord.y += (float(fSpackLUT_LutSelector)/ fSpackLUT_LutAmount);
	float lerpfact = frac(lutcoord.z);
	lutcoord.x += (lutcoord.z-lerpfact)*texelsize.y;

	float3 lutcolor = lerp(tex2D(spackSamplerMultiLUT, lutcoord.xy).xyz, tex2D(spackSamplerMultiLUT, float2(lutcoord.x+texelsize.y,lutcoord.y)).xyz,lerpfact);

	color.xyz = lerp(normalize(color.xyz), normalize(lutcolor.xyz), fSpackLUT_AmountChroma) * 
	            lerp(length(color.xyz),    length(lutcolor.xyz),    fSpackLUT_AmountLuma);

	res.xyz = color.xyz;
	res.w = 1.0;
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


technique spackLUT
	<
	ui_label = "spackLUT";
	ui_tooltip = "RAT?!";
	>
{
	pass spackMultiLUT_Apply
	{
		VertexShader = PostProcessVS;
		PixelShader = PS_spackMultiLUT_Apply;
	}
}