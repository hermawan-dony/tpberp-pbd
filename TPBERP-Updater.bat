@echo off
color 0B
title TPBERP Auto Updater

echo.
echo  ======================================================
echo   _____ ____  ____  _____ ____  ____  
echo  ^|_   _^|  _ \^| __ )^| ____^|  _ \^|  _ \ 
echo    ^| ^| ^| ^|_) ^|  _ \^|  _^| ^| ^|_) ^| ^|_) ^|
echo    ^| ^| ^|  __/^| ^|_) ^| ^|___^|  _ ^<^|  __/ 
echo    ^|_^| ^|_^|   ^|____/^|_____^|_^| \_\_^|    
echo.
echo      [ Client Auto-Updater System ]
echo  ======================================================
echo.

echo  --^> Menutup aplikasi yang berjalan agar update aman...
for %%F in ("%~dp0*.exe") do (
    taskkill /IM "%%~nxF" /F >nul 2>&1
)
echo.

set GITHUB_TPBERP=https://raw.githubusercontent.com/hermawan-dony/tpberp-pbd/main
set GITHUB_INHOST=https://raw.githubusercontent.com/hermawan-dony/inhost-pbd/main

call :DownloadFile "bcapp.pbd" "%GITHUB_TPBERP%"
echo.
call :DownloadFile "bcact.pbd" "%GITHUB_TPBERP%"
echo.
call :DownloadFile "custom.pbd" "%GITHUB_TPBERP%"
echo.
call :DownloadFile "bc2faktur.pbd" "%GITHUB_TPBERP%"
echo.
call :DownloadFile "ceisa.pbd" "%GITHUB_INHOST%"
echo.

echo  ======================================================
echo   [!] Update Selesai! Semua file siap digunakan.
echo  ======================================================
echo.
pause
exit /b

:DownloadFile
set FILENAME=%~1
set REPO_URL=%~2
echo  --^> Memeriksa [ %FILENAME% ] ...

set HTTP_STATUS=
if exist "%FILENAME%.etag" (
    for /f "tokens=2" %%A in ('curl.exe -s -I --etag-compare "%FILENAME%.etag" -L "%REPO_URL%/%FILENAME%" ^| findstr "HTTP/"') do set HTTP_STATUS=%%A
)

if "%HTTP_STATUS%"=="304" (
    echo      -^> Sudah Up to Date
) else (
    curl.exe -# --etag-save "%FILENAME%.etag" -L -O "%REPO_URL%/%FILENAME%"
    if %errorlevel% neq 0 (
        echo      [x] Gagal mendownload %FILENAME%. Silakan cek koneksi internet!
    )
)
exit /b
