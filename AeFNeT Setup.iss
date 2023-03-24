;Made with Inno Setup 5.5.3 Ansi
#include <.\Inno Download Plugin\idp.iss>
#include <.\ISTheme\ISTheme.iss>

#define Net40 = "http://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe"
#define XNAredist = "http://download.microsoft.com/download/A/C/2/AC2C903B-E6E8-42C2-9FD7-BEBAC362A930/xnafx40_redist.msi"

[Setup]
AppId={{D22A250A-085F-415E-959E-8DB49F4E4CCA}
AppName=AeFNeT Yuri's Revenge
AppVersion=3.1
AppVerName=AeFNeT Yuri's Revenge
AppPublisher=https://aefnet.com
VersionInfoVersion=3.0.0.2
VersionInfoTextVersion=3.0.0.2
AppCopyright=AEFNET 2019-2023 ©
VersionInfoProductName=AeFNeT Yuri's Revenge
VersionInfoDescription=AeFNeT Setup
AppPublisherURL=https://aefnet.com
AppSupportURL=https://aefnet.com
AppUpdatesURL=https://aefnet.com
DirExistsWarning=no
DisableProgramGroupPage=yes
DisableReadyPage=yes
DisableWelcomePage=yes
DisableFinishedPage=yes
AllowNoIcons=yes
OutputBaseFilename=AeFNeT_Setup
Compression=lzma2/max
SolidCompression=yes
UsePreviouslanguage=no
CreateUninstallRegKey=yes
UsePreviousAppDir=no
SourceDir=.
OutputDir=.
DefaultDirName=C:\Program Files (x86)\AEFNET\Red Alert 2
SetupIconFile=Resources\cncnet5.ico
AppendDefaultDirName=no
ShowLanguageDialog=no
LicenseFile=Resources\License-YurisRevenge.txt

[Languages]
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"

[InstallDelete]
Type: files; Name: "{app}\version"

[Files]
Source: "C:\Users\Mysterious\Desktop\Ra2New\Aefnet.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Mysterious\Desktop\Ra2New\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: Resources\wic_x86_enu.exe; Flags: dontcopy


[Icons]
Name: "{commondesktop}\AEFNET Launcher"; Filename: "{app}\Aefnet.exe"
Name: "{app}\Uninstall AeFNeT"; Filename: "{uninstallexe}"

[Run]
Filename: "powershell.exe"; Parameters: "Add-MpPreference -ExclusionPath 'C:\Program Files (x86)\AEFNET\Red Alert 2'"; WorkingDir: {app}; Flags: runhidden
Filename: "{app}\Aefnet.exe"; WorkingDir: "{app}"; Description: "{cm:LaunchProgram,Yuris Revenge}"; Flags: nowait postinstall runascurrentuser skipifsilent
 
[UninstallDelete]
Type: files; Name: "{app}\version"
Type: files; Name: "{app}\ddraw.dll"
Type: files; Name: "{app}\ddraw.ini"
Type: files; Name: "{app}\RA2MD.ini"
Type: files; Name: "{app}\version_u"
Type: files; Name: "{app}\stats.dmp"
Type: files; Name: "{app}\spawnmap.ini"
Type: files; Name: "{app}\spawn.ini"
Type: files; Name: "{app}\expandspawn09.mix"
Type: filesandordirs; Name: "{app}\INI"
Type: filesandordirs; Name: "{app}\Maps"
Type: filesandordirs; Name: "{app}\Resources"
Type: filesandordirs; Name: "{app}\Client"
Type: filesandordirs; Name: "{app}\Saved Games"

[Registry]
Root: HKLM; Subkey: SOFTWARE\Classes\CLSID\{{1440AD10-6AA8-11D1-B6F9-00A024DDAFD1}\InprocServer32; ValueType: string; ValueData: "blowfish.dll";

Root: HKCU; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\Ra2.exe; Flags: deletevalue 
Root: HKLM; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\Ra2.exe; Flags: deletevalue
Root: HKCU64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\Ra2.exe; Flags: deletevalue; Check: IsWin64
Root: HKLM64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\Ra2.exe; Flags: deletevalue; Check: IsWin64

Root: HKCU; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\RA2MD.exe; Flags: deletevalue 
Root: HKLM; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\RA2MD.exe; Flags: deletevalue
Root: HKCU64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\RA2MD.exe; Flags: deletevalue; Check: IsWin64
Root: HKLM64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\RA2MD.exe; Flags: deletevalue; Check: IsWin64

Root: HKCU; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\YURI.exe; Flags: deletevalue 
Root: HKLM; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\YURI.exe; Flags: deletevalue
Root: HKCU64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\YURI.exe; Flags: deletevalue; Check: IsWin64
Root: HKLM64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueName: {app}\YURI.exe; Flags: deletevalue; Check: IsWin64

Root: HKLM; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\gamemd-spawn.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE"
Root: HKCU; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\gamemd-spawn.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE"
Root: HKCU64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\gamemd-spawn.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE"; Check: IsWin64
Root: HKLM64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\gamemd-spawn.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE"; Check: IsWin64

Root: HKLM; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\gamemd.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE RUNASADMIN"
Root: HKCU; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\gamemd.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE RUNASADMIN"
Root: HKCU64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\gamemd.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE RUNASADMIN"; Check: IsWin64
Root: HKLM64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\gamemd.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE RUNASADMIN"; Check: IsWin64

Root: HKLM; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\game.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE RUNASADMIN"
Root: HKCU; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\game.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE RUNASADMIN"
Root: HKCU64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\game.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE RUNASADMIN"; Check: IsWin64
Root: HKLM64; Subkey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: String; ValueName: {app}\game.exe; ValueData: "16BITCOLOR 8And16BitTimedPriSync HIGHDPIAWARE RUNASADMIN"; Check: IsWin64

[Code]
procedure InitializeWizard();
begin
  idpDownloadAfter(wpReady);
  idpSetOption('DetailedMode', '1');
  idpSetOption('RetryButton',  '0');
  idpSetOption('DetailsButton','0');
  idpSetOption('AllowContinue','0');      
  idpSetOption('UserAgent','Mozilla/5.0 (Windows NT 5.1; rv:18.0) Gecko/20100101 Firefox/18.0');
  
  ISTheme();

  // # license radio text color
  WizardForm.LicenseAcceptedRadio.Font.Color := {#ISThemeTextBoxForeColor};
  WizardForm.LicenseAcceptedRadio.Color := {#ISThemeTextBoxBackColor};
  WizardForm.LicenseNotAcceptedRadio.Font.Color := {#ISThemeTextBoxForeColor};
  WizardForm.LicenseNotAcceptedRadio.Color := {#ISThemeTextBoxBackColor};
end;

function NET4installed(): Boolean;
var
  installed: Cardinal;
begin
  Result := false;

  if RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full', 'Install', installed) and 
    (installed = 1) then
      Result := true;
  
  // client profile doesn't seem to be supported...
  //if RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client', 'Install', installed) and 
  //(installed = 1) then
  //Result := true;
end;

function InitializeSetup(): Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);
  Result := true;

  if not NET4installed then
  begin
    idpAddFile('{#Net40}', ExpandConstant('{tmp}\dotNetFx40_Full_x86_x64.exe'));

    if (Version.Major < 6) then
      ExtractTemporaryFile('wic_x86_enu.exe');

  end

  if (Version.Major < 6) or ((Version.Major = 6) and (Version.Minor = 0)) then
    idpAddFile('{#XNAredist}', ExpandConstant('{tmp}\xnafx40_redist.msi'));

  
end;