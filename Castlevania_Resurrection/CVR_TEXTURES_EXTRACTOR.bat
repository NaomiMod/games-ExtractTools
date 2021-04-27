@echo off
cls
title Castlevania Resurrection PVR Extractor Ver 1.0
echo -----------------------------------------------
echo Castlevania Resurrection PVR Extractor Ver 1.0
echo by VincentNL
echo -----------------------------------------------
cd %~dp0
md Textures
"%~dp0/Script/quickbms.exe" -K -d -Y "%~dp0/Script/CASTLEVANIAR_PVR_EXTRACTOR.bms" "%~dp0\*.bin" "%~dp0\Textures"

del /Q "%~dp0\Textures/1ST_READ.BIN"
rmdir "%~dp0\Textures/1ST_READ.BIN"
del /Q "%~dp0\Textures/bootsector/IP.BIN"
rmdir "%~dp0\Textures/bootsector/IP.BIN"
del /Q "%~dp0\Textures/bootsector"
rmdir "%~dp0\Textures/bootsector"