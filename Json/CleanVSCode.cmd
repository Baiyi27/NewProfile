@REM example:
@REM del "%userprofile%/AppData/Local/Microsoft/vscode-cpptools/ipch/" /s /q /f
@REM rd "%userprofile%/AppData/Local/Microsoft/vscode-cpptools/ipch/" /s /q
@REM md "%userprofile%/AppData/Local/Microsoft/vscode-cpptools/ipch/"
@echo off

set "base_path=%userprofile%\AppData\Roaming\Code"

call:EmptyOneDir "%base_path%CachedExtensionVSIXs"
call:EmptyOneDir "%base_path%Cache"
call:EmptyOneDir "%base_path%CachedData"
call:EmptyOneDir "%base_path%CachedExtensions"
call:EmptyOneDir "%base_path%Code Cache"
call:EmptyOneDir "%base_path%Crashpad"
call:EmptyOneDir "%base_path%logs"
call:EmptyOneDir "%base_path%Service Worker\CacheStorage"
call:EmptyOneDir "%base_path%Service Worker\ScriptCache"
call:EmptyOneDir "%base_path%User\workspaceStorage"
@REM call:EmptyOneDir "%base_path%Code\User\History"

set "vscode_local_path=%userprofile%\AppData\Local\Microsoft\vscode-cpptools"
call:EmptyOneDir "%vscode_local_path%\ipch"

goto end

:EmptyOneDir
    echo empty %1
    echo del %1 /s /q /f
    del %1 /s /q /f
    echo rd %1 /s /q
    rd %1 /s /q
    echo md %1
    md %1
:end
