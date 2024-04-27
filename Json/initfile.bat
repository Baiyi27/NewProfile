@echo off
setlocal

set "backupFolder=backup"
set "includeFolder=include"
set "srcFolder=src"

rem Check if folders exist, create if not exist
if not exist "%backupFolder%" (
    mkdir "%backupFolder%"
    echo Created folder: %backupFolder%
)

if not exist "%includeFolder%" (
    mkdir "%includeFolder%"
    echo Created folder: %includeFolder%
)

if not exist "%srcFolder%" (
    mkdir "%srcFolder%"
    echo Created folder: %srcFolder%
)

rem Create Makefile and CMakeLists.txt files
echo Creating Makefile...
echo. > Makefile
echo Created Makefile 

echo Creating CMakeLists.txt...
echo. > CMakeLists.txt
echo Created CMakeLists.txt 

rem Prompt the user whether to delete the script
set /p deleteScript=Do you want to delete this script (y/n)?
if /i "%deleteScript%"=="y" (
    del "%~f0"
    echo Script deleted.
) else (
    echo Script not deleted.
)

endlocal

