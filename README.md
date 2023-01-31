# RatShade
Hi welcome to ratshade: reshade for RAT


## Contents
  - [Installation](#installation)
  - [Graphics Settings](#graphics-settings)
  - [Updating](#updating)
  - [Uninstallation](#uninstallation)
  - [Credits and Thanks](#credits-and-thanks)
  

## Installation
1. Download the [latest preset file](/../../releases/latest).
2. Copy and paste the `reshade-shaders` folder and `.ini` file to `Warhammer Vermintide 2\binaries` for DX11 or `Warhammer Vermintide 2\binaries_dx12` for DX12.
3. Download the [latest version of ReShade](https://reshade.me/#download) and run the installer.
4. Select "Vermintide2" for DX11 or "Vermintide2_Dx12" for DX12
5. Select DX10/11/12
6. Click "Browse...", select the `.ini` file you copied earlier
7. Check the boxes for "SweetFX", "qUINT", "AstrayFX", "OtisFX", and "Legacy effects"
8. Click "Finish"
9. Start the game and configure your graphics to use at least what is listed below


## Graphics Settings
### Minimum Required Settings
These are required to achieve the intended look of both rat and ratshade.

- **Sun Shadows** — `Low`
- **Volumetric Fog Quality** — `Low`
- **Ambient Light Quality** — `High`
- **Anti-Aliasing** — `TAA`
- **Sharpness Filter** — `Off`
- **SSAO** — `High`
- **Bloom** — `On`

### Recommended Settings
These will make a noticeable performance impact but are worth it IMO if you have the GPU headroom.

- **Sun Shadows** — `High`
- **Volumetric Fog Quality** — `High`
- **SSAO** — `Extreme`


## Updating
### Updating ReShade
Download the latest version of ReShade and select the same directory, clicking "Skip" when choosing a preset and effect packages.

### Updating the Preset
Download the latest version of the preset and copy the files within to the same directory, overwriting if asked.

## Uninstallation
Rerun the ReShade installer and click "Uninstall".

## Credits and Thanks
![image](https://www.neatorama.com/images/2008-06/the-underpant-worn-by-the-rat.jpg)
