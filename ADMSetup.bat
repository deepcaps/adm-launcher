@echo off
title ADMSetup
color 09
cls


set waiting_time=5
:: Set current path
set cp=%~dp0

echo.
echo.
echo.
echo                                       **************************************
echo                                        *         ADMIN LAUNCHER SETUP       *	
echo                                         *            by @deepcaps            *
echo                                          **************************************
echo.
echo.

echo [^>] Press enter to continue
echo. 
pause>nul

set /p admin_password="[>] Create the new Administrator password (don't leave blank): "
echo.


:: Check if ADMLauncher it already installed
echo [*] Delete old ADM directory ...
if exist C:\ADMLauncher\ (
    :: Disable protections on ADMLauncher directory
    attrib /D -S -H -R C:\ADMLauncher
    :: Delete old ADMLauncher directory
    del C:\ADMLauncher\icon.ico
    del C:\ADMLauncher\ADMLauncher.exe
    rmdir C:\ADMLauncher\
)
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to delete directory
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Copy new ADMLauncher directory
echo [*] Copy files...
xcopy /I /E %cp%ADMLauncher\ C:\ADMLauncher\
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to copy files
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Protect ADMLauncher directory
echo [*] Protect ADMLauncher directory...
attrib /D +S +H +R C:\ADMLauncher
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to copy files
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Active the Administrator account
echo [*] Activate the administrator account...
net user Administrateur /active:yes
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to activate the administrator account
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Set password of Administrator account (%admin_password%)
echo [*] Set password of administrator account...
net user Administrateur %admin_password%
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to set password of administrator account
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Add Administrator account to Administrators group
echo [*] Add administrator account in Administrators group...
net localgroup Administrateurs Administrateur /add
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to add administrator account in Administrators group
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Copy ADMLauncher shortcut (create desktop shortcut)
echo [*] Create desktop shortcut...
copy %cp%ADMLauncher.lnk C:\Users\Public\Desktop\ADMLauncher.lnk
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to create desktop shortcut
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Copy ADMLauncher shortcut (create start menu shortcut)
echo [*] Create start menu shortcut...
copy %cp%ADMLauncher.lnk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\ADMLauncher.lnk"
attrib +S -H +R "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\ADMLauncher.lnk"
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to create start menu shortcut
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Add ADMLauncher in path
echo [*] Add ADMLauncher in path...
setx /M path "%path%C:\ADMLauncher"
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to add ADMLauncher in path
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Add ADMLauncher to context menu (title)
echo [*] Add option in context menu (title)...
reg add HKEY_CLASSES_ROOT\*\shell\ADMLauncher /ve /t REG_SZ /d "Open in ADM mode" /f
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to add option in context menu (title)
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Add ADMLauncher to context menu (icon)
echo [*] Add option in context menu (icon)...
reg add HKEY_CLASSES_ROOT\*\shell\ADMLauncher /v "icon" /t REG_SZ /d "C:\ADMLauncher\icon.ico" /f
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to add option in context menu (icon)
)
timeout -nobreak -t %waiting_time% >nul
echo.

:: Add ADMLauncher to context menu (command)
echo [*] Add option in context menu (command)...
reg add HKEY_CLASSES_ROOT\*\shell\ADMLauncher\command /ve /t REG_SZ /d "C:\ADMLauncher\ADMLauncher.exe %%1 %%2 %%3 %%4 %%4 %%5 %%6 %%7 %%8 %%9" /f
if %errorlevel% == 0 (
    color 02
    echo [+] SUCCESS !
) else (
    color 0C
    echo [-] Failed to add option in context menu (command)
)
timeout -nobreak -t %waiting_time% >nul
echo.
echo.


color 0D
echo [+] END OF PROCESS !
echo Press [ENTER] to exit and restart the computer
pause>nul

echo.
choice /M "Restart the computer" /C yn /T 5 /D y
if %ERRORLEVEL% == 1 (
    shutdown /r /t 3
)

color 07
exit