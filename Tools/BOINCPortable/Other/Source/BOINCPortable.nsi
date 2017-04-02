;Copyright (C) 2008-2009 Marcus Koerner (olum)


!define PORTABLEAPPNAME "BOINC Portable"
!define NAME "BOINCPortable"
!define APPNAME "BOINCPortable"
!define VER "0.1.6.1018"
!define WEBSITE ""
;!define DEFAULTEXE "boincstart.bat"
!define DEFAULTAPPDIR "\App\BOINC\"
!define DEFAULTSETTINGSPATH "settings"

;=== Program Details
Name "${PORTABLEAPPNAME}"
OutFile "..\..\${NAME}.exe"
;Caption "${PORTABLEAPPNAME} | PortableApps.com"
VIProductVersion "${VER}"
VIAddVersionKey ProductName "${PORTABLEAPPNAME}"
;VIAddVersionKey Comments "Allows ${APPNAME} to be run from a removable drive.  For additional details, visit ${WEBSITE}"
;VIAddVersionKey CompanyName ""
VIAddVersionKey LegalCopyright "PortableApps.com Installer Copyright 2007-2008 PortableApps.com."
VIAddVersionKey FileDescription "${PORTABLEAPPNAME}"
VIAddVersionKey FileVersion "${VER}"
VIAddVersionKey ProductVersion "${VER}"
VIAddVersionKey InternalName "${PORTABLEAPPNAME}"
;VIAddVersionKey LegalTrademarks "PortableApps.com is a Trademark of Rare Ideas, LLC."
VIAddVersionKey OriginalFilename "${NAME}.exe"
;VIAddVersionKey PrivateBuild ""
;VIAddVersionKey SpecialBuild ""

;=== Runtime Switches
CRCCheck On
WindowIcon Off
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user

;=== Best Compression
SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On

;=== Include
!include "Registry.nsh"

;=== Program Icon
Icon "..\..\App\AppInfo\appicon.ico"

;=== Icon & Stye ===
;!define MUI_ICON "..\..\App\AppInfo\appicon.ico"

;=== Languages
;!insertmacro MUI_LANGUAGE "English"
!include "PortableApps.comLauncherLANG_ENGLISH.nsh"

;=== Var
Var SETTINGSDIRECTORY   ;Folder of all Settings
Var FAILEDTORESTOREKEY

Section "Main"
	;=== set var
	StrCpy $SETTINGSDIRECTORY "$EXEDIR\Data\${DEFAULTSETTINGSPATH}"
	
	;=== Splash shown
	InitPluginsDir
	File /oname=$PLUGINSDIR\splash.jpg "${NAME}.jpg"
			newadvsplash::show /NOUNLOAD 1500 200 0 -1 /L $PLUGINSDIR\splash.jpg

	;=== Check if already running
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${NAME}2") i .r1 ?e'
	Pop $0
	StrCmp $0 0 CheckForInI WarnAnotherInstance
	
	;=== WarnAnotherInstance:
	WarnAnotherInstance:
	MessageBox MB_OK|MB_ICONINFORMATION `$(LauncherAlreadyRunning)`
	Abort
	
	;=== Checks for a ini file
	CheckForINI:
		Goto Registry
		
	;=== Registry edit
	Registry:
		Goto RegistryRestore
		
	RegistryRestore:
		IfFileExists "$SETTINGSDIRECTORY\BOINCPortable.reg" "" LaunchProgram

		IfFileExists "$WINDIR\system32\reg.exe" "" RestoreTheKey9x
			nsExec::ExecToStack `"$WINDIR\system32\reg.exe" import "$SETTINGSDIRECTORY\BOINCPortable.reg"`
			Pop $R0
			StrCmp $R0 '0' LaunchProgram ;successfully restored key

	RestoreTheKey9x:
		${registry::RestoreKey} "$SETTINGSDIRECTORY\BOINCPortable.reg" $R0
		StrCmp $R0 '0' LaunchProgram ;successfully restored key
		StrCpy $FAILEDTORESTOREKEY "true"
		
	;=== Program start
	LaunchProgram:
		Strcpy $OUTDIR "$EXEDIR\${DEFAULTAPPDIR}"
		Sleep 100
		Exec '"$OUTDIR\boincstart.bat"'
		
	;=== Cheks if the program is running
	CheckRunning:
	        Sleep 1000
		FindProcDLL::FindProc "boincmgr.exe"
		StrCmp $R0 "1" CheckRunning
		
		FindProcDLL::FindProc "boinc.exe"
		StrCmp $R0 "1" CheckRunning
		
		StrCmp $FAILEDTORESTOREKEY "true" SetOriginalKeyBack
		${registry::SaveKey} "HKEY_CURRENT_USER\Software\Space Sciences Laboratory, U.C. Berkeley" "$SETTINGSDIRECTORY\BOINCPortable.reg" "" $0
		Sleep 100

	SetOriginalKeyBack:
		${registry::DeleteKey} "HKEY_CURRENT_USER\Software\Space Sciences Laboratory, U.C. Berkeley" $0
		Sleep 100
		Goto TheEnd

	TheEnd:
		${registry::Unload}
		newadvsplash::stop /WAIT



SectionEnd