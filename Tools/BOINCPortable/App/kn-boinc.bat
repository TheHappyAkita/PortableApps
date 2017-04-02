@echo off

SET TMP_USERPROFILE=%~dp0\..\Data\USERPROFILE
SET TMP_HOMEPATH=%~p0\..\Data\USERPROFILE

rem ##### resolve relative paths and set environment #####
pushd "%TMP_USERPROFILE%"
set USERPROFILE=%CD%
popd

pushd "%TMP_HOMEPATH%"
set HOMEPATH=%CD:~2%
popd

set HOMEDRIVE="%~d0"

SET
PAUSE

%~dp0\BOINC\boincmgr.exe
exit