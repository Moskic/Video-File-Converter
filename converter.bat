@echo off

:loop
if "%~1"=="" goto :end

set input=%~1
set output=%~dpn1.mp4

rem Get the extension of the input file
set extension=%~x1

rem Check if the extension is .ts, .mkv or .flv
if /I "%extension%"==".ts" (
    rem Convert .ts file to .mp4 file
    %~dp0ffmpeg -i "%input%" -c:v copy -c:a copy "%output%"
) else if /I "%extension%"==".mkv" (
    rem Convert .mkv file to .mp4 file
    %~dp0ffmpeg -i "%input%" -c:v copy -c:a copy "%output%"
) else if /I "%extension%"==".flv" (
    rem Convert .flv file to .mp4 file
    %~dp0ffmpeg -i "%input%" -c:v copy -c:a copy "%output%"
) else (
    echo Unsupported file type: %extension%
)

shift
goto :loop

:end
pause