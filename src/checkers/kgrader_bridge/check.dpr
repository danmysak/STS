library check;

uses windows, sysutils;

{$R *.res}

function run(const FileName: string; const Params: string): integer;
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
    { Free the Handles }
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end else
    result:=-1;
end;

function check_output(input, output, prompt: pchar; points: integer): double;
var dir: string;
f: text;
runResult: integer;
begin
  dir := extractfilepath(getmodulename(hInstance));
  if fileexists(dir + 'report') then
    repeat until deletefile(dir + 'report');
  runResult := run(dir + 'check.exe', inttostr(points) + ' ' + '"' + input + '" "' + output + '" "' + prompt + '"');
  result := 0;
  if (runResult > 0) and (fileexists(dir + 'report')) then begin
    assign(f, dir + 'report');
    reset(f);
    read(f, result);
    close(f);
    repeat until deletefile(dir + 'report');
  end;
end;

exports check_output;

begin
end.
 