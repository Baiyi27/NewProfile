@echo off

rem Specify the registry key to uninstall
set "registryKey=HKEY_CLASSES_ROOT\Directory\Background\shell\SkyEye64"

rem Uninstall the registry key
reg delete "%registryKey%" /f

echo Registry key %registryKey% has been uninstalled.

pause