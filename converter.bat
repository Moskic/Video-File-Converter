@echo off
setlocal DisableDelayedExpansion

set "pauseAtEnd=1"
set /a success=0, failed=0, skipped=0

if /I "%~1"=="--no-pause" (
    set "pauseAtEnd=0"
    shift
)

if "%~1"=="" (
    echo Usage: %~nx0 [--no-pause] ^<video-file^> [video-file ...]
    set /a failed+=1
    goto :summary
)

if exist "%~dp0ffmpeg.exe" (
    set "ffmpegPath=%~dp0ffmpeg.exe"
    goto :process_arguments
)

where ffmpeg.exe >nul 2>&1
if errorlevel 1 (
    echo Error: ffmpeg.exe was not found next to this script or in PATH.
    set /a failed+=1
    goto :summary
)
set "ffmpegPath=ffmpeg.exe"

:process_arguments
if "%~1"=="" goto :summary
call :process_file "%~1"
shift
goto :process_arguments

:process_file
set "input=%~f1"
set "output=%~dpn1.mp4"
set "extension=%~x1"

if not exist "%input%" (
    echo Failed: input file does not exist: "%input%"
    set /a failed+=1
    exit /b
)

if exist "%input%\" (
    echo Failed: input is not a file: "%input%"
    set /a failed+=1
    exit /b
)

if /I "%extension%"==".ts" goto :supported_file
if /I "%extension%"==".mkv" goto :supported_file
if /I "%extension%"==".flv" goto :supported_file

echo Failed: unsupported file type: "%input%"
set /a failed+=1
exit /b

:supported_file
if exist "%output%" (
    echo Skipped: output file already exists: "%output%"
    set /a skipped+=1
    exit /b
)

echo Converting: "%input%"
"%ffmpegPath%" -n -i "%input%" -c:v copy -c:a copy "%output%"
if errorlevel 1 goto :conversion_failed

echo Success: "%output%"
set /a success+=1
exit /b

:conversion_failed
if exist "%output%" del /q "%output%" >nul 2>&1
echo Failed: FFmpeg could not convert: "%input%"
set /a failed+=1
exit /b

:summary
echo.
echo Summary: %success% succeeded, %failed% failed, %skipped% skipped.

set "exitCode=0"
if %failed% GTR 0 set "exitCode=1"
if "%pauseAtEnd%"=="1" pause

endlocal & exit /b %exitCode%
