unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, activex, MSHTML, shellapi;

type

   TObjectProcedure = procedure of object;

   TEventObject = class(TInterfacedObject, IDispatch)
   private
     FOnEvent: TObjectProcedure;
   protected
     function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
     function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
     function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
     function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
   public
     constructor Create(const OnEvent: TObjectProcedure) ;
     property OnEvent: TObjectProcedure read FOnEvent write FOnEvent;
   end;

  Tanalysis = class(TForm)
    wb: TWebBrowser;
    procedure wbDocumentComplete(Sender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure wbNavigateComplete2(Sender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure wbSetFocus;      

      private
      procedure Document_OnClick;
      public

      end;

var
  analysis: Tanalysis;
  htmlDoc : IHTMLDocument2;

implementation

uses Unit1, Unit3, Unit4;

{$R *.dfm}

constructor TEventObject.Create(const OnEvent: TObjectProcedure);
begin
  inherited Create;
  FOnEvent := OnEvent;
end;

function TEventObject.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TEventObject.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TEventObject.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount,
  LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TEventObject.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  if DispID = DISPID_VALUE then begin
    if Assigned(FOnEvent) then FOnEvent;
    Result := S_OK;
  end else
    Result := E_NOTIMPL;
end;

function parseHrefPart(href, param: string; defaultValue: string = ''): string;
var p: integer;
begin
  result := defaultValue;
  p := pos(param, href);
  if p > 0 then begin
    result := '';
    p := p + length(param);
    while (p <= length(href)) and (href[p] <> ';') do begin
      result := result + href[p];
      inc(p);
    end;
  end;
end;

procedure parseHref(href: string; var mode: string; var task: string;
  var test: string; var res: string; var time: string; var memory: string;
  var files: tstringlist; var name: string; var pos1, pos2: integer);
begin
  mode := parseHrefPart(href, '#mode=');
  task := uppercase(parseHrefPart(href, ';task='));
  test := parseHrefPart(href, ';test=');
  res := parseHrefPart(href, ';result=');
  time := parseHrefPart(href, ';time=');
  memory := parseHrefPart(href, ';memory=');
  files.Text := main.replacesub(parseHrefPart(href, ';files='), ',', #10, '');
  name := parseHrefPart(href, ';name=');
  try
    pos1 := strtoint(parseHrefPart(href, ';pos1=', '-1'));
    pos2 := strtoint(parseHrefPart(href, ';pos2=', '-1'));
  except
    pos1 := -1;
    pos2 := -1;
  end;
end;

procedure TAnalysis.Document_OnClick;
var
  element: IHTMLElement;
  mode, task, test, res, time, memory, name, synext: string;
  pos1, pos2: integer;
  files: tstringlist;
begin
  if htmlDoc = nil then exit;
  element := htmlDoc.parentWindow.event.srcElement;
  if LowerCase(element.tagName) = 'a' then begin
    htmlDoc.parentWindow.event.returnValue := false;
    files := tstringlist.Create;
    parseHref(element.getAttribute('href', 0), mode, task, test, res, time,
      memory, files, name, pos1, pos2);
    if mode = 'contestant' then begin
      ShellExecute(Handle, 'explore', pchar(files.strings[0]), nil, nil, SW_SHOW);
    end else if mode='task' then begin
      issue_view := tissue_view.Create(self);
      issue_view.input.Visible := false;
      issue_view.output.Visible := false;
      issue_view.Splitter1.Visible := false;
      issue_view.Splitter2.Visible := false;
      if res = 'COK' then
        res := 'скомпільовано'
      else if res = 'CER' then
        res := 'помилка компіляції'
      else if res = 'CTL' then
        res := 'час компіляції вичерпано';
      issue_view.Caption := 'Перегляд тексту програми: ' + res +
        ', задача ' + task + ', ' + name;
      issue_view.code.lines.loadfromfile(files.Strings[0]);
      synext := lowercase(extractfileext(files.Strings[0]));
      if synext = '.cpp' then
        issue_view.code.Highlighter := issue_view.cppsyn
      else if synext = '.java' then
        issue_view.code.Highlighter := issue_view.javasyn
      else if synext = '.py' then
        issue_view.code.Highlighter := issue_view.pysyn
      else
        issue_view.code.Highlighter := issue_view.passyn;
      issue_view.Height := screen.Height - 100;
      issue_view.ShowModal;
      issue_view.Destroy;
      wbSetFocus();
    end else if mode = 'wa' then begin
      wa_view := twa_view.Create(self);
      wa_view.SetDifferPositions(pos1, pos2);
      wa_view.input.lines.loadfromfile(files.Strings[0]);
      wa_view.code.lines.loadfromfile(files.Strings[1]);
      synext := lowercase(extractfileext(files.Strings[1]));
      if synext = '.cpp' then
        wa_view.code.Highlighter := wa_view.cppsyn
      else if synext = '.java' then
        wa_view.code.Highlighter := wa_view.javasyn
      else if synext = '.py' then
        wa_view.code.Highlighter := wa_view.pysyn
      else
        wa_view.code.Highlighter := wa_view.passyn;
      wa_view.output1.lines.loadfromfile(files.Strings[2]);
      wa_view.output2.lines.loadfromfile(files.Strings[3]);
      wa_view.Height := screen.Height - 100;
      wa_view.Caption := wa_view.Caption + ': ' + res + ', ' + time + ' мс, ' +
        unit1.formatBytes(strtoint64(memory)) + ', тест ' + test + ', задача ' + task + ', ' + name;
      wa_view.ShowModal;
      wa_view.Destroy;
      wbSetFocus();
    end else begin
      issue_view := tissue_view.Create(self);
      issue_view.input.lines.loadfromfile(files.Strings[0]);
      issue_view.output.lines.loadfromfile(files.Strings[1]);
      issue_view.code.lines.loadfromfile(files.Strings[2]);
      synext := lowercase(extractfileext(files.Strings[2]));
      if synext = '.cpp' then
        issue_view.code.Highlighter := issue_view.cppsyn
      else if synext = '.java' then
        issue_view.code.Highlighter := issue_view.javasyn
      else if synext = '.py' then
        issue_view.code.Highlighter := issue_view.pysyn
      else
        issue_view.code.Highlighter := issue_view.passyn;
      issue_view.Height := screen.Height - 100;
      issue_view.Caption := issue_view.Caption + ': ' + res + ', ' + time + ' мс, ' +
        unit1.formatBytes(strtoint64(memory)) + ', тест ' + test + ', задача ' + task + ', ' + name;
      issue_view.ShowModal;
      issue_view.Destroy;
      wbSetFocus();
    end;
    files.Destroy;
  end;
end;

procedure Tanalysis.wbDocumentComplete(Sender: TObject;
const pDisp: IDispatch; var URL: OleVariant);
begin
  if Assigned(wb.Document) then begin
    htmlDoc := wb.Document as IHTMLDocument2;
    htmlDoc.onclick := TEventObject.Create(Document_OnClick) as IDispatch;
  end;
end;

procedure Tanalysis.wbSetFocus;
begin
  if wb.Document <> nil then
    IHTMLWindow2(IHTMLDocument2(wb.Document).ParentWindow).focus;
end;

procedure Tanalysis.wbNavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  tolecontrol(analysis.wb).visible := true;
  wbSetFocus;
end;

end.
