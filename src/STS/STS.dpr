program STS;

uses
  Forms,
  Unit1 in 'Unit1.pas' {main},
  Unit2 in 'Unit2.pas' {analysis},
  Unit3 in 'Unit3.pas' {issue_view},
  Unit4 in 'Unit4.pas' {wa_view},
  Unit5 in 'Unit5.pas' {online};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Система тестування «STS»';
  Application.CreateForm(Tmain, main);
  Application.Run;
end.
