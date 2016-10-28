@echo off

SET TMP_SQUIRREL_VERSION=3.7.1-standard

REM USERPROFILE=%~dp0\..\Data\USERPROFILE
SET HOMEPATH=%~p0\..\Data\USERPROFILE
SET HOMEDRIVE=%~d0

set "PA_JAVA_DIR="%~dp0\..\..\CommonFiles\Java""
if exist "%PA_JAVA_DIR%\bin\javaw.exe" (
  set "JAVA_HOME=%PA_JAVA_DIR%"
  set "PATH=%JAVA_HOME%;%PATH%"
)

set "SETTINGS_DIR="%~dp0\DefaultData\settings\squirrel-sql""
set "DB_DRIVERS_DIR="%~dp0\..\Data\db-drivers""
set "DB_DRIVERS_LIST="

SET _JAVA_OPTIONS=-Djava.io.tmpdir=%SETTINGS_DIR% -Duser.home=%SETTINGS_DIR% 

setlocal EnableDelayedExpansion
for /L %%n in (1 1 500) do if "!__cd__:~%%n,1!" neq "" set /a "len=%%n+1"
setlocal DisableDelayedExpansion
for /r %DB_DRIVERS_DIR% %%g in (*.jar) do (
  set "absPath=%%g"
  setlocal EnableDelayedExpansion
  set "relPath=!absPath:~%len%!"
  set "DB_DRIVERS_LIST=!absPath!;!DB_DRIVERS_LIST!"
)

echo "%DB_DRIVERS_LIST%"

cd %~dp0

.\squirrel-sql-%TMP_SQUIRREL_VERSION%\squirrel-sql.bat %*
