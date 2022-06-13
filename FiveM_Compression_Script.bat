@echo off

cls

chcp
chcp 65001 > nul
chcp

cls

echo ###########################################
echo ### Compression script for FiveM server ###
echo ###         Designed by Trauzer         ###
echo ###           Polish version            ###
echo ###    (ENG/multi-lang coming soon)     ###
echo ###########################################

echo.
echo.
echo.

set batFilePath=%cd%

echo Wybierz ścieżke programu "NVIDIA Texture Tools"
set programPath="C:\Program Files\NVIDIA Corporation\NVIDIA Texture Tools"
echo Podstawowa ścieżka to %programPath%

echo.

echo Podaj ścieżke (zostaw puste jeśli ścieżka podana powyżej jest poprawna):
set "newPath="
set /P newPath=

IF not defined newPath (
    goto checkFiles
)

set programPath=%newPath%


:checkFiles

cls

cd %programPath%

if errorlevel 1 (
    echo Błędna ścieżka! Egekucja programu zostaje przerwana.
    goto quit
)

if EXIST "nvbatchcompress.exe" (
    goto selectTypeOfCompression
)


echo Brak pliku "nvbatchcompress.exe" w %programPath%


:selectTypeOfCompression

echo Wybierz typ kompresji: 
echo.
echo 1) Kompresja RGB (Z kanałem alpha) (ten najgorszy :) )
echo 2) Kompresja DXT1/BC1 (Bez kanału alpha) (najlepszy)
echo 3) Kompresja DXT5/BC3 (Z kanałem alpha) (średni)

set "compressionOption="
set /P compressionOption=

IF not defined compressionOption (
    goto execProgram
)

IF %compressionOption% EQU 1 set compression=-rgb
IF %compressionOption% EQU 2 set compression=-bc1
IF %compressionOption% EQU 3 set compression=-bc3

echo.

:speedOfCompression

echo Wybierz dokładność kompresji
echo.
echo 1) Najszybsza (Najgorsza)
echo 2) Normalna
echo 3) Najlepsza (Najwolniesza)

set "speedOption="
set /P speedOption=

IF not defined speedOption (
    goto speedOfCompression
)

IF %speedOption% EQU 1 set speedCompress=-fast
IF %speedOption% EQU 2 set speedCompress=-production
IF %speedOption% EQU 3 set speedCompress=-highest

echo.

:pathToDir

echo Wskaż folder z teksturami do skompresowania (podstawowa ścieżka to ścieżka skryptu z folderem "textures")

set "pathToTextures="
set /P pathToTextures=

IF not defined pathToTextures (
    set pathToTextures="%batFilePath%/textures"
    goto execProgram
)

cls

:execProgram

echo %compression% %speedCompress% %pathToTextures%

nvbatchcompress.exe %compression% %speedCompress% %pathToTextures%

:quit
pause
