@echo off

@REM Check if MSYS2_PATH is set in the system environment variables
if not defined MSYS2_PATH (
    setx /m MSYS2_PATH "D:\Tools\MSYS2"
    echo 'MSYS2_PATH' is set to 'D:\Tools\MSYS2',please restart
) else (
    @REM echo 'MSYS2_PATH' already exists with value: %MSYS2_PATH%
)

@REM Call msys2_shell.cmd with the appropriate arguments
call "%MSYS2_PATH%\msys2_shell.cmd" -use-full-path -defterm -here -no-start -mingw64