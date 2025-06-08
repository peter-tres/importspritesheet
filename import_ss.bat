@echo off
setlocal


set SCRIPT_PATH="%~dp0script.lua"
set ASEPRITE="C:\Program Files (x86)\Steam\steamapps\common\aseprite\Aseprite.exe"

for %%F in (*.png) do (
    echo Processing %%F...
    %ASEPRITE% -b "%%F" --script-param filename="%%F" --script %SCRIPT_PATH%
)

endlocal
pause
