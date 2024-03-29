# Naomi Model Extractor

[Naomi Model Extractor](https://raw.githubusercontent.com/NaomiMod/games-ExtractTools/main/NAOMI%20MODEL%20EXTRACTOR.bms) is a QuickBMS script that will scan game files for NaomiLib models and extract them.

Exported models can be opened in Blender with 
[Blender Naomilib Importer Addon](https://github.com/NaomiMod/blender-NaomiLib) 

# How to use

1) Obtain your legally own game .GDI file and open it with [GD-ROM Explorer](https://japanese-cake.livejournal.com/5889.html), inside you will find multiple files that may contain game models.
If you are unsure which file contain models, you can extract them all to any temporary folder.

2) Download your game specific script or [Naomi Model Extractor](https://github.com/NaomiMod/games-ExtractTools/archive/main.zip) 

3) Get [QuickBMS](https://aluigi.altervista.org/quickbms.htm) and run the script. You'll be asked to open the script, which file to scan and where to extract files.

4) To open extracted models in Blender, install and enable [Blender Naomilib Importer Addon](https://github.com/NaomiMod/blender-NaomiLib) 

# FAQ:

- Where are textures?

Textures are usually stored in separate archives without any header, so you have 2 options to obtain them:
1) Dump textures with by using Retroarch Flycast core (please note some textures are vertically flipped, which is correct!)
2) Look for game-specific scripts in this section

-  No models found!

1) When searching for models in a Dreamcast game, be sure to extract files from GD-ROM explorer first!

2) Avoid scanning Track.bin or files, they are likely using scrambled data and will result on false positives or no models found at all!

3) Files containing models are often referred as "POLYGON", "POL" , "MDL" , "MODEL" , "OBJ".

4) Most Naomi games resources use DES key encryption and are further compressed into zlib, so you'll need to either map the structure or open an issue, asking for X game support

5) Some games use a mix of NaomiLib and Ninja .NJ format, therefore .NJ models will not be detected/extracted.


-  Why models are separate into many pieces?

Depends by how they are stored in game, especially character models are often split into several pieces, so you'll have to manually re-assemble them


-  I want X game textures/music/sfx

You can open an issue specifying the game you want and if it gets many requests I will give it a look!

## Supported games

https://github.com/NaomiMod/blender-NaomiLib#supported-games


# Legal Disclaimer:

This collection of scripts are intended for educational and research purposes, no compensation have been paid or will be accepted.
All rights belong to SEGA, resources extracted from legally own copy are intended for personal use and any distribution is forbidden.
Contributors of NaomiMod are therefore not responsible for any distribution or illegal use of above mentioned files.
