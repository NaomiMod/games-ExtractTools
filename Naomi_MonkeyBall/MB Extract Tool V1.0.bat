@echo off
cls
title MONKEY BALL - NAOMI Resources Extractor Ver 1.0
echo -----------------------------------------------
echo MONKEY BALL - NAOMI Resources Extractor Ver 1.0
echo by Vincent
echo -----------------------------------------------


SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

CD %~dp0
del /Q %~dp0\Script_Tools\Temp\*.*
cd .\Script_Tools
chdman extractcd -i %~dp0\CHD\gds-0008.chd -o %~dp0\CHD\FILE.gdi
cls
echo(

call :ColorText 4e "DO NOT CLOSE THIS WINDOW!"

goto :Beginoffile

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof

:Beginoffile

@echo off
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
echo 2) Right click on BALL.bin and "Decrypt & Extract"
echo.
echo 3) Use Monkey Ball DES key *google* , and save BALL.BIN in CHD folder
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
@echo off
"quickbms.exe" -K -Y "%~dp0\Script_Tools\MONKEY BALL CHUNK EXTRACT.bms" "%~dp0\CHD\BALL.dat" "%~dp0\Script_Tools\Temp"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Models_1.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Models_2.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Models_3.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Models_4.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Models_5.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Models_6.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Models_7.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Models_8.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Models_9.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Models_10.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Textures_1.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Textures_2.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Textures_3.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Textures_4.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Textures_5.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Textures_6.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Textures_7.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Textures_8.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Textures_9.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\BG_Textures_10.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Common_Models_1.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Common_Models_2.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Common_Textures_1.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Common_Textures_2.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_1.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_2.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_3.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_4.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_5.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_6.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_7.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_8.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_9.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_10.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_11.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_12.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Models_13.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_1.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_2.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_3.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_4.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_5.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_6.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_7.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_8.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_9.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_10.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_11.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_12.lz"
"SMB_LZ_Tool.exe" "%~dp0\Script_Tools\Temp\Level_Textures_13.lz"
cd %~dp0\Script_Tools\Temp
del *.lz
ren *.lz.raw *.
ren *.lz *.
CD %~dp0
cd Script_Tools
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Common_Models_1" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Common_Models_2" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Models_1" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Models_2" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Models_3" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Models_4" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Models_5" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Models_6" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Models_7" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Models_8" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Models_9" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Models_10" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_1" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_2" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_3" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_4" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_5" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_6" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_7" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_8" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_9" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_10" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_11" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_12" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL MODELS EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Models_13" "%~dp0\EXTRACTED FILES\Models"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Textures_1" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Textures_2" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Textures_3" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Textures_4" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Textures_5" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Textures_6" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Textures_7" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Textures_8" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Textures_9" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\BG_Textures_10" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Common_Textures_1" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Common_Textures_2" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_1" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_2" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_3" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_4" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_5" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_6" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_7" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_8" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_9" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_10" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_11" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_12" "%~dp0\EXTRACTED FILES\Textures"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL TEXTURE EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Textures_13" "%~dp0\EXTRACTED FILES\Textures"

xcopy "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_1\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_2\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_3\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_4\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_5\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_6\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_7\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_8\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_9\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10\*.pvr" "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\BG_Textures_10\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1"
del /Q "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Common_Textures_1\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2"
del /Q "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Common_Textures_2\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_1\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_2\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_3\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_4\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_5\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_6\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_7\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_8\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_9\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_10\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_11\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_12\PVR\*.bak"

xcopy "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13\PVR\"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13\PVR\*.pvr" -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13\PVR"
"DOSPVR.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13\PVR\*.pvr" -VF -OP "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13"
"pvr2png.exe" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13\*.pvr" "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13\*.bak"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13\*.pvr"
del /Q "%~dp0\EXTRACTED FILES\Textures\Level_Textures_13\PVR\*.bak"

"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_1" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_2" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_3" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_4" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_5" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_6" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_7" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_8" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_9" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_10" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_11" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_12" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -d -K -Y "MONKEY BALL LAYOUT EXTRACT.bms" "%~dp0\Script_Tools\Temp\Level_Layouts_13" "%~dp0\EXTRACTED FILES\Level_Def"
"quickbms.exe" -Q -Y "MONKEY BALL SPSD EXTRACT.bms" "%~dp0\CHD\BALL.dat" "%~dp0\EXTRACTED FILES\Music"
"quickbms.exe" -Q -Y "MONKEY BALL DTPK EXTRACT.bms" "%~dp0\CHD\BALL.dat" "%~dp0\EXTRACTED FILES\Sounds"
xcopy "%~dp0\Script_Tools\Temp\UNKN_Monkey_1.bin" "%~dp0\EXTRACTED FILES\UNK\"
xcopy "%~dp0\Script_Tools\Temp\UNKN_Monkey_2.bin" "%~dp0\EXTRACTED FILES\UNK\"
xcopy "%~dp0\Script_Tools\Temp\UNKN_Monkey_3.bin" "%~dp0\EXTRACTED FILES\UNK\"

del /Q %~dp0\Script_Tools\Temp\*.*
del /Q %~dp0\CHD\BALL.dat
del /Q %~dp0\CHD\FILE.gdi
del /Q %~dp0\CHD\FILE01.bin
del /Q %~dp0\CHD\FILE03.bin
del /Q %~dp0\CHD\FILE02.raw