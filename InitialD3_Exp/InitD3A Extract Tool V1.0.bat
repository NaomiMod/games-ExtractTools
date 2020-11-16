@echo off
cls
title INITD3-REV A - NAOMI2 Resources Extractor Ver 1.0
echo -----------------------------------------------
echo Initial D Arcade Stage Ver. 3 (Export) - NAOMI2 Resources Extractor Ver 1.0
echo by Vincent
echo -----------------------------------------------


SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

CD %~dp0

cd .\Script_Tools
chdman extractcd -i %~dp0\CHD\gds-0033.chd -o %~dp0\CHD\FILE.gdi
xcopy %~dp0\Script_Tools\FILE.gdi %~dp0\CHD /y
cls
echo(

call :ColorText 4e "DO NOT CLOSE THIS WINDOW!"

goto :Beginoffile

:ColorText

<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof

:Beginoffile


echo.
echo.
echo *** Opening GD-ROM Explorer ***
echo.
echo.
call :ColorText 0A "Please follow these steps"
echo. 
echo. 
echo 1) Open FILE.gdi
echo.
echo 2) Right click on INID.bin and "Decrypt & Extract"
echo.
echo 3) Use DES key *google* of Initial D Arcade Stage Ver. 3 (Export) GDS-0033 , and save INID.BIN in CHD folder
echo.
echo 4) Once done, *CLOSE* GD-ROM Explorer to continue with the script
echo.
echo.
echo.
echo.
echo.
TIMEOUT 5
"GD-ROM Explorer.exe"
cls
echo PLEASE WAIT...

setlocal enabledelayedexpansion

set string=mod
set string=!string:mod=%%!

cls
echo ------------------------------------------------------------
echo               EXTRACTION IN PROGRESS ...15%string% - Scanning
echo ------------------------------------------------------------
"quickbms.exe" -Q -Y "%~dp0\Script_Tools\NMZIP.bms" "%~dp0\CHD\INID.dat" "%~dp0\Script_Tools\Temp"
md %~dp0\Script_Tools\Temp2
cls
echo ---------------------------------------------------------------------------------------------------
echo               EXTRACTION IN PROGRESS ...20%string% - Extracting Music / SFX / Models 
echo ---------------------------------------------------------------------------------------------------
"quickbms.exe" -Q -Y "%~dp0\Script_Tools\GENERIC.bms" "%~dp0\*.zlib" "%~dp0\Script_Tools\Temp2"

cd %~dp0
md "EXTRACTED FILES"
cd %~dp0\EXTRACTED FILES
md TEXTURES
md "TEXTURES\0"
md UNK
md MUSIC
md SFX


xcopy "%~dp0\Script_Tools\Temp2\*.pol" "%~dp0\EXTRACTED FILES\UNK"
xcopy "%~dp0\Script_Tools\Temp2\*.def" "%~dp0\EXTRACTED FILES\UNK"
xcopy "%~dp0\Script_Tools\Temp2\*.llcr" "%~dp0\EXTRACTED FILES\UNK"
xcopy "%~dp0\Script_Tools\Temp2\*.snd" "%~dp0\EXTRACTED FILES\Sfx"
xcopy "%~dp0\Script_Tools\Temp2\*.mot" "%~dp0\EXTRACTED FILES\UNK"
cd %~dp0\Script_Tools
del /Q "%~dp0\Script_Tools\Temp2\*.pol"
del /Q "%~dp0\Script_Tools\Temp2\*.def"
del /Q "%~dp0\Script_Tools\Temp2\*.llcr"
del /Q "%~dp0\Script_Tools\Temp2\*.snd"
del /Q "%~dp0\Script_Tools\Temp2\*.mot"
cls

cd %~dp0\Script_Tools
xcopy /y "%~dp0\CHD\INID.dat" "%~dp0\Script_Tools\Temp2"
cls
echo ---------------------------------------------------------------------------------------------------
echo               EXTRACTION IN PROGRESS ...30%string%  - Decompressing ZLIB PVR, takes about 2 minutes!
echo ---------------------------------------------------------------------------------------------------
"quickbms.exe" -Q -d -K -Y INIT_D3_EXPORT_TEX_EXTRACTOR_1-399.bms %~dp0\Script_Tools\Temp2\*.zlib "%~dp0\Extracted Files\Textures"
cls
echo ---------------------------------------------------------------------------------------------------
echo               EXTRACTION IN PROGRESS ...75%string%  - Rebuilding PVRs and Exporting
echo ---------------------------------------------------------------------------------------------------
"quickbms.exe" -Q -d -K -Y INIT_D3_EXPORT_TEX_EXTRACTOR_400-958.bms %~dp0\Script_Tools\Temp2\*.zlib "%~dp0\Extracted Files\Textures"
cls
echo ------------------------------------------------------------
echo               EXTRACTION IN PROGRESS ...90%string%
echo ------------------------------------------------------------
"quickbms.exe" -Q -Y MISSING_TEX.bms %~dp0\CHD\INID.dat "%~dp0\Extracted Files\Textures\0"
cls
echo ------------------------------------------------------------
echo               EXTRACTION IN PROGRESS ...99%string%
echo ------------------------------------------------------------
"quickbms.exe" -Q -Y SPSD_EXTRACT.bms %~dp0\CHD\INID.dat "%~dp0\Extracted Files\Music"
cls
echo ------------------------------------------------------------------
echo              CONVERT PVR IN PNG IMAGES (3 Mins)
echo.  
echo                            OR
echo.  
echo                 "CLOSE" THIS WINDOW TO STOP
echo ------------------------------------------------------------------
TIMEOUT 5

md "%~dp0\Extracted Files\Textures\0\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\0\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\0\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\0\PNG\*.pvr" "%~dp0\Extracted Files\Textures\0\PNG"
del /Q "%~dp0\Extracted Files\Textures\0\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\2.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\2.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\2.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\2.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\2.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\2.zlib\PNG\*.pvr"

cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...01%string%
echo ------------------------------------------------------------

md "%~dp0\Extracted Files\Textures\4.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\4.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\4.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\4.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\4.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\4.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\5.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\5.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\5.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\5.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\5.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\5.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\7.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\7.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\7.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\7.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\7.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\7.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\9.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\9.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\9.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\9.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\9.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\9.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\12.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\12.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\12.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\12.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\12.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\12.zlib\PNG\*.pvr"

cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...02%string%
echo ------------------------------------------------------------

md "%~dp0\Extracted Files\Textures\13.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\13.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\13.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\13.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\13.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\13.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\15.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\15.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\15.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\15.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\15.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\15.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\18.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\18.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\18.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\18.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\18.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\18.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\20.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\20.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\20.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\20.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\20.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\20.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...03%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\21.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\21.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\21.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\21.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\21.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\21.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\23.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\23.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\23.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\23.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\23.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\23.zlib\PNG\*.pvr"

cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...04%string%
echo ------------------------------------------------------------

md "%~dp0\Extracted Files\Textures\26.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\26.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\26.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\26.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\26.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\26.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\27.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\27.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\27.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\27.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\27.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\27.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\29.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\29.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\29.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\29.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\29.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\29.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...05%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\32.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\32.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\32.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\32.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\32.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\32.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\34.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\34.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\34.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\34.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\34.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\34.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\35.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\35.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\35.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\35.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\35.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\35.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\37.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\37.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\37.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\37.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\37.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\37.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\40.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\40.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\40.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\40.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\40.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\40.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...06%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\42.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\42.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\42.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\42.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\42.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\42.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\44.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\44.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\44.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\44.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\44.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\44.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\46.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\46.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\46.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\46.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\46.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\46.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\47.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\47.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\47.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\47.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\47.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\47.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\49.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\49.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\49.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\49.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\49.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\49.zlib\PNG\*.pvr"


cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...07%string%
echo ------------------------------------------------------------

md "%~dp0\Extracted Files\Textures\51.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\51.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\51.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\51.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\51.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\51.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\54.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\54.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\54.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\54.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\54.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\54.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\55.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\55.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\55.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\55.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\55.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\55.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\58.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\58.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\58.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\58.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\58.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\58.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...08%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\60.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\60.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\60.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\60.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\60.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\60.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\62.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\62.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\62.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\62.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\62.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\62.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\64.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\64.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\64.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\64.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\64.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\64.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\65.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\65.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\65.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\65.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\65.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\65.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...09%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\68.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\68.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\68.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\68.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\68.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\68.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\69.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\69.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\69.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\69.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\69.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\69.zlib\PNG\*.pvr"

cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...10%string%
echo ------------------------------------------------------------

md "%~dp0\Extracted Files\Textures\71.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\71.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\71.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\71.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\71.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\71.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\74.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\74.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\74.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\74.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\74.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\74.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\76.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\76.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\76.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\76.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\76.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\76.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\78.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\78.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\78.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\78.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\78.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\78.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...11%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\79.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\79.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\79.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\79.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\79.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\79.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\81.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\81.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\81.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\81.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\81.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\81.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\83.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\83.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\83.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\83.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\83.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\83.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...12%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\85.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\85.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\85.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\85.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\85.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\85.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\86.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\86.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\86.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\86.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\86.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\86.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\87.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\87.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\87.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\87.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\87.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\87.zlib\PNG\*.pvr"
cls

md "%~dp0\Extracted Files\Textures\88.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\88.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\88.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\88.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\88.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\88.zlib\PNG\*.pvr"
cls

md "%~dp0\Extracted Files\Textures\89.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\89.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\89.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\89.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\89.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\89.zlib\PNG\*.pvr"
cls

echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...13%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\90.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\90.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\90.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\90.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\90.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\90.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\91.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\91.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\91.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\91.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\91.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\91.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\92.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\92.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\92.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\92.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\92.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\92.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...14%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\93.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\93.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\93.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\93.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\93.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\93.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\94.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\94.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\94.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\94.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\94.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\94.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\95.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\95.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\95.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\95.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\95.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\95.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...15%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\96.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\96.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\96.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\96.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\96.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\96.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\97.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\97.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\97.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\97.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\97.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\97.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...16%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\98.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\98.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\98.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\98.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\98.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\98.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\99.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\99.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\99.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\99.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\99.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\99.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\100.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\100.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\100.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\100.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\100.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\100.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...17%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\101.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\101.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\101.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\101.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\101.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\101.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\102.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\102.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\102.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\102.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\102.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\102.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\103.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\103.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\103.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\103.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\103.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\103.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...18%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\104.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\104.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\104.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\104.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\104.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\104.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\167.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\167.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\167.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\167.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\167.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\167.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\168.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\168.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\168.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\168.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\168.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\168.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\169.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\169.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\169.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\169.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\169.zlib\PNG"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...19%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\202.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\202.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\202.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\202.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\202.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\202.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\205.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\205.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\205.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\205.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\205.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\205.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\207.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\207.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\207.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\207.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\207.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\207.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\208.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\208.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\208.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\208.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\208.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\208.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...20%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\210.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\210.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\210.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\210.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\210.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\210.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\213.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\213.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\213.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\213.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\213.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\213.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\215.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\215.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\215.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\215.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\215.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\215.zlib\PNG\*.pvr"

cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...21%string%
echo ------------------------------------------------------------

md "%~dp0\Extracted Files\Textures\217.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\217.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\217.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\217.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\217.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\217.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\218.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\218.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\218.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\218.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\218.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\218.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...22%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\221.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\221.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\221.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\221.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\221.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\221.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\222.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\222.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\222.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\222.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\222.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\222.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...23%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\225.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\225.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\225.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\225.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\225.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\225.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\226.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\226.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\226.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\226.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\226.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\226.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\228.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\228.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\228.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\228.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\228.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\228.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...24%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\231.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\231.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\231.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\231.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\231.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\231.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\232.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\232.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\232.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\232.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\232.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\232.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...25%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\235.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\235.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\235.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\235.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\235.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\235.zlib\PNG\*.pvr"

cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...26%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\236.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\236.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\236.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\236.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\236.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\236.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\239.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\239.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\239.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\239.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\239.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\239.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...27%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\241.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\241.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\241.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\241.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\241.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\241.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...28%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\243.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\243.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\243.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\243.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\243.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\243.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\244.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\244.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\244.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\244.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\244.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\244.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...29%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\246.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\246.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\246.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\246.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\246.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\246.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...30%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\249.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\249.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\249.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\249.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\249.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\249.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\251.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\251.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\251.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\251.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\251.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\251.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...31%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\252.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\252.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\252.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\252.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\252.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\252.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\255.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\255.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\255.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\255.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\255.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\255.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\256.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\256.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\256.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\256.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\256.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\256.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\258.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\258.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\258.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\258.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\258.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\258.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...32%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\261.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\261.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\261.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\261.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\261.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\261.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\263.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\263.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\263.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\263.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\263.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\263.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\264.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\264.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\264.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\264.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\264.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\264.zlib\PNG\*.pvr"


md "%~dp0\Extracted Files\Textures\266.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\266.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\266.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\266.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\266.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\266.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...33%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\268.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\268.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\268.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\268.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\268.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\268.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\270.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\270.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\270.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\270.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\270.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\270.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\273.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\273.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\273.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\273.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\273.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\273.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\274.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\274.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\274.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\274.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\274.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\274.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...33%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\277.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\277.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\277.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\277.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\277.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\277.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\279.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\279.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\279.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\279.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\279.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\279.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\280.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\280.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\280.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\280.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\280.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\280.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...34%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\281.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\281.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\281.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\281.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\281.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\281.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\285.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\285.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\285.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\285.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\285.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\285.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\286.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\286.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\286.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\286.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\286.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\286.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\289.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\289.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\289.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\289.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\289.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\289.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...35%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\292.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\292.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\292.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\292.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\292.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\292.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\293.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\293.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\293.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\293.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\293.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\293.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\296.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\296.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\296.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\296.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\296.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\296.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\297.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\297.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\297.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\297.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\297.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\297.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...36%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\299.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\299.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\299.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\299.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\299.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\299.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\301.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\301.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\301.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\301.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\301.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\301.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\303.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\303.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\303.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\303.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\303.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\303.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\305.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\305.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\305.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\305.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\305.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\305.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...37%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\307.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\307.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\307.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\307.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\307.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\307.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\309.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\309.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\309.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\309.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\309.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\309.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\311.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\311.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\311.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\311.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\311.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\311.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\313.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\313.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\313.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\313.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\313.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\313.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...38%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\315.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\315.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\315.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\315.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\315.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\315.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\317.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\317.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\317.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\317.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\317.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\317.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\319.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\319.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\319.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\319.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\319.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\319.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...39%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\322.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\322.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\322.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\322.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\322.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\322.zlib\PNG\*.pvr"


md "%~dp0\Extracted Files\Textures\323.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\323.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\323.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\323.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\323.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\323.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\325.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\325.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\325.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\325.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\325.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\325.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...40%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\327.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\327.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\327.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\327.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\327.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\327.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\329.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\329.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\329.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\329.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\329.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\329.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\331.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\331.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\331.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\331.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\331.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\331.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\333.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\333.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\333.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\333.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\333.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\333.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...41%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\335.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\335.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\335.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\335.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\335.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\335.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\337.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\337.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\337.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\337.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\337.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\337.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\339.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\339.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\339.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\339.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\339.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\339.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\341.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\341.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\341.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\341.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\341.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\341.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...42%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\343.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\343.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\343.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\343.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\343.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\343.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\345.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\345.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\345.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\345.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\345.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\345.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\347.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\347.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\347.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\347.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\347.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\347.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\349.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\349.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\349.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\349.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\349.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\349.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...43%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\351.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\351.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\351.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\351.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\351.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\351.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\353.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\353.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\353.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\353.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\353.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\353.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\354.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\354.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\354.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\354.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\354.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\354.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...44%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\356.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\356.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\356.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\356.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\356.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\356.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\359.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\359.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\359.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\359.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\359.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\359.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\361.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\361.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\361.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\361.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\361.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\361.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\363.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\363.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\363.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\363.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\363.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\363.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...45%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\365.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\365.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\365.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\365.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\365.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\365.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\367.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\367.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\367.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\367.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\367.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\367.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\369.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\369.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\369.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\369.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\369.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\369.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\371.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\371.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\371.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\371.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\371.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\371.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\373.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\373.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\373.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\373.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\373.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\373.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...46%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\375.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\375.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\375.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\375.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\375.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\375.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\376.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\376.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\376.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\376.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\376.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\376.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\379.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\379.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\379.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\379.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\379.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\379.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\381.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\381.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\381.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\381.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\381.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\381.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\382.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\382.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\382.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\382.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\382.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\382.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\385.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\385.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\385.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\385.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\385.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\385.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...47%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\386.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\386.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\386.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\386.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\386.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\386.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\388.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\388.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\388.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\388.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\388.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\388.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\390.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\390.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\390.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\390.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\390.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\390.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\393.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\393.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\393.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\393.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\393.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\393.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...48%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\395.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\395.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\395.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\395.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\395.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\395.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\397.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\397.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\397.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\397.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\397.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\397.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\399.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\399.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\399.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\399.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\399.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\399.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\400.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\400.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\400.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\400.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\400.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\400.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...49%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\402.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\402.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\402.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\402.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\402.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\402.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\404.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\404.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\404.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\404.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\404.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\404.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\406.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\406.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\406.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\406.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\406.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\406.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\408.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\408.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\408.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\408.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\408.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\408.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\411.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\411.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\411.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\411.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\411.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\411.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...50%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\412.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\412.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\412.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\412.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\412.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\412.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\415.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\415.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\415.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\415.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\415.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\415.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\416.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\416.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\416.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\416.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\416.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\416.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\418.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\418.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\418.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\418.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\418.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\418.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...51%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\421.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\421.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\421.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\421.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\421.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\421.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\423.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\423.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\423.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\423.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\423.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\423.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\425.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\425.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\425.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\425.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\425.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\425.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\427.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\427.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\427.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\427.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\427.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\427.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\429.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\429.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\429.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\429.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\429.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\429.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...52%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\430.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\430.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\430.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\430.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\430.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\430.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\433.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\433.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\433.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\433.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\433.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\433.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\455.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\455.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\455.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\455.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\455.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\455.zlib\PNG\*.pvr"


md "%~dp0\Extracted Files\Textures\459.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\459.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\459.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\459.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\459.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\459.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...53%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\461.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\461.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\461.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\461.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\461.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\461.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\463.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\463.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\463.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\463.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\463.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\463.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\465.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\465.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\465.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\465.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\465.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\465.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\466.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\466.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\466.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\466.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\466.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\466.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\468.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\468.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\468.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\468.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\468.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\468.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...54%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\469.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\469.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\469.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\469.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\469.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\469.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\470.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\470.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\470.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\470.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\470.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\470.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\471.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\471.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\471.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\471.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\471.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\471.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\480.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\480.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\480.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\480.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\480.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\480.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...55%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\481.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\481.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\481.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\481.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\481.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\481.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\482.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\482.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\482.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\482.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\482.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\482.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\483.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\483.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\483.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\483.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\483.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\483.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\484.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\484.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\484.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\484.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\484.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\484.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...56%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\485.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\485.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\485.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\485.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\485.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\485.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\486.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\486.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\486.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\486.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\486.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\486.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\487.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\487.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\487.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\487.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\487.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\487.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\496.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\496.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\496.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\496.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\496.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\496.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...57%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\497.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\497.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\497.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\497.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\497.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\497.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\498.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\498.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\498.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\498.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\498.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\498.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\499.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\499.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\499.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\499.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\499.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\499.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\502.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\502.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\502.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\502.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\502.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\502.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...58%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\503.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\503.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\503.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\503.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\503.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\503.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\512.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\512.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\512.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\512.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\512.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\512.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\513.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\513.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\513.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\513.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\513.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\513.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\514.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\514.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\514.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\514.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\514.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\514.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\515.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\515.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\515.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\515.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\515.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\515.zlib\PNG\*.pvr"

cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...59%string%
echo ------------------------------------------------------------

md "%~dp0\Extracted Files\Textures\516.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\516.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\516.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\516.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\516.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\516.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\517.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\517.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\517.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\517.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\517.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\517.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\518.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\518.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\518.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\518.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\518.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\518.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\519.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\519.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\519.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\519.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\519.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\519.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...60%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\528.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\528.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\528.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\528.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\528.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\528.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\529.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\529.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\529.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\529.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\529.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\529.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\530.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\530.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\530.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\530.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\530.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\530.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\531.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\531.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\531.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\531.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\531.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\531.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...60%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\533.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\533.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\533.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\533.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\533.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\533.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\534.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\534.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\534.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\534.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\534.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\534.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\537.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\537.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\537.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\537.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\537.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\537.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\538.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\538.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\538.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\538.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\538.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\538.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...61%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\541.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\541.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\541.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\541.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\541.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\541.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\543.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\543.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\543.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\543.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\543.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\543.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\544.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\544.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\544.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\544.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\544.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\544.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\547.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\547.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\547.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\547.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\547.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\547.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...62%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\549.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\549.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\549.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\549.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\549.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\549.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\551.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\551.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\551.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\551.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\551.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\551.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\553.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\553.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\553.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\553.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\553.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\553.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\555.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\555.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\555.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\555.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\555.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\555.zlib\PNG\*.pvr"

cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...63%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\556.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\556.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\556.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\556.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\556.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\556.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\559.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\559.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\559.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\559.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\559.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\559.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\561.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\561.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\561.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\561.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\561.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\561.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\563.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\563.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\563.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\563.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\563.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\563.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...64%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\565.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\565.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\565.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\565.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\565.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\565.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\566.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\566.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\566.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\566.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\566.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\566.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\569.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\569.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\569.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\569.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\569.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\569.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\570.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\570.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\570.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\570.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\570.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\570.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...65%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\573.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\573.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\573.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\573.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\573.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\573.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\575.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\575.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\575.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\575.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\575.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\575.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\577.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\577.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\577.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\577.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\577.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\577.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\578.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\578.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\578.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\578.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\578.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\578.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...66%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\580.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\580.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\580.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\580.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\580.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\580.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\583.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\583.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\583.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\583.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\583.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\583.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\584.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\584.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\584.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\584.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\584.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\584.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\587.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\587.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\587.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\587.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\587.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\587.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...67%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\589.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\589.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\589.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\589.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\589.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\589.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\591.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\591.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\591.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\591.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\591.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\591.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\592.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\592.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\592.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\592.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\592.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\592.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\595.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\595.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\595.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\595.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\595.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\595.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...68%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\597.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\597.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\597.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\597.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\597.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\597.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\599.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\599.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\599.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\599.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\599.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\599.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\601.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\601.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\601.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\601.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\601.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\601.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\602.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\602.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\602.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\602.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\602.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\602.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...69%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\605.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\605.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\605.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\605.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\605.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\605.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\606.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\606.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\606.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\606.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\606.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\606.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\609.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\609.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\609.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\609.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\609.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\609.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\610.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\610.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\610.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\610.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\610.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\610.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...70%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\612.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\612.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\612.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\612.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\612.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\612.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\614.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\614.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\614.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\614.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\614.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\614.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\616.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\616.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\616.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\616.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\616.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\616.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\618.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\618.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\618.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\618.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\618.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\618.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...71%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\621.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\621.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\621.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\621.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\621.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\621.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\622.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\622.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\622.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\622.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\622.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\622.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\624.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\624.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\624.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\624.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\624.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\624.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\627.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\627.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\627.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\627.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\627.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\627.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...72%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\628.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\628.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\628.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\628.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\628.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\628.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\631.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\631.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\631.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\631.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\631.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\631.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\632.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\632.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\632.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\632.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\632.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\632.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\635.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\635.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\635.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\635.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\635.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\635.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...73%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\636.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\636.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\636.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\636.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\636.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\636.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\638.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\638.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\638.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\638.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\638.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\638.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\641.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\641.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\641.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\641.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\641.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\641.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\643.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\643.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\643.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\643.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\643.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\643.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...74%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\646.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\646.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\646.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\646.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\646.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\646.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\649.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\649.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\649.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\649.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\649.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\649.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\650.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\650.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\650.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\650.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\650.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\650.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\653.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\653.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\653.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\653.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\653.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\653.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...75%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\657.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\657.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\657.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\657.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\657.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\657.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\661.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\661.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\661.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\661.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\661.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\661.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\662.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\662.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\662.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\662.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\662.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\662.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\663.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\663.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\663.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\663.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\663.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\663.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...76%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\665.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\665.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\665.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\665.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\665.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\665.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\667.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\667.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\667.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\667.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\667.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\667.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\669.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\669.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\669.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\669.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\669.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\669.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\671.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\671.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\671.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\671.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\671.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\671.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...77%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\673.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\673.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\673.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\673.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\673.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\673.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\675.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\675.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\675.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\675.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\675.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\675.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\676.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\676.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\676.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\676.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\676.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\676.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\679.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\679.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\679.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\679.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\679.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\679.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...78%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\680.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\680.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\680.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\680.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\680.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\680.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\725.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\725.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\725.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\725.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\725.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\725.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\755.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\755.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\755.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\755.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\755.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\755.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\756.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\756.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\756.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\756.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\756.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\756.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...79%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\758.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\758.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\758.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\758.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\758.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\758.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\761.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\761.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\761.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\761.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\761.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\761.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\762.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\762.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\762.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\762.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\762.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\762.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\764.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\764.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\764.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\764.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\764.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\764.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...80%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\767.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\767.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\767.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\767.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\767.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\767.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\769.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\769.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\769.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\769.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\769.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\769.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\770.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\770.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\770.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\770.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\770.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\770.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\773.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\773.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\773.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\773.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\773.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\773.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...81%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\774.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\774.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\774.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\774.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\774.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\774.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\776.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\776.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\776.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\776.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\776.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\776.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\779.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\779.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\779.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\779.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\779.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\779.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\781.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\781.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\781.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\781.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\781.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\781.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...82%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\783.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\783.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\783.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\783.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\783.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\783.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\785.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\785.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\785.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\785.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\785.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\785.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\786.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\786.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\786.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\786.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\786.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\786.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\788.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\788.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\788.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\788.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\788.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\788.zlib\PNG\*.pvr"

cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...83%string%
echo ------------------------------------------------------------

md "%~dp0\Extracted Files\Textures\791.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\791.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\791.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\791.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\791.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\791.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\793.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\793.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\793.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\793.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\793.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\793.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\795.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\795.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\795.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\795.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\795.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\795.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...84%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\796.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\796.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\796.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\796.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\796.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\796.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\798.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\798.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\798.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\798.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\798.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\798.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\800.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\800.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\800.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\800.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\800.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\800.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\803.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\803.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\803.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\803.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\803.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\803.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...85%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\805.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\805.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\805.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\805.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\805.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\805.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\806.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\806.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\806.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\806.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\806.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\806.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\808.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\808.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\808.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\808.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\808.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\808.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\809.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\809.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\809.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\809.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\809.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\809.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...86%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\810.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\810.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\810.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\810.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\810.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\810.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\811.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\811.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\811.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\811.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\811.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\811.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\812.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\812.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\812.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\812.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\812.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\812.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\813.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\813.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\813.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\813.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\813.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\813.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...87%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\814.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\814.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\814.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\814.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\814.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\814.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\815.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\815.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\815.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\815.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\815.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\815.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\816.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\816.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\816.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\816.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\816.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\816.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\827.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\827.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\827.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\827.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\827.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\827.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...88%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\828.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\828.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\828.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\828.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\828.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\828.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\831.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\831.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\831.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\831.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\831.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\831.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\833.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\833.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\833.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\833.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\833.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\833.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\839.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\839.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\839.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\839.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\839.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\839.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...89%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\841.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\841.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\841.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\841.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\841.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\841.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\847.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\847.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\847.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\847.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\847.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\847.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\848.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\848.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\848.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\848.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\848.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\848.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\853.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\853.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\853.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\853.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\853.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\853.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...90%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\854.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\854.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\854.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\854.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\854.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\854.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\856.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\856.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\856.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\856.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\856.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\856.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\861.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\861.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\861.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\861.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\861.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\861.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\862.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\862.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\862.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\862.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\862.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\862.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...91%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\864.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\864.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\864.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\864.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\864.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\864.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\869.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\869.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\869.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\869.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\869.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\869.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\871.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\871.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\871.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\871.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\871.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\871.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\875.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\875.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\875.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\875.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\875.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\875.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...92%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\877.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\877.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\877.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\877.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\877.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\877.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\883.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\883.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\883.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\883.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\883.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\883.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\885.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\885.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\885.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\885.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\885.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\885.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\887.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\887.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\887.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\887.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\887.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\887.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...93%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\891.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\891.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\891.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\891.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\891.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\891.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\892.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\892.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\892.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\892.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\892.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\892.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\893.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\893.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\893.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\893.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\893.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\893.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\897.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\897.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\897.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\897.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\897.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\897.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...94%string%
echo ------------------------------------------------------------

md "%~dp0\Extracted Files\Textures\898.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\898.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\898.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\898.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\898.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\898.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\904.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\904.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\904.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\904.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\904.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\904.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\905.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\905.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\905.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\905.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\905.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\905.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\911.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\911.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\911.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\911.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\911.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\911.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...95%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\912.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\912.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\912.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\912.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\912.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\912.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\918.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\918.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\918.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\918.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\918.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\918.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\923.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\923.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\923.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\923.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\923.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\923.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\927.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\927.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\927.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\927.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\927.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\927.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...96%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\928.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\928.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\928.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\928.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\928.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\928.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\929.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\929.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\929.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\929.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\929.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\929.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\933.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\933.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\933.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\933.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\933.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\933.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\934.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\934.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\934.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\934.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\934.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\934.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...97%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\940.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\940.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\940.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\940.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\940.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\940.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\941.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\941.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\941.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\941.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\941.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\941.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\948.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\948.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\948.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\948.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\948.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\948.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...98%string%
echo ------------------------------------------------------------

md "%~dp0\Extracted Files\Textures\949.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\949.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\949.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\949.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\949.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\949.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\951.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\951.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\951.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\951.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\951.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\951.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\954.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\954.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\954.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\954.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\954.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\954.zlib\PNG\*.pvr"
cls
echo ------------------------------------------------------------
echo          PVR TO PNG CONVERSION IN PROGRESS ...99%string%
echo ------------------------------------------------------------
md "%~dp0\Extracted Files\Textures\955.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\955.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\955.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\955.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\955.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\955.zlib\PNG\*.pvr"

md "%~dp0\Extracted Files\Textures\957.zlib\PNG"
"%~dp0\Script_Tools\DOSPVR.exe" "%~dp0\Extracted Files\Textures\957.zlib\*.pvr" -Q -VF -OP "%~dp0\Extracted Files\Textures\957.zlib\PNG"
"%~dp0\Script_Tools\pvr2png.exe" -q "%~dp0\Extracted Files\Textures\957.zlib\PNG\*.pvr" "%~dp0\Extracted Files\Textures\957.zlib\PNG"
del /Q "%~dp0\Extracted Files\Textures\957.zlib\PNG\*.pvr"

del /Q "%~dp0\Script_Tools\Temp"
del /Q "%~dp0\Script_Tools\Temp2"
rmdir "%~dp0\Script_Tools\Temp"
rmdir "%~dp0\Script_Tools\Temp2"

