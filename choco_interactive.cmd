@ECHO off
SETLOCAL
SET e=
SET /P COMMANDS="%e%[32m > choco "
ECHO %e%[0m
IF /I "%COMMANDS%"=="exit" GOTO:EOF
IF /I "%COMMANDS%"=="help" (choco.exe -?) ELSE (choco.exe %COMMANDS%)
ENDLOCAL
%~f0