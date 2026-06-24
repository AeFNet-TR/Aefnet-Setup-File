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
#define AppVer       "3.9.3"
#define AppVerInfo   "3.9.3.0"
#define StagingDir   "SetupFile"
#define PackageDir   "..\Aefnet-Updater-Live\package"
; Offline prerequisite dosya adlari -> [Files] dontcopy + ExtractTemporaryFile + [Code] tek isimden okusun.
; Online URL define'lari (eski Net48/XNAredist web linkleri) kaldirildi: prerequisite'ler
; setup.exe icine gomulu -> internet olmadan da .NET 4.8 + XNA kurulur (offline kurulum garantisi).
; .NET 4.8 ICIN OFFLINE installer (ndp48-x86-x64-allos-enu.exe) sart; eski 'ndp48-web.exe' bootstrapper
; kendisi payload'i internetten indirirdi -> gomulse bile offline calismazdi.
; WIC kaldirildi: yalnizca XP/2003 (Win<6) icin .NET 4 on kosuluydu; OS tabani Win7 SP1+ oldugu icin
; gereksiz (WIC Win7+'a gomulu). XNA Framework 4.0 ise hicbir Windows'a gomulu DEGIL -> clientxna.exe
; (eski-GPU fallback varyanti) icin her hedef OS'ta kurulmali (bkz. XNAinstalled gate).
#define Net48File     "ndp48-x86-x64-allos-enu.exe"
#define XNAredistFile "xnafx40_redist.msi"

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
;    Dedup: asagidaki 10 mix hem staging'de hem package'ta BIREBIR ayni (relpath + boyut). Package zaten
;    ayni dosyayi {app}'a kuruyor -> setup'a iki kez girmesin (~659 MB tasarruf; 2.1 GB tek-dosya limiti).
;    Bunlar #2 (package) kaynagi tarafindan saglanir. (Ayni-isim-farkli-boyut cakisma YOK -> hepsi exact-dup.)
Source: "{#StagingDir}\*"; DestDir: "{app}"; Excludes: "installScript.vdf,ra2.mix,ra2md.mix,langmd.mix,language.mix,multimd.mix,MULTI.MIX,expandmd01.mix,mapsmd03.mix,maps01.mix,maps02.mix"; Flags: ignoreversion recursesubdirs createallsubdirs
; 2) Aefnet'in guncel updater paketi (Aefnet.exe, *.mix, AeFNetSpawner.dll, INI, Maps, Resources, version, ...)
;    Excludes:
;      VersionWriter-CopiedFiles -> VersionWriter'in urettigi staging klasoru (AefnetServices.dll,
;                                   ClientUpdater.dll, OpenGL/Windows/XNA binary'leri ...); setup'a GIRMEMELI
;      VersionWriter.exe         -> build araci
;      versionconfig.ini         -> build config
;      package.zip               -> updater'in SUNUCUYA konan dagitim arsivi; setup.exe icine girmesi 400+ MB bos yer (ve >2.1 GB limiti asar)
;      updateexec / preupdateexec -> updater'in MEVCUT kurulumda calistirdigi [Rename]/[Delete]
;                                   komut dosyalari (eski dosyalari sil/yeniden adlandir). Temiz
;                                   kurulumda anlamsiz -> setup'a girmemeli (gereksiz, hatta taze
;                                   dosyalari silebilir)
;      *.lzma                     -> updater'in indirme delta'lari (maps01/02/mapsmd03.mix.lzma);
;                                   setup .mix'leri sikistirilmamis gonderiyor -> .lzma gereksiz
;
;    NOT: Excludes'ta backslash'SIZ desen (sadece 'VersionWriter-CopiedFiles') her dosya/dizinin
;         ADIYLA eslesir; bir dizin eslesince TUM icerigi (her derinlikte) atlanir. Eski
;         'VersionWriter-CopiedFiles\*\*\*\*' yaklasimi gereksizdi: backslash'li desende '*' '\'
;         ayracini gecmedigi icin her seviyeyi tek tek listelemek gerekiyordu ve yine de kirilgandi.
;         Bu davranis izole kurulum testi (LOG ile) ile dogrulandi: klasor hic olusmuyor.
Source: "{#PackageDir}\*"; DestDir: "{app}"; Excludes: "VersionWriter-CopiedFiles,VersionWriter.exe,versionconfig.ini,package.zip,updateexec,preupdateexec,*.lzma"; Flags: ignoreversion recursesubdirs createallsubdirs
; 3) Offline prerequisite'ler -> setup.exe icine gomulur, kurulumda ExtractTemporaryFile ile
;    {tmp}'ye cikarilip calistirilir (online indirme YOK -> internet'siz kurulum calisir)
Source: Resources\{#Net48File}; Flags: dontcopy
Source: Resources\{#XNAredistFile}; Flags: dontcopy

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

function NET48installed(): Boolean;
var
  release: Cardinal;
begin
  Result := false;

  // .NET Framework 4.8 -> Release DWORD >= 528040 (tum desteklenen OS surumleri icin
  // minimum esik). Eski kontrol yalnizca 'Install=1' bakiyordu; bu 4.0 da olsa true
  // donerdi -> 4.8 garanti edilmiyordu. Artik surum esigi ile dogru tespit ediyoruz.
  if RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full', 'Release', release) and
    (release >= 528040) then
      Result := true;
end;

function XNAinstalled(): Boolean;
var
  installed: Cardinal;
begin
  Result := false;

  // XNA Framework 4.0 Redistributable -> HKLM\...\Microsoft\XNA\Framework\v4.0 'Installed'=1.
  // XNA hicbir Windows surumune gomulu DEGIL; clientxna.exe (eski-GPU fallback) GAC'taki XNA'ya
  // baglidir. 32-bit setup process'i 64-bit OS'ta otomatik Wow6432Node'a yonlenir; emin olmak
  // icin native (HKLM64) view'i da kontrol ediyoruz.
  if RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\XNA\Framework\v4.0', 'Installed', installed) and
    (installed = 1) then
      Result := true
  else if IsWin64 and RegQueryDWordValue(HKLM64, 'SOFTWARE\Microsoft\XNA\Framework\v4.0', 'Installed', installed) and
    (installed = 1) then
      Result := true;
end;

function InitializeSetup(): Boolean;
begin
  Result := true;

  // .NET 4.8 yoksa kur (her hedef OS: Win7 SP1+). 4.8 yoksa client/updater hicbir sey calismaz.
  if not NET48installed then
    ExtractTemporaryFile('{#Net48File}');

  // XNA 4.0 yoksa kur (her hedef OS): clientxna.exe fallback'i icin sart. WIC kaldirildi (XP-only).
  if not XNAinstalled then
    ExtractTemporaryFile('{#XNAredistFile}');
end;

// ---------------------------------------------------------------------------
//  ExtractTemporaryFile dosyayi yalnizca tmp klasorune birakir; kurmak icin ayrica
//  calistirmak gerekir. Dosya yoksa (prerequisite zaten yukluydu, ExtractTemporaryFile
//  hic cagrilmadi -> bkz. InitializeSetup kosullari) sessizce atlanir -> tekrar kurmayiz.
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

  RunTempExe('{#Net48File}', '/passive /norestart');
  RunTempMsi('{#XNAredistFile}', '/passive /norestart');
end;
