echo off 

rem ##### version specific variables ######
SET TMP_JAVA_VER=jdk1.8.0_74_x64
SET TMP_APP_FOLDER=IntelliJIDEA_UltimateEdition_2017.1.0


rem ##### prepare environment variables #####
SET TMP_USERPROFILE=%~dp0\..\Data\USERPROFILE
SET TMP_HOMEPATH=%~p0\..\Data\USERPROFILE
SET TMP__JAVA_OPTIONS=-Duser.home=%~dp0\..\Data\USERPROFILE
SET TMP_JAVA_HOME = ""

set PA_JAVA_DIR="%~dp0\..\..\CommonFiles\Java"
if exist "%PA_JAVA_DIR%\bin\javaw.exe" (
  set "TMP_JAVA_HOME=%PA_JAVA_DIR%"
) 

set PA_JAVA_DIR="%~dp0\..\..\..\..\..\development\_lang\java\%TMP_JAVA_VER%\"
if exist "%PA_JAVA_DIR%\bin\javaw.exe" (
  set "TMP_JAVA_HOME=%PA_JAVA_DIR%"
)

rem ##### resolve relative paths and set environment #####
pushd "%TMP_USERPROFILE%"
set USERPROFILE=%CD%
popd

pushd "%TMP_HOMEPATH%"
set HOMEPATH=%CD:~2%
popd

set HOMEDRIVE="%~d0"

set _JAVA_OPTIONS=-Duser.home=%USERPROFILE%

pushd "%TMP_JAVA_HOME%"
set JAVA_HOME=%CD%
popd

set "PATH=%JAVA_HOME%;%PATH%"


rem ##### change workidn dir and start ######
cd %~dp0/%TMP_APP_FOLDER%
start .\bin\idea.exe
rem start .\bin\idea64.exe