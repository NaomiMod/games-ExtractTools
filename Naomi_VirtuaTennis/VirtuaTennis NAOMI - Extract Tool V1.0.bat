@echo off
cls
title VIRTUA TENNIS - NAOMI - Resources Extractor Ver 1.0
echo -----------------------------------------------------
echo VIRTUA TENNIS - NAOMI - Resources Extractor Ver 1.0
echo Script by Vincent
echo ----------------------------------------------------
CD %~dp0
MD "temp"
attrib +h "temp"
cd temp
tar -xf "%~dp0/vtennis.zip"
CD %~dp0
md "EXTRACTED FILES"
md "EXTRACTED FILES/Textures"
md "EXTRACTED FILES/Textures/PVR"
md "EXTRACTED FILES/Sound"
md "EXTRACTED FILES/Models"

cd %~dp0\Script_Tools
"quickbms.exe" -Q -Y "%~dp0\Script_Tools\VTNAOMI_TEX_EXTRACTOR.bms" "%~dp0\temp\*.*" "%~dp0\EXTRACTED FILES/Textures/PVR"
cls
echo ------------------------------------------------------------
echo              PVR -- PNG CONVERSION IN PROGRESS ...
echo ------------------------------------------------------------

"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\PVR\*.PVR" -Q -VF -OP "%~dp0\EXTRACTED FILES\Textures"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\EXTRACTED FILES\Textures\*.pvr" "%~dp0\EXTRACTED FILES\Textures"

cd %~dp0\Script_Tools
cls
echo ------------------------------------------------------------
echo              DTPK EXTRACTION IN PROGRESS ...
echo ------------------------------------------------------------
"quickbms.exe" -Q -Y "%~dp0\Script_Tools\VTNAOMI_DTPK EXTRACT.bms" "%~dp0\temp\*.*" "%~dp0\EXTRACTED FILES/Sound"
cls
echo ------------------------------------------------------------
echo              NL MODELS EXTRACTION IN PROGRESS ...
echo ------------------------------------------------------------

"quickbms.exe" -Q -Y "%~dp0\Script_Tools\NAOMI MODEL EXTRACTOR - SCANNER.bms" "%~dp0\temp\*.*" "%~dp0\EXTRACTED FILES/Models"
del / Q "%~dp0\EXTRACTED FILES\Models\MODEL_1_epr-22927.bin"

"quickbms.exe" -Q -Y "%~dp0\Script_Tools\VTNAOMI_SECRET_MODEL.bms" "%~dp0\temp\epr-22927.ic22" "%~dp0\EXTRACTED FILES/Models"
cls
echo ------------------------------------------------------------
echo              NL MODELS EXTRACTION IN PROGRESS ...
echo ------------------------------------------------------------


del /Q "%~dp0\EXTRACTED FILES\Textures\*.pvr"
del /Q "%~dp0\temp"
rmdir "%~dp0\temp"


