# Naomi Model Extractor
[nl_scan.py](https://github.com/NaomiMod/games-ExtractTools) is a Python script that scans game files for NaomiLib models and extracts them.

Exported models can be opened in Blender with [Blender NaomiLib Importer Addon](https://github.com/NaomiMod/blender-NaomiLib)

# Requirements
- Python 3.x

# How to use
1) Obtain your legally owned game .GDI file and open it with [GD-ROM Explorer](https://japanese-cake.livejournal.com/5889.html), inside you will find multiple files that may contain game models.
If you are unsure which files contain models, you can extract them all to a temporary folder.
2) Download [nl_scan.py](https://github.com/NaomiMod/games-ExtractTools/archive/main.zip)
3) Run `nl_scan.py`. A file picker will open — select one or more files to scan. Extraction starts immediately.
Models are saved next to the script in a folder named after each scanned file.
4) To open extracted models in Blender, install and enable [Blender NaomiLib Importer Addon](https://github.com/NaomiMod/blender-NaomiLib)

# FAQ
- **Where are textures?**
Textures are usually stored in separate archives without any header. Two options:
  1) Dump textures using the Retroarch Flycast core (note: some textures are vertically flipped, which is correct)
  2) Look for game-specific scripts in this repository

- **No models found!**
  1) When searching for models in a Dreamcast game, be sure to extract files from GD-ROM Explorer first
  2) Avoid scanning Track.bin — it likely contains scrambled data and will produce false positives or no results
  3) Files containing models are often named "POLYGON", "POL", "MDL", "MODEL", "OBJ"
  4) Most Naomi games use DES key encryption and zlib compression — you'll need to either map the structure or open an issue requesting support for a specific game

- **Why are models split into many pieces?**
This depends on how they are stored in the game. Character models in particular are often split into several parts and will need to be manually reassembled.

- **I want textures/music/sfx for game X**
Open an issue specifying the game — if it gets enough requests I'll look into it.

## Supported games
https://github.com/NaomiMod/blender-NaomiLib#supported-games

# Legal Disclaimer
This tool is intended for educational and research purposes only. No compensation has been paid or will be accepted.
All rights belong to SEGA. Resources extracted from a legally owned copy are intended for personal use only and any redistribution is forbidden.
Contributors of NaomiMod are not responsible for any distribution or illegal use of the extracted files.
