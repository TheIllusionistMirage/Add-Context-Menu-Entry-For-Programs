@echo off

set /p entryName="Enter the name of the context menu item you would like to delete (e.g., Open Git Bash Here): "

@Rem Remove Registry entries

echo.
echo Removing Registry entry "HKCU\Software\Classes\Directory\shell\%entryName%"...
reg delete "HKCU\Software\Classes\Directory\shell\%entryName%" /f

echo.
echo Removing Registry entry "HKCU\Software\Classes\Directory\Background\shell\%entryName%"...
reg delete "HKCU\Software\Classes\Directory\Background\shell\%entryName%" /f

echo.
echo Removing Registry entry "HKCU\Software\Classes\LibraryFolder\Background\shell\%entryName%"...
reg delete "HKCU\Software\Classes\LibraryFolder\Background\shell\%entryName%" /f

echo.
echo Removing entry icon "%LOCALAPPDATA%\context-menu-installer\%entryName%"...
@RD /S /Q "%LOCALAPPDATA%\context-menu-installer\%entryName%"

echo.
echo.
echo [SUCCESS] Removal of context menu item "%entryName%" successful. Right clicking on any directory will not have the menu item "%entryName%" anymore.

echo.
echo.
pause