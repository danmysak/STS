unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, SynHighlighterPas,
  SynEditHighlighter, SynHighlighterCpp, SynEdit, SynHighlighterPython,
  SynHighlighterJava;

type
  Tissue_view = class(TForm)
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    output: TRichEdit;
    input: TRichEdit;
    code: TSynEdit;
    cppsyn: TSynCppSyn;
    passyn: TSynPasSyn;
    javasyn: TSynJavaSyn;
    pysyn: TSynPythonSyn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  issue_view: Tissue_view;

implementation

{$R *.dfm}

end.
