unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, math, ComCtrls, SynHighlighterPas,
  SynEditHighlighter, SynHighlighterCpp, SynEdit, SynHighlighterPython,
  SynHighlighterJava;

type
  Twa_view = class(TForm)
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel1: TPanel;
    Splitter3: TSplitter;
    Timer1: TTimer;
    output2: TRichEdit;
    output1: TRichEdit;
    input: TRichEdit;
    code: TSynEdit;
    cppsyn: TSynCppSyn;
    passyn: TSynPasSyn;
    javasyn: TSynJavaSyn;
    pysyn: TSynPythonSyn;
    procedure compareOutputs;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Splitter3Moved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SetDifferPositions(pos1, pos2: integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wa_view: Twa_view;
  out_ratio: double;
  dpos1, dpos2: integer;

implementation

{$R *.dfm}

procedure selectChar(m: trichedit; n: integer);
begin
  m.SelStart := n - 1;
  m.SelLength := 1;
  SendMessage(m.handle, EM_SCROLLCARET, 0, 0);
end;

procedure Twa_view.SetDifferPositions(pos1, pos2: integer);
begin
  dpos1 := pos1;
  dpos2 := pos2;
end;

procedure Twa_view.compareOutputs;
var
  i, l1, l2, l: integer;
  b: boolean;
begin
  if (dpos1 < 0) and (dpos2 < 0) then begin
    b := false;
    l1 := length(output1.Text);
    l2 := length(output2.Text);
    l := min(l1, l2);
    for i := 1 to l do begin
      if output1.Text[i] <> output2.Text[i] then begin
        selectchar(output1, i);
        selectchar(output2, i);
        b := true;
        break;
      end;
    end;
    if not b then begin
      selectchar(output1, l + 1);
      selectchar(output2, l + 1);
    end;
  end else begin
    selectchar(output1, dpos1 + 1);
    selectchar(output2, dpos2 + 1);
  end;
end;

procedure Twa_view.Timer1Timer(Sender: TObject);
begin
  timer1.Interval := 0;
  wa_view.compareOutputs;
end;

procedure Twa_view.FormCreate(Sender: TObject);
begin
  out_ratio := 1;
end;

procedure Twa_view.Splitter3Moved(Sender: TObject);
begin
  if (output1.Width > 0) and (output2.Width > 0) then
    out_ratio := output1.Width / output2.Width
  else
    out_ratio := 1;
end;

procedure Twa_view.FormResize(Sender: TObject);
begin
  output1.Width := round((output1.Width + output2.Width) * out_ratio / (out_ratio + 1));
end;

end.
