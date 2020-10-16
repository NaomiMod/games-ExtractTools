# Naomi Model Extractor

**Important**:

[Naomi Model Extractor](https://raw.githubusercontent.com/NaomiMod/games-ExtractTools/main/NAOMI%20MODEL%20EXTRACTOR.bms) is a QuickBMS script that will scan game files for NaomiLib models and extract them.
To use it, obtain your legally own game .GDI file and open it with GD-ROM Explorer, inside you will find multiple files that may contain game models.

If you are unsure which file contain models, you can extract them all to any temporary folder and start scanning!

# FAQ:

1) Where are textures?

Textures are usually stored in separate archives without any header.
For this reason you can find specific Game-specific scripts to extract textures and other resources from your game.


2) Why models are separate into many pieces?

Depends by how they are stored in game, especially character models are often split into several pieces, so you'll have to manually re-assemble them


3) No models found!

If you are trying to extract models from a Naomi game, you need to decrypt the binary with DES key, and the big file usually contain all resources.
There are also specific situations in Naomi games, that resources are further compressed into zlib, so you need to either reverse the format or open an issue, asking for X game support

If you are trying to extract models from a Dreamcast game be sure to extract all files from GD-ROM explorer first!

4) I want X game textures/music/sfx

You can open an issue specifying the game you want and if it gets many requests I will give it a look!

## Supported games

| Game                                       | Device                  |
| ------------------------------------------ | ----------------------- |
| 18 Wheeler: American Pro Trucker           | SEGA DREAMCAST          |
| Cosmic Smash                               | SEGA DREAMCAST          |
| Crazy Taxi                                 | SEGA DREAMCAST          |
| Crazy Taxi 2                               | SEGA DREAMCAST          |
| Dead or Alive 2                            | SEGA DREAMCAST          |
| Ferrari F355 Challenge                     | SEGA DREAMCAST          |
| Fighting Vipers 2                          | SEGA DREAMCAST          |
| Giant Gram 2000: All-Japan Pro Wrestling 2 | SEGA DREAMCAST          |
| Giant Gram 2000: All-Japan Pro Wrestling 3 | SEGA DREAMCAST          |
| Outtrigger                                 | SEGA DREAMCAST          |
| Power Stone 2                              | SEGA DREAMCAST          |
| Shenmue 2                                  | SEGA DREAMCAST          |
| Virtua Fighter 3tb                         | SEGA DREAMCAST          |
| Virtua Tennis / Power Smash                | SEGA DREAMCAST          |
| Virtua Tennis 2 / Power Smash 2            | SEGA DREAMCAST          |
| Monkey Ball                                | ARCADE NAOMI - GDS-0008 |
| Virtua Tennis / Power Smash                | ARCADE NAOMI - GDS-0011 |


# Legal Disclaimer:

This collection of scripts are intended for educational and research purposes, no compensation have been paid or will be accepted.
All rights belong to SEGA, resources extracted from legally own copy are intended for personal use and any distribution is forbidden.
Contributors of NaomiMod are therefore not responsible for any distribution or illegal use of above mentioned files.
