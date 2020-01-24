library check;

{$R *.res}

uses classes, sysutils;

function check_output(input, output, prompt: pchar; points: integer): double;
var
  f: text;
  a, b, ans: integer;
begin
  assignfile(f, input);
  reset(f);
  read(f, a, b);
  closefile(f);

  assignfile(f, output);
  reset(f);
  read(f, ans);
  closefile(f);

  if ans = a then
    result := points
  else if ans = b then
    result := points div 2
  else
    result := 0;
end;

exports check_output;

begin
end.
 