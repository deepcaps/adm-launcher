@echo off
title ADMLauncher
color 0D
cls


set program_path=%1 %2 %3 %4 %5 %6 %7 %8 %9

:: If not defined
if DEFINED program_path (
	:: If empty
	if  "%program_path%"=="        " (
		goto askrun
	) else (
		goto argrun
	)
) else (
	goto askrun
)


:askrun
mode con cols=65 lines=12

echo.
echo.
echo.
echo             **************************************
echo             *           ADMIN LAUNCHER           *	
echo             *            by @deepcaps            *
echo             **************************************
echo.
echo.

set /p program_path="[>] Enter program path (or drag file): "
echo.
goto end


:argrun
mode con cols=65 lines=11

echo.
echo.
echo.
echo             **************************************
echo             *           ADMIN LAUNCHER           *	
echo             *            by @deepcaps            *
echo             **************************************
echo.
echo.
goto end


:end
runas /user:%COMPUTERNAME%\Administrateur "%program_path%" && (
	cls
	color 02
	mode con cols=65 lines=8
	echo.
	echo.
	echo.
	echo               ^> The program started successfully ! ^<
) || (
	cls
	color 0C
	mode con cols=65 lines=8
	echo.
	echo.
	echo.
	echo                   ^> Error in path or password ^<
)

ping -n 5 localhost>nul
color 07
exit