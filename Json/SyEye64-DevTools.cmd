@echo off

rem check variable exist?
if not defined SKYEYE_MINGW64_HOME (
    setx SKYEYE_MINGW64_HOME %CD%\mingw64
    rem echo SKYEYE_MINGW64_HOME is set to %CURRENT_DIRECTORY%\mingw64
) else (
    rem echo SKYEYE_MINGW64_HOME already exists with value: %EXISTING_VARIABLE%
)

rem Display the path of the mingw64 folder
echo Welcome to SkyEye 64-bit (SDK) Development tools.
call %SKYEYE_MINGW64_HOME%\..\msys2_shell.cmd -mingw64 -use-full-path -defterm -here -no-start 

