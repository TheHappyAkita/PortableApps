echo off 

SET TMP_APP_FOLDER=IntelliJ_2016.3.0

SET USERPROFILE=%~dp0\..\Data\USERPROFILE
SET HOMEPATH=%~p0\..\Data\USERPROFILE
SET HOMEDRIVE=%~d0
SET _JAVA_OPTIONS=-Duser.home=%~dp0\..\Data\USERPROFILE

set PA_JAVA_DIR="%~dp0\..\..\CommonFiles\Java"
if exist "%PA_JAVA_DIR%\bin\javaw.exe" (
  set "JAVA_HOME=%PA_JAVA_DIR%"
  set "PATH=%JAVA_HOME%;%PATH%"
) 

cd %~dp0/%TMP_APP_FOLDER%
start .\bin\idea.exe
rem start .\bin\idea64.exe