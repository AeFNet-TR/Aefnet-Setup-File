;Made with Inno Setup 5.5.3 Ansi
;
; ===========================================================================
;  Surum/dizin ayarlari asagidaki #define'lar ile tek yerden yonetilir.
;    StagingDir = vanilla RA2/YR oyun dosyalari klasoru (SetupFile\)
;    PackageDir = Aefnet'in guncel updater paketi (Aefnet-Updater-Live\package\)
;                 -> her derlemede guncel package alinir, ayri staging kopyalamaya gerek yok
;
;  DIKKAT: #include satirlari ile [Setup] section'i ARASINA ';' yorum satiri KOYMAYIN.
;          ISTheme.iss'in son section'i [Code]; oraya dusen ';' yorumlari Pascal'a karisir
;          ve "'BEGIN' expected" derleme hatasi verir. Yorum+define BLOGU include'lardan ONCE.
; ===========================================================================
#define AppVer       "3.9.2"
#define AppVerInfo   "3.9.2.0"
#define StagingDir   "SetupFile"
#define PackageDir   "..\Aefnet-Updater-Live\package"
#define Net40        "https://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe"
#define XNAredist    "https://download.microsoft.com/download/A/C/2/AC2C903B-E6E8-42C2-9FD7-BEBAC362A930/xnafx40_redist.msi"
; Indirilen/extract edilen prerequisite dosya adlari -> idpAddFile, ExtractTemporaryFile ve [Code] tek isimden okusun
#define Net40File     "dotNetFx40_Full_x86_x64.exe"
#define XNAredistFile "xnafx40_redist.msi"
#define WICFile       "wic_x86_enu.exe"

#include <.\Inno Download Plugin\idp.iss>
#include <.\ISTheme\ISTheme.iss>

[Setup]
AppId={{D22A250A-085F-415E-959E-8DB49F4E4CCA}
AppName=AeFNeT Yuri's Revenge
AppVersion={#AppVer}
AppPublisher=https://aefnet.com
AppCopyright=AeFNet 2019-2026 (C)
VersionInfoVersion={#AppVerInfo}
VersionInfoTextVersion={#AppVerInfo}
VersionInfoProductName=AeFNeT Yuri's Revenge
VersionInfoDescription=AeFNeT Setup
AppPublisherURL=https://aefnet.com
AppSupportURL=https://aefnet.com
AppUpdatesURL=https://aefnet.com
PrivilegesRequired=admin
DirExistsWarning=no
DisableProgramGroupPage=yes
DisableReadyPage=yes
DisableWelcomePage=yes
DisableFinishedPage=yes
AllowNoIcons=yes
OutputBaseFilename=AeFNeT_Setup_{#AppVer}
Compression=lzma2/max
SolidCompression=yes
UsePreviousLanguage=no
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

[Tasks]
Name: "desktopicon"; Description: "Masaustune kisayol olustur"; GroupDescription: "Ek gorevler:"; Flags: checkedonce

[InstallDelete]
; Updater dosyalari -> ilk acilista yeniden surum kontrolu yapilsin
Type: files; Name: "{app}\version"
Type: files; Name: "{app}\version_u"
; 3.9'da kaldirilan eski mix'ler (kaynak: updateexec / preupdateexec listesi)
Type: files; Name: "{app}\expandmd06.mix"
Type: files; Name: "{app}\cache.mix"
Type: files; Name: "{app}\cachemd.mix"
Type: files; Name: "{app}\ecache.mix"
Type: files; Name: "{app}\sidec01.mix"
Type: files; Name: "{app}\sidec02.mix"
Type: files; Name: "{app}\sidec02md.mix"
Type: files; Name: "{app}\expandspawn01.mix"
Type: files; Name: "{app}\expandspawn02.mix"
Type: files; Name: "{app}\expandspawn09.mix"
; Eski DLL / kalintilar
Type: files; Name: "{app}\cncnet5.dll"
Type: files; Name: "{app}\spawner.xdp"
Type: files; Name: "{app}\spawner2.xdp"
Type: files; Name: "{app}\ls800obs.shp"
Type: files; Name: "{app}\mplsobs.pal"
Type: files; Name: "{app}\Resources\aqrit.cfg"
Type: files; Name: "{app}\Resources\Binaries\MySql.Data.dll"
Type: files; Name: "{app}\Resources\Binaries\DTAUpdater.dll"
; Kaldirilan game options INI'leri
Type: files; Name: "{app}\INI\Game Options\No Spy.ini"
Type: files; Name: "{app}\INI\Game Options\No Yuri France.ini"
Type: files; Name: "{app}\INI\Game Options\Yuri Patch.ini"
Type: files; Name: "{app}\INI\Game Options\RA2 Classic Mode.ini"

[Files]
; 1) Vanilla RA2/YR oyun dosyalari (staging klasoru)
;    installScript.vdf -> Steam'in InstallScript'i; Aefnet kurulumunda kullanilmaz, [Registry] ayni isi zaten yapiyor
Source: "{#StagingDir}\*"; DestDir: "{app}"; Excludes: "installScript.vdf"; Flags: ignoreversion recursesubdirs createallsubdirs
; 2) Aefnet'in guncel updater paketi (Aefnet.exe, *.mix, AeFNetSpawner.dll, INI, Maps, Resources, version, ...)
;    Excludes:
;      VersionWriter*           -> build araci + onun kopyaladigi staging klasoru
;      versionconfig.ini        -> build config
;      package.zip              -> updater'in SUNUCUYA konan dagitim arsivi; setup.exe icine girmesi 400+ MB bos yer (ve >2.1 GB limiti asar)
Source: "{#PackageDir}\*"; DestDir: "{app}"; Excludes: "VersionWriter-CopiedFiles\*,VersionWriter.exe,versionconfig.ini,package.zip"; Flags: ignoreversion recursesubdirs createallsubdirs
; 3) Inno Download Plugin icin gecici dosya
Source: Resources\{#WICFile}; Flags: dontcopy

[Icons]
Name: "{commondesktop}\AEFNET Launcher"; Filename: "{app}\Aefnet.exe"; Tasks: desktopicon
Name: "{app}\Uninstall AeFNeT"; Filename: "{uninstallexe}"

[Run]
; Windows Defender exclusion -> {app} ile parametrik; -ErrorAction SilentlyContinue hata olursa setup'i kesmez
Filename: "powershell.exe"; Parameters: "-NoProfile -ExecutionPolicy Bypass -Command ""Add-MpPreference -ExclusionPath '{app}' -ErrorAction SilentlyContinue"""; WorkingDir: "{app}"; Flags: runhidden runascurrentuser
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
Type: filesandordirs; Name: "{app}\debug"
; NOT: "{app}\Saved Games" KASTI ile kaldirildi -> kaldirma sirasinda kullanici kayitlari korunur

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
    idpAddFile('{#Net40}', ExpandConstant('{tmp}\{#Net40File}'));

    if (Version.Major < 6) then
      ExtractTemporaryFile('{#WICFile}');

  end

  if (Version.Major < 6) or ((Version.Major = 6) and (Version.Minor = 0)) then
    idpAddFile('{#XNAredist}', ExpandConstant('{tmp}\{#XNAredistFile}'));


end;

// ---------------------------------------------------------------------------
//  idpAddFile / ExtractTemporaryFile dosyayi yalnizca tmp klasorune birakir;
//  kurmak icin ayrica calistirmak gerekir. Dosya yoksa (prerequisite zaten
//  yukluydu, idpAddFile hic cagrilmadi) sessizce atlanir -> tekrar kurmayiz.
// ---------------------------------------------------------------------------
procedure RunTempExe(const FileName, Params: String);
var
  FullPath: String;
  ResultCode: Integer;
begin
  FullPath := ExpandConstant('{tmp}\' + FileName);
  if not FileExists(FullPath) then
    Exit;

  if not Exec(FullPath, Params, '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
    Log('Prerequisite calistirilamadi: ' + FileName)
  else
    Log('Prerequisite kuruldu (' + FileName + '), cikis kodu: ' + IntToStr(ResultCode));
end;

procedure RunTempMsi(const FileName, Params: String);
var
  FullPath: String;
  ResultCode: Integer;
begin
  FullPath := ExpandConstant('{tmp}\' + FileName);
  if not FileExists(FullPath) then
    Exit;

  if not Exec(ExpandConstant('{sys}\msiexec.exe'), '/i "' + FullPath + '" ' + Params,
              '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
    Log('MSI prerequisite calistirilamadi: ' + FileName)
  else
    Log('MSI prerequisite kuruldu (' + FileName + '), cikis kodu: ' + IntToStr(ResultCode));
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep <> ssPostInstall then
    Exit;

  // WIC, eski Windows surumlerinde .NET 4 icin on kosul -> ondan once kurulmali
  RunTempExe('{#WICFile}', '/quiet /norestart');
  RunTempExe('{#Net40File}', '/passive /norestart');
  RunTempMsi('{#XNAredistFile}', '/passive /norestart');
end;
