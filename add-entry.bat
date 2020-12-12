@echo off

@Rem This Batch script is a one click solution (with some minor user input)
@Rem for adding entries to the Windows context menu (the menu you see when
@Rem you right click on any directory).

@Rem This is mainly intended for use when initially setting up a
@Rem development environment on Windows and you want to add shell programs
@Rem (Git Bash, Powershell, Windows Terminal, etc.) to the context menu.

set installPath=%LOCALAPPDATA%\context-menu-installer
set /p entryName="Enter the exact name as you would like it to appear in the context menu (e.g., Open Git Bash Here): "
set /p iconFilePath="Enter the absolute path of the icon (.ICO file) for the context menu entry: "
set /p program="Enter the command (including any arguments/options, if any) to start the program (e.g., "C:\Program Files\Git\git-bash.exe" starts the Git Bash terminal in the directory from which it was invoked): "

@Rem Get just the file name for the icon file for later use 
for %%i in ("%iconFilePath:\=" "%") do set "iconFileName=%%~i"

echo.
echo Creating installation directory "%installPath%\%entryName%"...
mkdir "%installPath%\%entryName%"

echo.
echo Copying icon file "%iconFilePath%" to "%installPath%\%entryName%"...

echo.
copy %iconFilePath% "%installPath%\%entryName%"

echo.
echo Adding registry entries for the context menu entry "%entryName%"...

echo.
echo Adding registry key "HKCU\Software\Classes\Directory\shell\%entryName%" with value "%installPath%\%entryName%\%iconFileName%"...
reg add "HKCU\Software\Classes\Directory\shell\%entryName%" /v icon /d "%installPath%\%entryName%\%iconFileName%" /f

echo.
echo Adding registry key "HKCU\Software\Classes\Directory\shell\%entryName%\command" with value "%program%"...
reg add "HKCU\Software\Classes\Directory\shell\%entryName%\command" /d "%program%" /f

echo.
echo Adding registry key "HKCU\Software\Classes\Directory\Background\shell\%entryName%" with value "%installPath%\%entryName%\%iconFileName%"...
reg add "HKCU\Software\Classes\Directory\Background\shell\%entryName%" /v icon /d "%installPath%\%entryName%\%iconFileName%" /f

echo.
echo Adding registry key "HKCU\Software\Classes\Directory\Background\shell\%entryName%\command" with value "%program%"...
reg add "HKCU\Software\Classes\Directory\Background\shell\%entryName%\command" /d "%program%" /f

echo.
echo Adding registry key "HKCU\Software\Classes\LibraryFolder\Background\shell\%entryName%" with value "%installPath%\%entryName%\%iconFileName%"...
reg add "HKCU\Software\Classes\LibraryFolder\Background\shell\%entryName%" /v icon /d "%installPath%\%entryName%\%iconFileName%" /f

echo.
echo Adding registry key "HKCU\Software\Classes\LibraryFolder\Background\shell\%entryName%\command"  with value "%program%"...
reg add "HKCU\Software\Classes\LibraryFolder\Background\shell\%entryName%\command" /d "%program%" /f

echo.
echo.
echo [SUCCESS] Creation of context menu item "%entryName%" successful! Right clicking on any directory should have the menu item "%entryName%" now!

echo.
echo.
pause