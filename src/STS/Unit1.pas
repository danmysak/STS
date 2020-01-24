unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, tlhelp32, shellapi, shlobj,
  inifiles, Gauges, XPMan, ComCtrls, math, olectrls, PsAPI, VistaAltFix;

type
  monitor = class(TThread)
  private
    start: integer;
    finish: integer;
  protected
    procedure Execute; override;
  end;

  Tmain = class(TForm)
    dxButton1: TButton;
    workfname: TEdit;
    Label1: TLabel;
    tasklist: TListBox;
    addb: TButton;
    Label2: TLabel;
    delb: TButton;
    dxButton2: TButton;
    testpath: TEdit;
    Label3: TLabel;
    od1: TOpenDialog;
    dxButton4: TButton;
    dxButton5: TButton;
    res: TMemo;
    Gauge1: TGauge;
    dxButton6: TButton;
    Label7: TLabel;
    intestname: TEdit;
    outtestname: TEdit;
    Label8: TLabel;
    testname: TEdit;
    Label9: TLabel;
    dxButton9: TButton;
    infname: TEdit;
    outfname: TEdit;
    XPManifest1: TXPManifest;
    Label4: TLabel;
    extlist: TListBox;
    extaddb: TButton;
    extdelb: TButton;
    Label5: TLabel;
    complist: TListBox;
    compaddb: TButton;
    compdelb: TButton;
    compupdown: TUpDown;
    Button5: TButton;
    comppath: TEdit;
    Label6: TLabel;
    Label10: TLabel;
    comppars: TEdit;
    Label11: TLabel;
    compid: TEdit;
    extupdown: TUpDown;
    linebreak_pts: TEdit;
    Button1: TButton;
    largewin: TCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    Button2: TButton;
    interpath: TEdit;
    interpars: TEdit;
    editb: TButton;
    exteditb: TButton;
    compeditb: TButton;
    linebreak: TComboBox;
    Label14: TLabel;
    VistaAltFix1: TVistaAltFix;
    procedure dxButton1Click(Sender: TObject);
    procedure addbClick(Sender: TObject);
    procedure tasklistClick(Sender: TObject);
    procedure delbClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dxButton2Click(Sender: TObject);
    procedure dxButton4Click(Sender: TObject);
    procedure dxButton5Click(Sender: TObject);
    procedure dxButton6Click(Sender: TObject);
    procedure intestnameChange(Sender: TObject);
    procedure testnameChange(Sender: TObject);
    procedure outtestnameChange(Sender: TObject);
    procedure dxButton9Click(Sender: TObject);
    procedure infnameChange(Sender: TObject);
    procedure outfnameChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tasklistDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure extaddbClick(Sender: TObject);
    procedure extdelbClick(Sender: TObject);
    procedure extlistClick(Sender: TObject);
    procedure extupdownClick(Sender: TObject; Button: TUDBtnType);
    procedure extlistDblClick(Sender: TObject);
    procedure compaddbClick(Sender: TObject);
    procedure complistClick(Sender: TObject);
    procedure compdelbClick(Sender: TObject);
    procedure complistDblClick(Sender: TObject);
    procedure compupdownClick(Sender: TObject; Button: TUDBtnType);
    procedure Button5Click(Sender: TObject);
    procedure compparsChange(Sender: TObject);
    procedure compidChange(Sender: TObject);
    procedure tasklistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure extlistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure complistKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure linebreak_ptsExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    function ReplaceSub(str, sub1, sub2, prefix: string): string;
    procedure workfnameExit(Sender: TObject);
    procedure testpathExit(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure comppathExit(Sender: TObject);
    procedure interpathExit(Sender: TObject);
    procedure interparsChange(Sender: TObject);
    procedure editbClick(Sender: TObject);
    procedure exteditbClick(Sender: TObject);
    procedure compeditbClick(Sender: TObject);
    procedure linebreakChange(Sender: TObject);
    procedure UpdateLinebreakPoints();
    procedure ValidateAndStoreLinebreakPoints();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

type TCheckOutput = function (input, output, prompt: pchar; points: integer): double;

compiler = record
  name: string;
  path: string;
  pars: string;
  inter: string;
  interpars: string;
  id: string;
end;

extension = record
  name: string;
  compilers: array of compiler;
end;

testSetting = record
  key: string;
  value: integer;
end;

function formatBytes(bytes: int64): string;

const infoFile = 'contest';
      infoFileAlt = 'info';
      compilerParamsSeparator = ' ||| ';
      compilerParamsEmtpy = '[[empty]]';
      testingFolder = 'Currently_tested';
      compilationTimeLimit = 30000; // 30 секунд
      defaultWhiteSpacePoints = 0.5;
      stdinFileName = '__input.txt';
      stdoutFileName = '__output.txt';

var
  main: Tmain;
  workfolder, testfolder, test, intest, outtest, inname, outname: string;
  fs: array of string;
  cmaxtest: integer;
  cinfo: array[0..1023] of integer;
  cinfo_tl: integer;
  cinfo_ml: int64;
  cinfo_settings: array of testSetting;
  dlls: array of TCheckOutput;
  dllsh: array of THandle;
  dllsb: array of boolean;
  cstruct: array of extension;
  sett: tinifile;
  sett_linebreak: integer;
  sett_linebreak_pts: double;
  checkThread: monitor;
  textBuffer: array[1..32767] of char;

  ProcInfo: TProcessInformation;
  ErrPipeRead, ErrPipeWrite: THandle;

implementation

uses Unit2, Unit5;

{$R *.dfm}

function tmain.ReplaceSub(str, sub1, sub2, prefix: string): string;
var
  aPos: Integer;
  rslt, ssub2: string;
  i, lsub1: integer;
begin
  aPos := Pos(sub1, str);
  rslt := '';
  while aPos <> 0 do
  begin
    ssub2 := sub2;
    lsub1 := length(sub1);
    if (prefix <> '') and (length(str) >= aPos + 2) and (str[aPos + length(sub1)] = ':')
      and (str[aPos + length(sub1) + 1] >= '0') and (str[aPos + length(sub1) + 1] <= '9')
    then begin
      for i := 1 to (ord(str[aPos + length(sub1) + 1]) - ord('0') - length(sub2)) do
        ssub2 := prefix+ssub2;
      lsub1 := lsub1+2;
    end;
    rslt := rslt + Copy(str, 1, aPos - 1) + ssub2;
    Delete(str, 1, aPos + lsub1 - 1);
    aPos := Pos(sub1, str);
  end;
  Result := rslt + str;
end;

function strtofloatLB(s: string): double;
var i: integer;
begin
  if (s = '') then
    result := defaultWhiteSpacePoints
  else if s = '0' then
    result := 0
  else if s[1] = '1' then
    result := 1
  else if (s[1] <> '0') or (length(s) <= 2) or ((s[2] <> ',') and (s[2] <> '.')) then
    result := defaultWhiteSpacePoints
  else begin
    try
      delete(s, 1, 2);
      result := strtoint(s);
      for i := 1 to length(s) do result := result / 10;
    except
      result := defaultWhiteSpacePoints;
    end;
  end;
end;

function deldir(directory: shortstring): boolean;
var fos: tshfileopstruct;
begin
  result := false;
  zeromemory(@fos, sizeof(fos));
  fos.wfunc := fo_delete;
  fos.fflags := fof_silent or fof_noconfirmation;
  fos.pfrom := pchar(directory + #0);
  if shfileoperation(fos) = 0 then result := true;
end;

procedure writeinipath(param, s: string);
begin
  sett.WriteString('Paths', param, s);
end;

procedure writeini(sect, param, s: string);
begin
  sett.WriteString(sect, param, s);
end;

function KillTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;

  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while integer(ContinueLoop) <> 0 do begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName))
      or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName)))
    then
      Result := Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),
        FProcessEntry32.th32ProcessID), 0));
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;

  CloseHandle(FSnapshotHandle);
end;

function ReadErrPipe(errPipe: THandle; var bytesRemain: cardinal): string;
var bytesRead, pipeSize: cardinal;
begin
  result := '';
  pipeSize := SizeOf(textBuffer);
  PeekNamedPipe(ErrPipe, nil, pipeSize, @bytesRead, @pipeSize, @bytesRemain);
  if bytesread > 0 then begin
    ReadFile(errPipe, textBuffer, pipeSize, bytesRead, nil);
    OemToChar(@textBuffer, @textBuffer);
    result := string(textBuffer);
    SetLength(result, bytesRead);
  end;
end;

function GetProcessCpuTime(p: TProcessInformation): integer;
var creationTime, exitTime, kernelTime, userTime: filetime;
begin
  GetProcessTimes(p.hProcess, creationTime, exitTime, kernelTime, userTime);
  result := (int64(kernelTime) + int64(userTime)) div 10000;
end;

procedure monitor.Execute;
var
  s: string;
  i, t: integer;
  bytesRemain: cardinal;
begin
  start := -1;
  finish := -1;
  while not Terminated do begin
    s := ReadErrPipe(ErrPipeRead, bytesRemain);
    if s <> '' then begin
      t := GetProcessCpuTime(ProcInfo);
      for i := 1 to length(s) do begin
        if s[i] = '0' then start := t;
        if s[i] = '1' then finish := t;
      end;
    end;
    sleep(10);
  end;
end;

function ExecAndWait(const filename: shortstring; const params: shortstring;
  const workingFolder: shortstring; const wait: longint; const winState: word;
  const interactive, useStdin, useStdout: boolean; var milliseconds: integer;
  var milliseconds_cpu: integer; var memory: int64; var exitCode: cardinal):
  integer;
var
  StartInfo: TStartupInfo;
  Security: TSecurityAttributes;
  PSecurity: PSecurityAttributes;
  StdInFileHandle, StdOutFileHandle: THandle;
  cmdLine: shortstring;
  t1, t2, freq: int64;
  memoryData: process_memory_counters;
begin
  milliseconds := 0;
  milliseconds_cpu := 0;
  memory := 0;
  cmdLine := '"' + filename + '" ' + params;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  with StartInfo do
  begin
    cb := SizeOf(StartInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := winState;
  end;

  with Security do begin
    nlength := SizeOf(TSecurityAttributes);
    binherithandle := true;
    lpsecuritydescriptor := nil;
  end;
  if interactive then begin
    CreatePipe(ErrPipeRead, ErrPipeWrite, @Security, 0);
    StartInfo.hStdError := ErrPipeWrite;
  end else begin
    StartInfo.hStdError := GetStdHandle(STD_ERROR_HANDLE);
  end;
  if useStdin then begin
    StdInFileHandle := CreateFile(PChar(workingFolder + '\' + stdinFileName),
      GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    SetHandleInformation(StdInFileHandle, HANDLE_FLAG_INHERIT, 1);
    StartInfo.hStdInput := StdInFileHandle;
  end else begin
    StartInfo.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
  end;
  if useStdout then begin
    StdOutFileHandle := CreateFile(PChar(workingFolder + '\' + stdoutFileName),
      GENERIC_WRITE, FILE_SHARE_READ, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    SetHandleInformation(StdOutFileHandle, HANDLE_FLAG_INHERIT, 1);
    StartInfo.hStdOutput := StdOutFileHandle;
  end else begin
    StartInfo.hStdOutput := GetStdHandle(STD_OUTPUT_HANDLE);
  end;
  StartInfo.dwFlags := StartInfo.dwFlags + STARTF_USESTDHANDLES;
  PSecurity := @Security;

  if CreateProcess(nil, pchar(string(cmdLine)), PSecurity, PSecurity,
    true, create_new_console or normal_priority_class, nil,
    pchar(string(workingFolder)), StartInfo, ProcInfo)
  then begin
    QueryPerformanceCounter(t1);

    if interactive then begin
      checkThread := monitor.Create(false);
      checkThread.Priority := tpHigher;
    end;

    if WaitForSingleObject(ProcInfo.hProcess, wait) = wait_timeout then
      result := 0
    else begin
      result := 1;
      GetExitCodeProcess(ProcInfo.hProcess, exitCode);
    end;

    QueryPerformanceCounter(t2);
    QueryPerformanceFrequency(freq);

    milliseconds := round((t2 - t1) * 1000 / freq);

    if interactive then begin
      checkThread.Terminate();
      CloseHandle(ErrPipeRead);
      CloseHandle(ErrPipeWrite);
      if (checkThread.start < 0) or (checkThread.finish < 0) then
        milliseconds_cpu := GetProcessCpuTime(ProcInfo)
      else
        milliseconds_cpu := checkThread.finish - checkThread.start;
    end else begin
      milliseconds_cpu := GetProcessCpuTime(ProcInfo);
    end;
    if useStdin then begin
      closeHandle(StdInFileHandle);
    end;
    if useStdout then begin
      closeHandle(StdOutFileHandle);
    end;

    memoryData.cb := SizeOf(memoryData);
    GetProcessMemoryInfo(ProcInfo.hProcess, @memoryData, SizeOf(memoryData));
    memory := memoryData.PeakWorkingSetSize;
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end else begin
    result := -1;
  end;
end;

function getFolderName(var foldervar: string): boolean;
var
  TitleName: string;
  lpItemID: PItemIDList;
  BrowseInfo: TBrowseInfo;
  DisplayName: array[0..MAX_PATH] of char;
  TempPath: array[0..MAX_PATH] of char;
begin
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  BrowseInfo.hwndOwner := main.Handle;
  BrowseInfo.pszDisplayName := @DisplayName;
  TitleName := 'Виберіть потрібну директорію';
  BrowseInfo.lpszTitle := PChar(TitleName);
  BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then
  begin
    SHGetPathFromIDList(lpItemID, TempPath);
    foldervar := TempPath;
    result := true;
    GlobalFreePtr(lpItemID);
  end else
    result := false;
end;

function correctFolderPath(var s: string): boolean;
begin
  s := trim(s);
  if s = '' then
    result := true
  else begin
    if s[length(s)] <> '\' then
      s := s + '\';
    result := DirectoryExists(s);
  end;
end;

function correctFilePath(var s: string): Boolean;
begin
  s := trim(s);
  if s = '' then
    result := true
  else
    result := fileexists(s);
end;

procedure setWorkFolder(folder: string);
begin
  if correctFolderPath(folder) then begin
    workfolder := folder;
    main.workfname.Text := folder;
    writeinipath('WorkFolder', folder);
    main.button1.Visible := (folder <> '') and fileexists(folder + 'result_full.html');
  end else begin
    messagedlg('Указано неправильну директорію.' + #10 + #13 + 'Виправте або видаліть шлях.',
      mtError, [mbOk], 0);
    main.workfname.SetFocus();
    main.workfname.SelectAll();
  end;
end;

procedure setTestFolder(folder: string);
begin
  if correctFolderPath(folder) then begin
    testfolder := folder;
    main.testpath.Text := folder;
    writeinipath('TestFolder', folder);
  end else begin
    messagedlg('Указано неправильну директорію.' + #10 + #13 + 'Виправте або видаліть шлях.',
      mtError, [mbOk], 0);
    main.testpath.SetFocus();
    main.testpath.SelectAll();
  end;
end;

procedure Tmain.dxButton1Click(Sender: TObject);
var folder: string;
begin
  if getFolderName(folder) then
    setWorkFolder(folder);
end;

procedure Tmain.workfnameExit(Sender: TObject);
begin
  setWorkFolder(workfname.Text);
end;

procedure Tmain.dxButton2Click(Sender: TObject);
var folder: string;
begin
  if getFolderName(folder) then
    setTestFolder(folder);
end;

procedure Tmain.testpathExit(Sender: TObject);
begin
  setTestFolder(testpath.Text);
end;

procedure Tmain.addbClick(Sender: TObject);
var s: string;
begin
  s := inputbox('Нова задача', 'Уведіть назву нової задачі:', '');
  if trim(s) <> '' then begin
    tasklist.Items.Add(s);
    writeini('Tasks', 'Tasklist', replacesub(tasklist.Items.Text, #13 + #10, '\n', ''));
  end;
end;

procedure Tmain.tasklistClick(Sender: TObject);
begin
  if tasklist.ItemIndex > -1 then begin
    delb.Enabled := true;
    editb.Enabled := true;
  end;
end;

procedure Tmain.delbClick(Sender: TObject);
begin
  if tasklist.ItemIndex = -1 then
    exit;
  tasklist.Items.Delete(tasklist.ItemIndex);
  delb.Enabled := false;
  editb.Enabled := false;
  writeini('Tasks', 'Tasklist', replacesub(tasklist.Items.Text, #13 + #10, '\n', ''));
end;

procedure readCStruct;
const fieldsCount = 6;
var
  ext, comp: tstringlist;
  i, j, n: integer;
begin
  ext := tstringlist.Create;
  sett.ReadSection('Compilers', ext);
  setlength(cstruct, ext.Count);
  for i := 0 to ext.Count - 1 do begin
    cstruct[i].name := ext.Strings[i];
    comp := tstringlist.Create;
    comp.Text := main.replacesub(sett.ReadString('Compilers', ext.Strings[i], ''),
      compilerParamsSeparator, #10, '');
    n := comp.Count div fieldsCount;
    setlength(cstruct[i].compilers, n);
    for j := 0 to n - 1 do begin
      cstruct[i].compilers[j].name := main.replacesub(
        comp.Strings[j * fieldsCount], compilerParamsEmtpy, '', '');
      cstruct[i].compilers[j].path := main.replacesub(
        comp.Strings[j * fieldsCount + 1], compilerParamsEmtpy, '', '');
      cstruct[i].compilers[j].pars := main.replacesub(
        comp.Strings[j * fieldsCount + 2], compilerParamsEmtpy, '', '');
      cstruct[i].compilers[j].inter := main.replacesub(
        comp.Strings[j * fieldsCount + 3], compilerParamsEmtpy, '', '');
      cstruct[i].compilers[j].interpars := main.replacesub(
        comp.Strings[j * fieldsCount + 4], compilerParamsEmtpy, '', '');
      cstruct[i].compilers[j].id := trim(main.replacesub(
        comp.Strings[j * fieldsCount + 5], compilerParamsEmtpy, '', ''));
    end;
    comp.Destroy;
  end;
  ext.Destroy;
end;

procedure writeCStruct;
var i, j, k, m0, m1: integer;
s: string;
ss: array[0..5] of string;
begin
  sett.EraseSection('Compilers');
  m0 := length(cstruct) - 1;
  for i := 0 to m0 do begin
    s := '';
    m1 := length(cstruct[i].compilers) - 1;
    for j := 0 to m1 do begin
      ss[0] := cstruct[i].compilers[j].name;
      ss[1] := cstruct[i].compilers[j].path;
      ss[2] := cstruct[i].compilers[j].pars;
      ss[3] := cstruct[i].compilers[j].inter;
      ss[4] := cstruct[i].compilers[j].interpars;
      ss[5] := cstruct[i].compilers[j].id;
      for k := 0 to 5 do
        if ss[k] = '' then
          ss[k] := compilerParamsEmtpy;
      s := s + ss[0]
        + compilerParamsSeparator + ss[1]
        + compilerParamsSeparator + ss[2]
        + compilerParamsSeparator + ss[3]
        + compilerParamsSeparator + ss[4]
        + compilerParamsSeparator + ss[5];
      if j < m1 then
        s := s + compilerParamsSeparator;
    end;
    sett.WriteString('Compilers', cstruct[i].name, s);
  end;
end;

procedure renewExtUpDown;
var n: integer;
begin
  main.extupdown.Min := 0;
  main.extupdown.Max := main.extlist.Count - 1;
  n := main.extlist.ItemIndex;
  if n > -1 then main.extupdown.Position := main.extlist.Count - 1 - n;
end;

procedure renewCompUpDown;
var n: integer;
begin
  main.compupdown.Min := 0;
  main.compupdown.Max := main.extlist.Count - 1;
  n := main.complist.ItemIndex;
  if n > -1 then main.compupdown.Position := main.complist.Count - 1 - n;
end;

procedure disableCompArea;
begin
  with main do begin
    complist.Items.Text := '';
    complist.Enabled := false;
    compaddb.Enabled := false;
    compdelb.Enabled := false;
    compeditb.Enabled := false;
    compupdown.Enabled := false;

    comppath.Text := '';
    comppath.Enabled := false;
    button5.Enabled := false;
    comppars.Text := '';
    comppars.Enabled := false;

    interpath.Text := '';
    interpath.Enabled := false;
    button2.Enabled := false;
    interpars.Text := '';
    interpars.Enabled := false;

    compid.Text := '';
    compid.Enabled := false;
  end;
end;

procedure Tmain.FormCreate(Sender: TObject);
var
  t: string;
  i: integer;
begin
  main.Height := screen.Height - 100;
  sett := tinifile.Create(extractfilepath(application.ExeName) + 'settings.ini');
  workfolder := sett.ReadString('Paths', 'WorkFolder', '');
  workfname.Text := workfolder;
  if workfolder <> '' then begin
     if workfolder[length(workfolder)] <> '\' then workfolder := workfolder + '\';
     if fileexists(workfolder + 'result_full.html') then button1.Visible := true;
     workfolder := workfname.Text;
  end;

  testfolder := sett.ReadString('Paths', 'TestFolder', '');
  testpath.Text := testfolder;
  readCStruct;
  for i := 1 to length(cstruct) do extlist.Items.Add(cstruct[i-1].name);
  renewExtUpDown;
  disableCompArea;
  test := sett.ReadString('Paths', 'TestName', '');
  testname.Text := test;
  intest := sett.ReadString('Paths', 'InTestName', '');
  intestname.Text := intest;
  inname := sett.ReadString('Paths', 'InName', '');
  infname.Text := inname;
  outtest := sett.ReadString('Paths', 'OutTestName', '');
  outtestname.Text := outtest;
  outname := sett.ReadString('Paths', 'OutName', '');
  outfname.Text := outname;
  t := sett.ReadString('Tasks', 'Tasklist', '');
  t := replacesub(t, '\n', #10, '');
  tasklist.Items.Text := t;
  linebreak.ItemIndex := strtoint(sett.ReadString('Settings', 'LineBreak', '0'));
  UpdateLinebreakPoints();
end;

procedure Tmain.dxButton4Click(Sender: TObject);
begin
  messagedlg('Система тестування «STS» (версія 2.2).' + #10 + #13 +
    'Розробка: Данило Мисак, 2006—2018.', mtInformation, [mbOk], 0);
end;

procedure Delay(dwMilliseconds: Longint);
var
  iStart, iStop: longint;
begin
  iStart := GetTickCount;
  repeat
    iStop := GetTickCount;
    Application.ProcessMessages;
  until iStop - iStart >= dwMilliseconds;
end;

function CompareFiles(FirstFile, SecondFile: string; addLineBreakToFirst: boolean): boolean;
var
  f1, f2: TMemoryStream;
  newFile: string;
  f: text;
begin
  Result := false;
  f1 := TMemoryStream.Create;
  f2 := TMemoryStream.Create;
  try
    if addLineBreakToFirst then begin
      newFile := firstFile + '_lb';
      copyFile(pchar(firstFile), pchar(newFile), false);
      assignfile(f, newFile);
      append(f);
      writeln(f);
      closefile(f);
      firstFile := newFile;
    end;
    f1.LoadFromFile(FirstFile);
    f2.LoadFromFile(SecondFile);
    if f1.Size = f2.Size then
      Result := CompareMem(f1.Memory, f2.memory, f1.Size);
    if addLineBreakToFirst and fileexists(newFile) then deletefile(newFile);
  finally
    f2.Free;
    f1.Free;
  end;
end;

function IsWhiteSpace(c: char): boolean;
begin
  result := (c = ' ') or (c = #10) or (c = #13);
end;

function CompareFilesIgnoringWhitespace(FirstFile, SecondFile: string;
  respectLines: boolean; var pos1, pos2: integer): boolean;
var
  f1, f2: text;
  l1, l2: integer;
  c1, c2: char;

  procedure ReadAndUpdate(var f: text; var c: char; var pos, line: integer);
  var lastCr: boolean; // RichEdit автоматично заміняє самотнє \n на \r\n
  begin
    lastCr := c = #13;
    read(f, c);
    inc(pos);
    if c = #10 then begin
      if not lastCr then
        inc(pos);
      inc(line);
    end;
  end;

begin
  result := false;
  assignfile(f1, FirstFile);
  reset(f1);
  assignfile(f2, SecondFile);
  reset(f2);
  l1 := 0;
  l2 := 0;
  pos1 := -1;
  pos2 := -1;
  c1 := ' ';
  c2 := ' ';
  while true do begin
    if not IsWhiteSpace(c1) then
      c1 := ' ';
    while IsWhiteSpace(c1) and not eof(f1) do begin
      ReadAndUpdate(f1, c1, pos1, l1);
    end;

    if not IsWhiteSpace(c2) then
      c2 := ' ';
    while IsWhiteSpace(c2) and not eof(f2) do begin
      ReadAndUpdate(f2, c2, pos2, l2);
    end;

    if IsWhiteSpace(c1) and IsWhiteSpace(c2) then begin
      result := true;
      inc(pos1);
      inc(pos2);
      break;
    end else if IsWhiteSpace(c1) then begin
      result := false;
      inc(pos1);
      break;
    end else if IsWhiteSpace(c2) then begin
      result := false;
      inc(pos2);
      break;
    end else if respectLines and (l1 <> l2) then begin
      result := false;
      break;
    end else begin
      while (c1 = c2)
        and not IsWhiteSpace(c1) and not IsWhiteSpace(c2)
        and not eof(f1) and not eof(f2)
      do begin
        ReadAndUpdate(f1, c1, pos1, l1);
        ReadAndUpdate(f2, c2, pos2, l2);
      end;
      if (not IsWhiteSpace(c1) or not IsWhiteSpace(c2))
        and (IsWhiteSpace(c1) or IsWhiteSpace(c2) or (c1 <> c2))
      then begin
        result := false;
        break;
      end;
    end;
  end;
  close(f1);
  close(f2);
end;

function GetTestInfo(curtest: integer; var pts: integer): boolean;
begin
  result := false;
  if cinfo[curtest] > 0 then begin
    pts := cinfo[curtest];
    result := true;
  end;
end;

function GetTestSetting(key: string; defaultValue: integer): integer;
var i: integer;
begin
  key := ansilowercase(key);
  result := defaultValue;
  for i := 0 to length(cinfo_settings) - 1 do begin
    if cinfo_settings[i].key = key then begin
      result := cinfo_settings[i].value;
      break;
    end;
  end;
end;

function TryParseTestSetting(s: string): boolean;
var
  i, l, sl, value: integer;
  key: string;
begin
  l := length(s);
  key := '';
  i := 1;
  while i <= l do begin
    if s[i] = ':' then begin
      key := ansilowercase(trim(copy(s, 1, i - 1)));
      break;
    end;
    inc(i);
  end;
  if key = '' then begin
    result := false;
  end else begin
    value := 0;
    result := true;
    try
      value := strtoint(trim(copy(s, i + 1, l - i)));
    except
      result := false;
    end;
    if result then begin
      sl := length(cinfo_settings);
      setlength(cinfo_settings, sl + 1);
      cinfo_settings[sl].key := key;
      cinfo_settings[sl].value := value;
    end;
  end;
end;

procedure PrepareTestInfo(test: string);
var
  t: textfile;
  s: string;
  i, j, st, pts, curnum, curnum2: integer;
begin
  if not fileexists(test) then
    messagedlg('Файлу ' + test + ' не існує.', mtError, [mbOk], 0);
  cmaxtest := -1;
  setlength(cinfo_settings, 0);
  for i := 0 to 1023 do
    cinfo[i] := 0;
  assignfile(t, test);
  reset(t);
  read(t, cinfo_tl);
  if seekeoln(t) then
    cinfo_ml := 0
  else begin
    read(t, cinfo_ml);
    cinfo_ml := cinfo_ml * 1024;
  end;
  readln(t);
  while not eof(t) do begin
    readln(t, s);
    s := trim(s);
    if (s = '') or TryParseTestSetting(s) then
      continue;
    pts := 0;
    st := 1;
    for i := length(s) downto 1 do begin
      if (s[i] > '9') or (s[i] < '0') then
        break;
      pts := pts + st * (ord(s[i]) - ord('0'));
      st := st * 10;
    end;
    if i <= 1 then begin
      messagedlg('Не вдалось прочитати інформацію про тести: неправильний синтаксис у файлі '
        + test + '.', mtWarning, [mbOk], 0);
    end;
    if pts = 0 then continue;
    delete(s, i + 1, length(s) - i);
    s := trim(s);
    i := 2;
    while i < length(s) do begin
      if s[i] <> ' ' then
        inc(i)
      else begin
        if (s[i - 1] < '0') or (s[i - 1] > '9') or (s[i + 1] < '0') or (s[i + 1] > '9') then
          delete(s, i, 1)
        else begin
          s[i] := ',';
          inc(i);
        end;
      end;
    end;  
    s := s + ',';
    i := 1;
    while i < length(s) do begin
      curnum := 0;
      while (s[i] >= '0') and (s[i] <= '9') do begin
        curnum := curnum * 10 + ord(s[i]) - ord('0');
        inc(i);
      end;
      if s[i] = '-' then begin
        inc(i);
        curnum2 := 0;
        while (s[i] >= '0') and (s[i] <= '9') do begin
          curnum2 := curnum2 * 10 + ord(s[i]) - ord('0');
          inc(i);
        end;
        if curnum2 > cmaxtest then cmaxtest := curnum2;
        for j := curnum to curnum2 do cinfo[j] := pts;
        inc(i);
      end else begin
        if curnum > cmaxtest then cmaxtest := curnum;
        cinfo[curnum] := pts;
        inc(i);
      end;
    end;
  end;
  closefile(t);
end;

function getfname(task: string; num, tp: integer): string;
begin
  if tp = 0 then result := main.replacesub(
    main.replacesub(test, '%task', task, ''), '%num', inttostr(num), '0')
  else if tp = 1 then result := main.replacesub(
    main.replacesub(intest, '%task', task, ''), '%num', inttostr(num), '0')
  else if tp = 2 then result := main.replacesub(
    main.replacesub(outtest, '%task', task, ''), '%num', inttostr(num), '0')
  else if tp = 3 then result := main.replacesub(inname, '%task', task, '')
  else if tp = 4 then result := main.replacesub(outname, '%task', task, '');
end;

function getfirstline(fname: string): string;
var f: text;
begin
  assignfile(f, fname);
  reset(f);
  readln(f, result);
  close(f);
end;

function formatBytes(bytes: int64): string;
begin
if bytes < 1024 then
  result := inttostr(bytes) + ' Б'
else if bytes <= 1023 * 1024 then
  result := inttostr(ceil(bytes / 1024)) + ' КБ'
else
  result := inttostr(ceil(bytes / (1024 * 1024))) + ' МБ';
end;

procedure deleteFileD(filename: string);
begin
  if fileexists(filename) and not deletefile(filename) then begin
    delay(5000);
    if fileexists(filename) and not deletefile(filename) then
      showmessage('Неможливо видалити файл ' + filename +
        '. Будь ласка, знищіть усі процеси, що його блокують, і видаліть файл вручну.');
  end;
end;

procedure emptyFolder(folder: string);
var sr: TSearchRec;
begin
  if FindFirst(folder + '\*', faAnyFile, sr) = 0 then
    repeat
      if (sr.name <> '.') and (sr.name <> '..') then
        deleteFileD(folder + '\' + sr.Name);
    until FindNext(sr) <> 0;
  FindClose(sr);
end;

procedure testOne(competitor, competitor_name, task: string; task_num: integer;
  var full_result, full_result_html: string; var points: double; var wrong_compiler: boolean);
var
  input_s, infile, outfile, ansfile, contestant_ans, comp_id, comp_name,
  program_name, milliseconds_with_ms, span_title, tf_file, tf_exe, run_exe,
  run_parameters, ws_type: string;
  curtest, curres, testpts, rt, rt1, rt2, milliseconds, milliseconds_cpu, i,
  ext_ind, comp_ind, pos1, pos2, extra_time: integer;
  exitCode: cardinal;
  correct, with_lb, with_ws, do_compilation, do_interpretation, interactive: boolean;
  input, prompt: pchar;
  succ: double;
  memory: int64;
  use_stdin, use_stdout: boolean;
begin
  wrong_compiler := false;

  infile := getfname(task, 0, 3);
  if infile = '' then begin
    use_stdin := true;
    infile := stdinFileName;
  end else begin
    use_stdin := false;
  end;

  outfile := getfname(task, 0, 4);
  if outfile = '' then begin
    use_stdout := true;
    outfile := stdoutFileName;
  end else begin
    use_stdout := false;
  end;

  ext_ind := -1;
  for i := 0 to length(cstruct) - 1 do begin
    if fileexists(workfolder + competitor + '\' + task + '.' + cstruct[i].name) then begin
      ext_ind := i;
      break;
    end;
  end;
  if ext_ind = -1 then begin
    points := 0;
    full_result := 'Файлу з розв’язком не знайдено';
    full_result_html := '<span class="task">' + uppercase(task) +
      '</span>/<span class="task_result">%result</span>: Файлу з розв’язком не знайдено.';
  end else begin
    emptyFolder(workfolder + testingFolder);
    program_name := workfolder + competitor + '\' + task + '.' + cstruct[ext_ind].name;
    tf_file := workfolder + testingFolder + '\' + task + '.' + cstruct[ext_ind].name;
    copyfile(pchar(program_name), pchar(tf_file), false);

    comp_id := trim(getfirstline(tf_file));
    comp_ind := -1;
    for i := 0 to length(cstruct[ext_ind].compilers) - 1 do begin
      if cstruct[ext_ind].compilers[i].id = '' then begin
        if length(cstruct[ext_ind].compilers) = 1 then begin
          comp_ind := 0;
          break;
        end;
      end else if cstruct[ext_ind].compilers[i].id = comp_id then begin
        comp_ind := i;
        break;
      end;
    end;
    if comp_ind = -1 then begin
      comp_ind := 0;
      wrong_compiler := true;
    end;
    comp_name := cstruct[ext_ind].compilers[comp_ind].name;

    do_compilation := cstruct[ext_ind].compilers[comp_ind].path <> '';
    do_interpretation := cstruct[ext_ind].compilers[comp_ind].inter <> '';

    if do_compilation then begin
      tf_exe := workfolder + testingFolder + '\' + task + '.exe';
      curres := ExecAndWait(cstruct[ext_ind].compilers[comp_ind].path,
        main.replacesub(main.replacesub(cstruct[ext_ind].compilers[comp_ind].pars,
        '%file', '"' + tf_file + '"', ''), '%exe', '"' + tf_exe + '"', ''),
        extractfilepath(cstruct[ext_ind].compilers[comp_ind].path), compilationTimeLimit,
        SW_HIDE, false, false, false, milliseconds, milliseconds_cpu, memory, exitCode);
      killtask('ntvdm.exe');
      killtask(extractfilename(cstruct[ext_ind].compilers[comp_ind].path));
      delay(100);
    end;

    if do_compilation and ((curres <= 0) or (exitCode <> 0)
      or (not do_interpretation and not fileexists(tf_exe)))
    then begin
      points := 0;
      if curres = 0 then begin
        full_result := 'Час компіляції вичерпано';
        full_result_html := '<span class="task"><a href="#mode=task;task=' + task +
          ';result=CTL;files=' + program_name + ';name=' + competitor_name + '">' + uppercase(task) +
          '</a></span>/<span class="task_result">%result</span>: Час компіляції вичерпано.';
      end else begin
        full_result := 'Помилка компіляції';
        full_result_html := '<span class="task"><a href="#mode=task;task=' + task +
          ';result=CER;files=' + program_name + ';name=' + competitor_name + '">' + uppercase(task) +
          '</a></span>/<span class="task_result">%result</span>: Помилка компіляції.';
      end;
    end else begin
      createdir(workfolder + competitor + '\!output\' + task);
      full_result := '';
      full_result_html := '<span class="task"><a href="#mode=task;task=' + task +
        ';result=COK;files=' + program_name + ';name=' + competitor_name + '">' + uppercase(task) +
        '</a></span>/<span class="task_result">%result</span>:';
      points := 0;
      curtest := 1;

      prepareTestInfo(testfolder + getfname(task, curtest, 0));
      for curtest := 0 to cMaxTest do begin
        if getTestInfo(curtest, testpts) then begin
          input_s := testfolder + getfname(task, curtest, 1);
          input := pchar(input_s);
          ansfile := testfolder + getfname(task, curtest, 2);
          prompt := pchar(ansfile);
          copyfile(input, pchar(workfolder + testingFolder + '\' + infile), false);
          if do_interpretation then begin
            run_exe := cstruct[ext_ind].compilers[comp_ind].inter;
            run_parameters := main.replacesub(main.replacesub(
              cstruct[ext_ind].compilers[comp_ind].interpars,
              '%file', '"' + tf_file + '"', ''), '%task', task, '');
          end else begin
            run_exe := tf_exe;
            run_parameters := '';
          end;
          extra_time := GetTestSetting('extraTime', cinfo_tl * 5 div 10);
          interactive := GetTestSetting('interactive', 0) <> 0;
          curres := ExecAndWait(run_exe, run_parameters, workfolder + testingFolder,
            cinfo_tl + extra_time, SW_hide, interactive, use_stdin, use_stdout,
            milliseconds, milliseconds_cpu, memory, exitCode);
          rt1 := killtask('dwwin.exe');
          rt2 := killtask('WerFault.exe');
          if killtask('cmd.exe') <> 0 then
            delay(2000); // Виклик System("pause") у програмі учасника і, можливо,
            // якісь інші системні речі можуть запустити cmd.exe і навіть заблокувати вхідні/вихідні файли
          if (rt1 <> 0) or (rt2 <> 0) then
            rt := 1
          else
            rt := 0;
          if (rt <> 0) and main.largewin.Checked then begin
            online.Hide();
            online.Show();
          end;
          milliseconds_with_ms := inttostr(milliseconds_cpu) + '/' + inttostr(milliseconds) + ' мс';
          span_title := 'title="Тест ' + inttostr(curtest) + ': ' +
            milliseconds_with_ms + ', ' + formatBytes(memory) + '"';
          if rt <> 0 then
            curres := -1;
          if curres = 1 then begin
            if milliseconds_cpu > cinfo_tl then
              curres := 0
            else if exitCode <> 0 then
              curres := -1
            else if (cinfo_ml > 0) and (memory > cinfo_ml) then
              curres := -2;
          end;
          if curres <= 0 then begin
            if curres = -1 then begin
              full_result := full_result + ' RT';
              full_result_html := full_result_html + ' <span class="test rt" '
                + span_title + '><a href="#mode=rt;task=' + task + ';test='
                + inttostr(curtest) + ';result=RT;time=' + inttostr(milliseconds_cpu)
                + ';memory=' + inttostr(memory) + ';files=' + input_s + ',' + ansfile
                + ',' + program_name + ';name=' + competitor_name + '">RT</a></span>';
            end else if curres = -2 then begin
              full_result := full_result + ' ML';
              full_result_html := full_result_html + ' <span class="test ml" '
                + span_title + '><a href="#mode=ml;task=' + task + ';test='
                + inttostr(curtest) + ';result=ML;time=' + inttostr(milliseconds_cpu)
                + ';memory=' + inttostr(memory) + ';files=' + input_s + ',' + ansfile
                + ',' + program_name + ';name=' + competitor_name + '">ML</a></span>';
            end else begin
              full_result := full_result + ' TL';
              full_result_html := full_result_html + ' <span class="test tl" '
                + span_title + '><a href="#mode=tl;task=' + task + ';test='
                + inttostr(curtest) + ';result=TL;time=' + inttostr(milliseconds_cpu)
                + ';memory=' + inttostr(memory) + ';files=' + input_s + ',' + ansfile
                + ',' + program_name + ';name=' + competitor_name + '">TL</a></span>';
            end;
          end else if not fileexists(workfolder + testingFolder + '\' + outfile) then begin
            full_result := full_result + ' FE';
            full_result_html := full_result_html + ' <span class="test fe" '
              + span_title + '><a href="#mode=fe;task=' + task + ';test='
              + inttostr(curtest) + ';result=FE;time=' + inttostr(milliseconds_cpu)
              + ';memory=' + inttostr(memory) + ';files=' + input_s + ',' + ansfile
              + ',' + program_name + ';name=' + competitor_name + '">FE</a></span>';
          end else begin
            contestant_ans := workfolder + competitor + '\!output\'
              + task + '\' + extractfilename(ansfile);
            copyfile(pchar(workfolder + testingFolder + '\' + outfile),
              pchar(contestant_ans), false);
            succ := 0;
            correct := false;
            with_lb := false;
            with_ws := false;
            pos1 := -1;
            pos2 := -1;
            if dllsb[task_num] then begin
              succ := dlls[task_num](input,
                pchar(workfolder + testingFolder + '\' + outfile), prompt, testpts);
              correct := succ > 0;  
            end else if CompareFiles(workfolder + testingFolder + '\' + outfile, prompt, false)
            then begin
              succ := testpts;
              correct := true;
            end else if (sett_linebreak >= 1) and CompareFiles(
              workfolder + testingFolder + '\' + outfile, prompt, true)
            then begin
              if sett_linebreak_pts = 1 then begin
                succ := testpts;
              end else begin
                succ := round(testpts * sett_linebreak_pts * 10) / 10;
                with_lb := true;
              end;
              correct := true;
            end else if (sett_linebreak >= 2) and CompareFilesIgnoringWhitespace(
              workfolder + testingFolder + '\' + outfile, prompt, sett_linebreak = 2, pos1, pos2)
            then begin
              if sett_linebreak_pts = 1 then begin
                succ := testpts;
              end else begin
                succ := round(testpts * sett_linebreak_pts * 10) / 10;
                with_ws := true;
              end;
              correct := true;
            end;
            if correct then begin
              points := points + succ;
              if with_lb or with_ws then begin
                if with_lb then
                  ws_type := 'LB'
                else
                  ws_type := 'WS';
                full_result := full_result + ' ' + floattostr(succ) + '/' + ws_type;
                full_result_html := full_result_html + ' <span class="test lb" '
                  + span_title + '><a href="#mode=lb;task=' + task + ';test='
                  + inttostr(curtest) + ';result=LB;time=' + inttostr(milliseconds_cpu)
                  + ';memory=' + inttostr(memory) + ';files=' + input_s + ','
                  + contestant_ans + ',' + program_name + ';name=' + competitor_name
                  + '">' + floattostr(succ) + '/' + ws_type + '</a></span>';
              end else begin
                full_result := full_result + ' ' + floattostr(succ);
                full_result_html := full_result_html + ' <span class="test passed" '
                  + span_title + '><a href="#mode=passed;task=' + task + ';test='
                  + inttostr(curtest) + ';result=OK;time=' + inttostr(milliseconds_cpu)
                  + ';memory=' + inttostr(memory) + ';files=' + input_s + ','
                  + contestant_ans + ',' + program_name + ';name=' + competitor_name
                  + '">' + floattostr(succ) + '</a></span>';
              end;
            end else begin
              full_result := full_result + ' WA';
              full_result_html := full_result_html + ' <span class="test wa" '
                + span_title + '><a href="#mode=wa;task=' + task + ';test='
                + inttostr(curtest) + ';result=WA;time=' + inttostr(milliseconds_cpu)
                + ';memory=' + inttostr(memory) + ';files=' + input_s + ','
                + program_name + ',' + contestant_ans + ',' + ansfile + ';name='
                + competitor_name + ';pos1=' + inttostr(pos1) + ';pos2=' + inttostr(pos2)
                + '">WA</a></span>';
            end;
          end;
          killtask('ntvdm.exe');
          killtask(extractfilename(run_exe));
          delay(100);
        end;
      end;
    end;
    full_result := full_result + ' (' + comp_name + ')';
    full_result_html := full_result_html + ' | ' + '<span class="compiler">' + comp_name + '</span>';
  end;
  full_result := trim(full_result);
  full_result_html := trim(full_result_html); // Можливо, зайве
end;

function dos2win(St: string): string;
var
  Ch: PChar;
begin
  Ch := StrAlloc(Length(St) + 1);
  OemToAnsi(PChar(St), Ch);
  Result := Ch;
  StrDispose(Ch)
end;

function isdosenc(s: string): boolean;
var l, i, c: integer;
begin
  l := length(s);
  c := 0;
  for i := 1 to l do
    if ((s[i] >= 'а') and (s[i] <= 'я'))
    or ((s[i] >= 'А') and (s[i] <= 'Я'))
    or ((s[i] >= '0') and (s[i] <= '9'))
    or ((s[i] >= 'a') and (s[i] <= 'z'))
    or ((s[i] >= 'A') and (s[i] <= 'Z'))
    or (s[i] = '-') or (s[i] = '.') or (s[i] = ',')
    or (s[i] = 'і') or (s[i] = 'І')
    or (s[i] = 'ї') or (s[i] = 'Ї')
    or (s[i] = 'ґ') or (s[i] = 'Ґ')
  then
    inc(c);
  result := (c * 3 < l * 2);
end;

function ColorToHtml(DColor: TColor): string;
var
  tmpRGB: TColorRef;
begin
  tmpRGB := ColorToRGB(DColor);
  Result := Format('#%.2x%.2x%.2x',
    [GetRValue(tmpRGB), GetGValue(tmpRGB), GetBValue(tmpRGB)]);
end;

procedure logLine(line: string; largewin: boolean);
begin
  main.res.Lines.Add(line);
  main.Refresh;
  if largewin then begin
    online.res.Lines.Add(line);
    online.Refresh;
  end;
end;

procedure fullTesting;
var
  f, c, res, html: textfile;
  s, cname, cclass, cschool, full_result, full_result_html, dllname, temp, notes: string;
  i, j: integer;
  fpoints, points: double;
  denc, largewin, succeed, wrong_compiler: boolean;
begin
  setlength(fs, 0);
  createdir(workfolder + testingFolder + '\');
  main.gauge1.Progress := 0;
  main.gauge1.Visible := true;
  main.res.Clear();
  main.Refresh();
  largewin := main.largewin.Checked;
  if largewin then begin
    if not assigned(online) then begin
      online := tonline.Create(main);
      online.Height := screen.Height - 100;
    end;
    online.res.Clear();
    online.Show();
    online.Refresh();
  end else begin
    if assigned(online) then
      online.Hide();
  end;
  
  assignfile(f, workfolder + 'list.txt');
  reset(f);
  while not eof(f) do begin
    readln(f, s);
    if trim(s) = '' then
      break;
    if not directoryexists(workfolder + s + '\') then
      continue;
    setlength(fs, length(fs) + 1);
    fs[length(fs) - 1] := s;
  end;
  closefile(f);
  main.Gauge1.MaxValue := main.tasklist.Items.Count * length(fs);

  setlength(dlls, main.tasklist.Items.Count);
  setlength(dllsh, main.tasklist.Items.Count);
  setlength(dllsb, main.tasklist.Items.Count);

  for i := 0 to main.tasklist.Items.Count - 1 do begin
    dllname := extractfilepath(testfolder + getfname(main.tasklist.Items[i], 0, 2)) + 'check.dll';
    dllsb[i] := false;
    if fileexists(dllname) then begin
      dllsh[i] := LoadLibrary(pchar(dllname));
      if dllsh[i] = 0 then
        messagedlg('Неможливо завантажити DLL: ' + dllname + '.', mtError, [mbOK], 0)
      else begin
        @dlls[i] := GetProcAddress(dllsh[i], 'check_output');
        if @dlls[i] = nil then
          messagedlg('Неправильний формат DLL: ' + dllname + '.', mtError, [mbOK], 0)
        else
          dllsb[i] := true;
      end;
    end;
  end;

  assignfile(res, workfolder + 'result.csv');
  rewrite(res);
  write(res, 'Учасник;Клас;Місце навчання;');

  assignfile(html, workfolder + 'result_full.html');
  rewrite(html);
  write(html, '<html><head><title>Результати тестування</title>');
  write(html, '<meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />');
  write(html, '<style>body {font-family: "Arial"; font-size: 16px; line-height: 145%; background: ' + ColorToHtml(clBtnFace) +
    '} a {color: black} span.name, span.test, span.result, span.task_result {font-weight: bold} span.test.passed {font-weight: normal} span.compiler {font-style: italic} ');
  write(html, 'span.test.wa a {color: red} span.test.fe a {color: orange} span.test.lb a {color: green} span.test.rt a {color: brown} span.test.tl a {color: blue} span.test.ml a {color: indigo}</style>');
  write(html, '</head><body>');

  for j := 0 to main.tasklist.Items.Count - 1 do
    write(res, main.tasklist.items[j] + ';');
  writeln(res, 'Сума;Недоліки');
  writeln(res);
  for j := 0 to length(fs) - 1 do begin
    notes := '';
    s := fs[j];
    if directoryexists(workfolder + s + '\!output') then
      deldir(workfolder + s + '\!output');
    createdir(workfolder + s + '\!output\');
    if not fileexists(workfolder + s + '\' + infoFile + '.txt') then begin
      if fileexists(workfolder + s + '\' + infoFile + '.txt.txt') then begin
        copyfile(pchar(workfolder + s + '\' + infoFile + '.txt.txt'),
          pchar(workfolder + s + '\' + infoFile + '.txt'), false);
        deletefile(workfolder + s + '\' + infoFile + '.txt.txt')
      end else if fileexists(workfolder + s + '\' + infoFileAlt + '.txt') then begin
        copyfile(pchar(workfolder + s + '\' + infoFileAlt + '.txt'),
          pchar(workfolder + s + '\' + infoFile + '.txt'), false);
        deletefile(workfolder + s + '\' + infoFileAlt + '.txt');
      end else if fileexists(workfolder + s + '\' + infoFileAlt + '.txt.txt') then begin
        copyfile(pchar(workfolder + s + '\' + infoFileAlt + '.txt.txt'),
          pchar(workfolder + s + '\' + infoFile + '.txt'), false);
        deletefile(workfolder + s + '\' + infoFileAlt + '.txt.txt');
      end;
    end;

    cname := trim(s);
    cschool := '';
    cclass := '';

    if fileexists(workfolder + s + '\' + infoFile + '.txt') then begin
      assignfile(c, workfolder + s + '\' + infoFile + '.txt');
      reset(c);
      denc := false;
      if not eof(c) then begin
        readln(c, cname);
        denc := isDosEnc(cname);
        if denc then
          cname := dos2win(cname);
      end;
      if not eof(c) then
        readln(c, temp);
      if not eof(c) then begin
        readln(c, cschool);
        if denc then
          cschool := dos2win(cschool);
      end;
      if not eof(c) then begin
        readln(c, cclass);
        if denc then cclass := dos2win(cclass);
      end;
      close(c);
    end else
      notes := infoFile + '.txt';

    cclass := trim(cclass);
    cschool := trim(cschool);
    if cclass = '' then
      cclass := '<не вказано>';
    if cschool = '' then
      cschool := '<не вказано>';

    assignfile(c, workfolder + s + '\!result.txt');
    rewrite(c);

    logLine(cname + ' (клас: ' + cclass + ', школа: ' + cschool + ')', largewin);
    write(res, cname + ';' + cclass + ';' + cschool + ';');
    write(html, '<span class="name"><a href="#mode=contestant;files=' + workfolder
      + s + '">' + cname + '</a></span> (клас: ' + cclass + ', школа: ' + cschool + ')<br />');
    fpoints := 0;
    for i := 0 to main.tasklist.Items.Count - 1 do begin
      testOne(s, cname, main.tasklist.Items[i], i, full_result, full_result_html,
        points, wrong_compiler);
      if wrong_compiler then begin
        if notes <> '' then notes := notes + ', ';
        notes := notes + main.tasklist.Items[i] + '-компілятор';
      end;
      fpoints := fpoints + points;
      logLine(floattostr(points) + ': ' + full_result, largewin);
      write(res, floattostr(points) + ';');
      write(html, main.replacesub(full_result_html, '%result', floattostr(points), '') + '<br />');
      writeln(c, main.tasklist.Items[i] + '/' + floattostr(points) + ': ' + full_result);
      main.Gauge1.Progress := main.Gauge1.Progress + 1;
      main.Refresh();
    end;
    logLine(floattostr(fpoints), largewin);
    writeln(res, floattostr(fpoints) + ';' + notes);
    write(html, '<span class="result">' + floattostr(fpoints) + '</span><br />');
    if j <> length(fs) - 1 then begin
      logLine('', largewin);
      write(html, '<br />');
    end;
    writeln(c, floattostr(fpoints));
    close(c);
  end;

  closefile(res);
  write(html, '</body></html>');
  closefile(html);
  main.res.Lines.SaveToFile(workfolder + 'result_full.txt');
  for i := 0 to length(dllsb) - 1 do
    if dllsb[i] then
      FreeLibrary(dllsh[i]);
  setlength(dlls, 0);
  setlength(dllsh, 0);
  setlength(dllsb, 0);

  emptyFolder(workfolder + testingFolder);

  repeat
    succeed := true;
    try
      sleep(20);
      rmdir(workfolder + testingFolder + '\');
    except
      succeed := false;
    end;
  until succeed;

  main.gauge1.Visible := false;
end;

procedure Tmain.dxButton5Click(Sender: TObject);
var i, j: integer;
begin
  if workfolder = '' then begin
    messagedlg('Необхідно вибрати робочу теку.', mtInformation, [mbOk], 0);
    exit;
  end;
  if testfolder = '' then begin
    messagedlg('Необхідно вибрати каталог із тестами.', mtInformation, [mbOk], 0);
    exit;
  end;
  if length(cstruct) = 0 then begin
    messagedlg('Необхідно додати хоча б одне розширення.', mtInformation, [mbOk], 0);
    exit;
  end;
  for i := 0 to length(cstruct) - 1 do begin
    if length(cstruct[i].compilers) = 0 then begin
      messagedlg('Необхідно додати хоча б один компілятор для розширення «'
        + cstruct[i].name + '».', mtInformation, [mbOk], 0);
      exit;
    end;
    for j := 0 to length(cstruct[i].compilers) - 1 do begin
      if (cstruct[i].compilers[j].path = '') and (cstruct[i].compilers[j].inter = '')
      then begin
        messagedlg('Необхідно вказати шлях до файлу компілятора або інтерпретатора «'
          + cstruct[i].compilers[j].name + '» (розширення «' + cstruct[i].name + '»).',
          mtInformation, [mbOk], 0);
        exit;
      end;
      if (cstruct[i].compilers[j].path <> '') and (cstruct[i].compilers[j].pars = '')
      then begin
        messagedlg('Необхідно вказати параметри компіляції для «' +
          cstruct[i].compilers[j].name + '» (розширення «' + cstruct[i].name + '»).',
          mtInformation, [mbOk], 0);
        exit;
      end;
      if (cstruct[i].compilers[j].inter <> '') and (cstruct[i].compilers[j].interpars = '')
      then begin
        messagedlg('Необхідно вказати параметри інтерпретації для «' +
          cstruct[i].compilers[j].name + '» (розширення «' + cstruct[i].name + '»).',
          mtInformation, [mbOk], 0);
        exit;
      end;
      if (j > 0) and (cstruct[i].compilers[j].id = '') then begin
        messagedlg('Необхідно вказати коментар-ідентифікатор для «' +
          cstruct[i].compilers[j].name + '» (розширення «' + cstruct[i].name + '»).',
          mtInformation, [mbOk], 0);
        exit;
      end;
    end;
  end;

  if tasklist.Items.Count < 1 then begin
    messagedlg('Необхідно ввести назву хоча б однієї задачі.', mtInformation, [mbOk], 0);
    exit;
  end;

  if button1.Visible and (messagedlg(
    'Якщо запустити перевірку заново, усі попередні результати буде втрачено. Ви дійсно бажаєте здійснити повторну перевірку?',
    mtConfirmation, [mbYes, mbNo, mbCancel], 0) <> mrYes)
  then
    exit;

  sett_linebreak := linebreak.ItemIndex;
  if sett_linebreak > 0 then
    sett_linebreak_pts := strtofloatLB(linebreak_pts.Text);

  if workfolder[length(workfolder)] <> '\' then
    workfolder := workfolder + '\';
  if testfolder[length(testfolder)] <> '\' then
    testfolder := testfolder + '\';

  if not fileexists(workfolder + 'List.txt') then
    dxButton6Click(self);

  addb.Enabled := false;
  delb.Enabled := false;
  editb.Enabled := false;
  dxbutton1.Enabled := false;
  dxbutton2.Enabled := false;
  dxbutton5.Enabled := false;
  dxbutton6.Enabled := false;
  linebreak.Enabled := false;
  linebreak_pts.Enabled := false;
  tasklist.ItemIndex := -1;
  tasklist.Enabled := false;
  testname.ReadOnly := true;
  intestname.ReadOnly := true;
  infname.ReadOnly := true;
  outtestname.ReadOnly := true;
  outfname.ReadOnly := true;
  workfname.ReadOnly := true;
  testpath.ReadOnly := true;
  largewin.Visible := false;
  dxbutton5.Visible := false;
  dxbutton4.Visible := false;
  button1.Visible := false;
  extlist.ItemIndex := -1;
  extlist.Enabled := false;
  extaddb.Enabled := false;
  extdelb.Enabled := false;
  exteditb.Enabled := false;
  extupdown.Enabled := false;
  disableCompArea();
  fullTesting();
  dxbutton4.Visible := true;
  dxbutton5.Visible := true;
  largewin.Visible := true;
  dxbutton1.Enabled := true;
  dxbutton2.Enabled := true;
  dxbutton5.Enabled := true;
  dxbutton6.Enabled := true;
  linebreak.Enabled := true;
  linebreak_pts.Enabled := linebreak.ItemIndex > 0;
  tasklist.Enabled := true;
  addb.Enabled := true;
  testname.ReadOnly := false;
  intestname.ReadOnly := false;
  infname.ReadOnly := false;
  outtestname.ReadOnly := false;
  outfname.ReadOnly := false;
  workfname.ReadOnly := false;
  testpath.ReadOnly := false;
  extlist.Enabled := true;
  extaddb.Enabled := true;
  extlist.Enabled := true;
  button1.Visible := true;
  messagedlg('Тестування завершено.', mtInformation, [mbOk], 0);
end;

procedure Tmain.dxButton6Click(Sender: TObject);
var
  f: textfile;
  sr: tsearchrec;
  renewed: boolean;
begin
  renewed := false;
  if trim(workfolder) = '' then begin
    messagedlg('Необхідно вибрати робочий каталог.', mtInformation, [mbOk], 0);
    exit;
  end;
  if workfolder[length(workfolder)] <> '\' then workfolder := workfolder + '\';
  if fileexists(workfolder + 'List.txt') then begin
    renewed := true;
    if messagedlg('Файл List.txt у робочій теці вже існує. Бажаєте його оновити?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) <> mrYes
    then
      exit;
  end;

  assignfile(f, workfolder + 'List.txt');
  rewrite(f);
  if findfirst(workfolder + '*', fadirectory, sr) = 0 then begin
    repeat
      if (sr.Attr = fadirectory) and (sr.name <> '.') and (sr.name <> '..') then
        writeln(f,sr.name);
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
  closefile(f);

  if renewed then
    messagedlg('Файл-список учасників оновлено.', mtInformation, [mbOk], 0)
  else
    messagedlg('Файл-список учасників створено.', mtInformation, [mbOk], 0);
end;

procedure Tmain.intestnameChange(Sender: TObject);
begin
  intest := ansilowercase(intestname.Text);
  writeinipath('InTestName', intest);
end;

procedure Tmain.testnameChange(Sender: TObject);
begin
  test := ansilowercase(testname.Text);
  writeinipath('TestName', test);
end;

procedure Tmain.outtestnameChange(Sender: TObject);
begin
  outtest := ansilowercase(outtestname.Text);
  writeinipath('OutTestName', outtest);
end;

procedure Tmain.dxButton9Click(Sender: TObject);
var
  f: textfile;
  sr: tsearchrec;
begin
  if trim(workfolder)='' then begin
    messagedlg('Необхідно вибрати робочий каталог.', mtInformation, [mbOk], 0);
    exit;
  end;
  if workfolder[length(workfolder)] <> '\' then workfolder := workfolder + '\';
  if fileexists(workfolder + 'List.txt') then
    winexec(pchar('notepad ' + workfolder + 'List.txt'), sw_show)
  else if messagedlg('Файлу List.txt у робочій теці не існує. Бажаєте створити його автоматично?',
    mtConfirmation, [mbYes, mbNo, mbCancel], 0) = mrYes
  then begin
    assignfile(f, workfolder + 'List.txt');
    rewrite(f);
    if findfirst(workfolder + '*', fadirectory, sr) = 0 then begin
      repeat
        if (sr.Attr = fadirectory) and (sr.name <> '.') and (sr.name <> '..') then
          writeln(f, sr.name);
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
    closefile(f);
    messagedlg('Файл-список учасників створено.', mtInformation, [mbOk], 0);
    winexec(pchar('notepad ' + workfolder + 'List.txt'), sw_show);
  end;
end;

procedure Tmain.infnameChange(Sender: TObject);
begin
  inname := ansilowercase(infname.Text);
  writeinipath('InName', inname);
end;

procedure Tmain.outfnameChange(Sender: TObject);
begin
  outname := ansilowercase(outfname.Text);
  writeinipath('OutName', outname);
end;

procedure Tmain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = 13) and dxButton5.Enabled then begin
    ValidateAndStoreLinebreakPoints();
    dxButton5.Click;
  end;
end;

procedure Tmain.tasklistDblClick(Sender: TObject);
var s: string;
begin
  if tasklist.ItemIndex = -1 then exit;
  s := inputbox('Нова назва', 'Уведіть нову назву задачі:',
    tasklist.Items[tasklist.itemIndex]);
  if trim(s) <> '' then begin
    tasklist.Items[tasklist.ItemIndex] := s;
    writeini('Tasks', 'Tasklist', replacesub(tasklist.Items.Text, #13 + #10, '\n', ''));
  end;
end;

procedure Tmain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ValidateAndStoreLinebreakPoints();
  sett.Free;
end;

procedure Tmain.extaddbClick(Sender: TObject);
var
  s: string;
  n: integer;
begin
  s := inputbox('Нове розширення', 'Уведіть розширення:', '');
  if trim(s) <> '' then begin
    extlist.Items.Add(s);
    n := length(cstruct);
    setlength(cstruct, n + 1);
    cstruct[n].name := s;
    setlength(cstruct[n].compilers, 0);
    renewExtUpDown;
    writeCStruct();
  end;
end;

procedure Tmain.extdelbClick(Sender: TObject);
var i, n, m: integer;
begin
  n := extlist.ItemIndex;
  if (n = -1) or (messagedlg('Ви впевнені, що хочете видалити розширення «' + extlist.Items[n] + '»?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes)
  then
    exit;
  m := length(cstruct) - 1;
  for i := n + 1 to m do
    cstruct[i - 1] := cstruct[i];
  setlength(cstruct, m);
  extlist.Items.Delete(n);
  extdelb.Enabled := false;
  exteditb.Enabled := false;
  extupdown.Enabled := false;
  disableCompArea;
  writeCStruct();
end;

procedure Tmain.extlistClick(Sender: TObject);
var i, n, m: integer;
begin
  n := extlist.ItemIndex;
  if n > -1 then begin
    extdelb.Enabled := true;
    exteditb.Enabled := true;
    renewExtUpDown();
    extupdown.Enabled := true;
    disableCompArea();
    complist.Enabled := true;
    compaddb.Enabled := true;
    m := length(cstruct[n].compilers) - 1;
    for i := 0 to m do
      complist.Items.Add(cstruct[n].compilers[i].name);
    renewCompUpDown();
  end;
end;

procedure Tmain.extupdownClick(Sender: TObject; Button: TUDBtnType);
var
  text: extension;
  ts: string;
  n: integer;
begin
  n := extlist.ItemIndex;
  if button = btnext then begin
    if (n = -1) or (n = 0) then exit;

    ts := extlist.Items[n];
    extlist.Items[n] := extlist.Items[n - 1];
    extlist.Items[n - 1] := ts;

    extlist.ItemIndex := n - 1;

    text := cstruct[n];
    cstruct[n] := cstruct[n - 1];
    cstruct[n - 1] := text;
  end else if button = btprev then begin
    if (n = -1) or (n = extlist.Items.Count - 1) then exit;

    ts := extlist.Items[n];
    extlist.Items[n] := extlist.Items[n + 1];
    extlist.Items[n + 1] := ts;

    extlist.ItemIndex := n + 1;

    text := cstruct[n];
    cstruct[n] := cstruct[n + 1];
    cstruct[n + 1] := text;
  end;
  writeCStruct();
end;

procedure Tmain.extlistDblClick(Sender: TObject);
var
  s: string;
  n: integer;
begin
  n := extlist.ItemIndex;
  if n = -1 then exit;
  s := inputbox('Зміна розширення', 'Уведіть нове розширення:', extlist.Items[n]);
  if trim(s) <> '' then begin
    extlist.Items[n] := s;
    cstruct[n].name := s;
    writeCStruct;
  end;
end;

procedure Tmain.compaddbClick(Sender: TObject);
var
  s: string;
  sext, n: integer;
begin
  s := inputbox('Новий компілятор', 'Уведіть назву компілятора:', '');
  if trim(s) <> '' then begin
    sext := extlist.ItemIndex;
    complist.Items.Add(s);
    n := length(cstruct[sext].compilers);
    setlength(cstruct[sext].compilers, n + 1);
    cstruct[sext].compilers[n].name := s;
    cstruct[sext].compilers[n].path := '';
    cstruct[sext].compilers[n].pars := '%file';
    cstruct[sext].compilers[n].inter := '';
    cstruct[sext].compilers[n].interpars := '%file';
    cstruct[sext].compilers[n].id := '';
    renewCompUpDown();
    writeCStruct();
  end;
end;

procedure Tmain.complistClick(Sender: TObject);
var n, m: integer;
begin
  n := complist.ItemIndex;
  m := extlist.ItemIndex;
  if n > -1 then begin
    compdelb.Enabled := true;
    compeditb.Enabled := true;
    renewCompUpDown();
    compupdown.Enabled := true;

    comppath.Enabled := true;
    button5.Enabled := true;
    comppath.Text := cstruct[m].compilers[n].path;
    comppars.Enabled := true;
    comppars.Text := cstruct[m].compilers[n].pars;

    interpath.Enabled := true;
    button2.Enabled := true;
    interpath.Text := cstruct[m].compilers[n].inter;
    interpars.Enabled := true;
    interpars.Text := cstruct[m].compilers[n].interpars;

    compid.Enabled := true;
    compid.Text := cstruct[m].compilers[n].id;
  end;
end;

procedure Tmain.compdelbClick(Sender: TObject);
var i, n, m, k: integer;
begin
  n := complist.ItemIndex;
  if (n = -1) or (messagedlg('Ви впевнені, що хочете видалити компілятор «' + complist.Items[n] + '»?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes)
  then
    exit;
  k := extlist.ItemIndex;
  m := length(cstruct[k].compilers) - 1;
  for i := n + 1 to m do
    cstruct[k].compilers[i - 1] := cstruct[k].compilers[i];
  setlength(cstruct[k].compilers, m);
  extlistClick(self);
  complist.SetFocus();
  writeCStruct();
end;

procedure Tmain.complistDblClick(Sender: TObject);
var
  s: string;
  n: integer;
begin
  n := complist.ItemIndex;
  if n = -1 then
    exit;
  s := inputbox('Зміна назви компілятора', 'Уведіть нову назву компілятора:', complist.Items[n]);
  if trim(s) <> '' then begin
    complist.Items[n] := s;
    cstruct[extlist.ItemIndex].compilers[n].name := s;
    writeCStruct();
  end;
end;

procedure Tmain.compupdownClick(Sender: TObject; Button: TUDBtnType);
var
  tcomp: compiler;
  ts: string;
  n, k: integer;
begin
  n := complist.ItemIndex;
  k := extlist.ItemIndex;
  if button = btnext then begin
    if (n = -1) or (n = 0) then
      exit;

    ts := complist.Items[n];
    complist.Items[n] := complist.Items[n - 1];
    complist.Items[n - 1] := ts;

    complist.ItemIndex := n - 1;

    tcomp := cstruct[k].compilers[n];
    cstruct[k].compilers[n] := cstruct[k].compilers[n - 1];
    cstruct[k].compilers[n - 1] := tcomp;
  end else if button = btprev then begin
    if (n = -1) or (n = complist.Items.Count - 1) then
      exit;

    ts := complist.Items[n];
    complist.Items[n] := complist.Items[n + 1];
    complist.Items[n + 1] := ts;

    complist.ItemIndex := n + 1;

    tcomp := cstruct[k].compilers[n];
    cstruct[k].compilers[n] := cstruct[k].compilers[n + 1];
    cstruct[k].compilers[n + 1] := tcomp;
  end;
  writeCStruct();
end;

procedure setCompilerPath(path: string);
begin
  if correctFilePath(path) then begin
    main.comppath.text := path;
    cstruct[main.extlist.ItemIndex].compilers[main.complist.ItemIndex].path := path;
    writeCStruct();
  end else begin
    messagedlg('Файл указано некоректно.' + #10 + #13 + 'Виправте або видаліть шлях.',
      mtError, [mbOk], 0);
    main.comppath.SetFocus();
    main.comppath.SelectAll();
  end;
end;

procedure setInterpreterPath(path: string);
begin
  if correctFilePath(path) then begin
    main.interpath.text := path;
    cstruct[main.extlist.ItemIndex].compilers[main.complist.ItemIndex].inter := path;
    writeCStruct();
  end else begin
    messagedlg('Файл указано некоректно.' + #10 + #13 + 'Виправте або видаліть шлях.',
      mtError, [mbOk], 0);
    main.interpath.SetFocus();
    main.interpath.SelectAll();
  end;
end;

procedure Tmain.Button5Click(Sender: TObject);
begin
  if od1.Execute then
    setCompilerPath(od1.FileName);
end;

procedure Tmain.Button2Click(Sender: TObject);
begin
  if od1.Execute then
    setInterpreterPath(od1.FileName);
end;

procedure Tmain.comppathExit(Sender: TObject);
begin
  setCompilerPath(comppath.Text);
end;

procedure Tmain.interpathExit(Sender: TObject);
begin
  setInterpreterPath(interpath.Text);
end;

procedure Tmain.compparsChange(Sender: TObject);
begin
  if complist.ItemIndex = -1 then
    exit;
  cstruct[extlist.ItemIndex].compilers[complist.ItemIndex].pars := comppars.Text;
  writeCStruct();
end;

procedure Tmain.interparsChange(Sender: TObject);
begin
  if complist.ItemIndex = -1 then
    exit;
  cstruct[extlist.ItemIndex].compilers[complist.ItemIndex].interpars := interpars.Text;
  writeCStruct();
end;

procedure Tmain.compidChange(Sender: TObject);
begin
  if complist.ItemIndex = -1 then exit;
  cstruct[extlist.ItemIndex].compilers[complist.ItemIndex].id := trim(compid.Text);
  writeCStruct;
end;

procedure Tmain.tasklistKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var n: integer;
begin
  if (key = 46) and delb.Enabled then begin
    n := tasklist.ItemIndex;
    delbClick(self);
    if tasklist.Count > 0 then begin
      tasklist.ItemIndex := min(n, tasklist.Count - 1);
      tasklistClick(self);
    end;
  end;
end;

procedure Tmain.extlistKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var n: integer;
begin
  if (key = 46) and extdelb.Enabled then begin
    n := extlist.ItemIndex;
    extdelbClick(self);
    if extlist.Count > 0 then begin
      extlist.ItemIndex := min(n, extlist.Count - 1);
      extlistClick(self);
    end;
  end;
end;

procedure Tmain.complistKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var n: integer;
begin
  if (key = 46) and compdelb.Enabled then begin
    n := complist.ItemIndex;
    compdelbClick(self);
    if complist.Count > 0 then begin
      complist.ItemIndex := min(n, complist.Count - 1);
      complistClick(self);
    end;
  end;
end;

procedure Tmain.UpdateLinebreakPoints;
begin
  if linebreak.ItemIndex > 0 then begin
    linebreak_pts.Enabled := true;
    if linebreak_pts.Text = '' then begin
      linebreak_pts.Text := sett.ReadString('Settings', 'LineBreakPts',
        floattostr(defaultWhiteSpacePoints));
    end;
  end else begin
    linebreak_pts.Enabled := false;
    linebreak_pts.Text := '';
  end;
end;

procedure Tmain.ValidateAndStoreLinebreakPoints;
begin
  if linebreak.ItemIndex > 0 then begin
    try
      linebreak_pts.Text := floattostr(strtofloatLB(linebreak_pts.Text));
    except
      linebreak_pts.Text := floattostr(defaultWhiteSpacePoints);
    end;
    writeini('Settings', 'LineBreakPts', linebreak_pts.Text);
  end;
end;

procedure Tmain.linebreakChange(Sender: TObject);
begin
  writeini('Settings', 'LineBreak', inttostr(linebreak.ItemIndex));
  UpdateLinebreakPoints();
end;

procedure Tmain.linebreak_ptsExit(Sender: TObject);
begin
  ValidateAndStoreLinebreakPoints();
end;

procedure Tmain.Button1Click(Sender: TObject);
begin
  analysis := tanalysis.Create(self);
  analysis.Height := screen.Height - 100;
  analysis.wb.Navigate(workfolder + 'result_full.html');
  tolecontrol(analysis.wb).visible := false;
  analysis.ShowModal;
  analysis.Destroy;
end;

procedure Tmain.editbClick(Sender: TObject);
begin
  tasklistDblClick(self);
end;

procedure Tmain.exteditbClick(Sender: TObject);
begin
  extlistDblClick(self);
end;

procedure Tmain.compeditbClick(Sender: TObject);
begin
  complistDblClick(self);
end;

end.


