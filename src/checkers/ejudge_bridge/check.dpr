library check;

uses windows, sysutils;

{$R *.res}

function run(const FileName: string; const Params: string; var exitCode: dword): integer;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
begin
  CmdLine := '"' + Filename + '" ' + Params;
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  with StartInfo do
  begin
    cb := SizeOf(StartInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := SW_HIDE;
  end;
  if   CreateProcess(nil, PChar( String( CmdLine ) ), nil, nil, false,
                          CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                          PChar(ExtractFilePath(Filename)),StartInfo,ProcInfo) then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    result:=1;
    if not GetExitCodeProcess(ProcInfo.hProcess, exitCode) then
      exitCode:=4294967295; // -1
    { Free the Handles }
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end else begin
    result:=-1;
    exitCode:=4294967295; // -1
  end;
end;

function check_output(input, output, prompt: pchar; points: integer): double;
var dir: string;
runResult: integer;
exitCode: dword;
begin
  dir := extractfilepath(getmodulename(hInstance));
  runResult := run(dir + 'check.exe', '"' + input + '" "' + output + '" "' + prompt + '"', exitCode);
  result := 0;
  if (runResult > 0) and (exitCode = 0) then
    result := points;
end;

exports check_output;

begin
end.
 