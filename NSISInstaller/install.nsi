; Plugins
!include "MUI2.nsh"


; Installer Content
Name "PhotoLab"
!define MUI_ICON "icon.ico"
OutFile "PhotoLab Installer.exe"
Unicode True

; Variables
Var StartMenuFolder

; Registry data
InstallDir "$PROGRAMFILES\LFInteractive\PhotoLab"
InstallDirRegKey HKCU "Software\LFInteractive\PhotoLab" ""
RequestExecutionLevel admin

!define MUI_ABORTWARNING
!insertmacro MUI_PAGE_LICENSE "tos.txt"

!insertmacro MUI_PAGE_DIRECTORY

!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\LFInteractive\PhotoLab" 
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

Section "PhotoLab" SecPhotoLab

  SetOutPath "$INSTDIR\PhotoLab"
  File /r "..\PhotoLab\bin\Release\net7.0-windows10.0.19041.0\win10-x64\"

  ExecWait '"$INSTDIR\PhotoLab.zip" -o "$INSTDIR"' $0

  WriteRegStr HKCU "Software\LFInteractive\PhotoLab" "" $INSTDIR
  AccessControl::GrantOnFile "$INSTDIR" "(BU)" "FullAccess"

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application


  ;Create shortcuts
  CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
  CreateShortcut "$SMPROGRAMS\$StartMenuFolder\PhotoLab.lnk" "$INSTDIR\PhotoLab\PhotoLab.exe"
  CreateShortcut "$INSTDIR\PhotoLab.lnk" "$INSTDIR\PhotoLab\PhotoLab.exe"
  !insertmacro MUI_STARTMENU_WRITE_END

    ; Update file associations
  WriteRegStr HKCR ".jpg" "" "LFInteractive\PhotoLab\Image"
  WriteRegStr HKCR ".jpeg" "" "LFInteractive\PhotoLab\Image"
  WriteRegStr HKCR ".png" "" "LFInteractive\PhotoLab\Image"
  WriteRegStr HKCR ".svg" "" "LFInteractive\PhotoLab\Image"
  WriteRegStr HKCR ".gif" "" "LFInteractive\PhotoLab\Image"
  WriteRegStr HKCR ".pdf" "" "LFInteractive\PhotoLab\Image"
  WriteRegStr HKCR ".webp" "" "LFInteractive\PhotoLab\Image"
  WriteRegStr HKCR ".bmp" "" "LFInteractive\PhotoLab\Image"
  WriteRegStr HKCR ".tif" "" "LFInteractive\PhotoLab\Image"
  WriteRegStr HKCR ".tiff" "" "LFInteractive\PhotoLab\Image"

  WriteRegStr HKCR "LFInteractive\PhotoLab\Image\DefaultIcon" "" "$INSTDIR\PhotoLab\PhotoLab.exe,0"
  WriteRegStr HKCR "LFInteractive\PhotoLab\Image\shell\open\command" "" '"$INSTDIR\PhotoLab\PhotoLab.exe" "%1"'



  
SectionEnd
