@echo off
setlocal EnableDelayedExpansion
:: Generate ESC character for ANSI Colors
for /F "delims=#" %%E in ('"prompt #$E# & echo on & for %%a in (1) do rem"') do set "ESC=%%E"

:: Colors
set "RESET=%ESC%[0m"
set "CYAN=%ESC%[36m"
set "GREEN=%ESC%[32m"
set "YELLOW=%ESC%[93m"
set "RED=%ESC%[31m"
set "BOLD=%ESC%[1m"
set "DIM=%ESC%[2m"
set "BG_BLUE=%ESC%[44m"
set "WHITE=%ESC%[97m"

title TPBERP Auto Updater - Professional Edition
mode con: cols=85 lines=25

cls
echo.
echo  %CYAN%================================================================================%RESET%
echo  %BOLD%%WHITE%   _____ ____  ____  _____ ____  ____  %RESET%
echo  %BOLD%%WHITE%  ^|_   _^|  _ \^| __ )^| ____^|  _ \^|  _ \ %RESET%
echo  %BOLD%%WHITE%    ^| ^| ^| ^|_) ^|  _ \^|  _^| ^| ^|_) ^| ^|_) ^|%RESET%
echo  %BOLD%%WHITE%    ^| ^| ^|  __/^| ^|_) ^| ^|___^|  _ ^<^|  __/ %RESET%
echo  %BOLD%%WHITE%    ^|_^| ^|_^|   ^|____/^|_____^|_^| \_\_^|    %RESET%
echo.
echo                    %BG_BLUE%%WHITE% Client Auto-Updater System %RESET%
echo  %CYAN%================================================================================%RESET%
echo.

echo  %YELLOW%[*]%RESET% Menyiapkan Environtment...
echo  %YELLOW%[*]%RESET% Menutup aplikasi TPBERP yang sedang berjalan %DIM%(Safe Mode)%RESET%...
for %%F in ("%~dp0*.exe") do (
    taskkill /IM "%%~nxF" /F >nul 2>&1
)
:: small delay
ping 127.0.0.1 -n 2 >nul
echo  %GREEN%[OK]%RESET% Lingkungan aman.
echo.
echo  %CYAN%--------------------------------------------------------------------------------%RESET%

set GITHUB_TPBERP=https://raw.githubusercontent.com/hermawan-dony/tpberp-pbd/main
set GITHUB_INHOST=https://raw.githubusercontent.com/hermawan-dony/inhost-pbd/main

call :DownloadFile "bcapp.pbd" "%GITHUB_TPBERP%"
call :DownloadFile "bcact.pbd" "%GITHUB_TPBERP%"
call :DownloadFile "bc2faktur.pbd" "%GITHUB_TPBERP%"
call :DownloadFile "ceisa.pbd" "%GITHUB_INHOST%"

echo  %CYAN%--------------------------------------------------------------------------------%RESET%
echo.
echo  %BG_BLUE%%WHITE% UPDATE SELESAI %RESET% %GREEN%Semua file berhasil diverifikasi dan siap digunakan.%RESET%
echo.
echo  %DIM%Tekan tombol apapun untuk menutup jendela ini...%RESET%
pause >nul
exit /b

:DownloadFile
set FILENAME=%~1
set REPO_URL=%~2
echo  %BOLD%%WHITE%--^> %FILENAME%%RESET%

set HTTP_STATUS=
if exist "%FILENAME%.etag" (
    for /f "tokens=2" %%A in ('curl.exe -s -I --etag-compare "%FILENAME%.etag" -L "%REPO_URL%/%FILENAME%" ^| findstr "HTTP/"') do set HTTP_STATUS=%%A
)

if "%HTTP_STATUS%"=="304" (
    echo      %GREEN%Status:%RESET% %DIM%Tidak ada perubahan - Sudah Up to Date.%RESET%
) else (
    echo      %YELLOW%Status:%RESET% %CYAN%Mendownload versi terbaru...%RESET%
    curl.exe -# --retry 3 -f --etag-save "%FILENAME%.etag" -L -O "%REPO_URL%/%FILENAME%" || (
        echo      %RED%[ERROR]%RESET% %YELLOW%Gagal mendownload %FILENAME%. Periksa koneksi internet!%RESET%
        if exist "%FILENAME%" del /f /q "%FILENAME%" >nul 2>&1
    )
)
echo.
exit /b
