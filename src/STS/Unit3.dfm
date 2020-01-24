object issue_view: Tissue_view
  Left = 0
  Top = 149
  Width = 1024
  Height = 500
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1055#1077#1088#1077#1075#1083#1103#1076' '#1090#1077#1089#1090#1091
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 0
    Top = 110
    Width = 1008
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 223
    Width = 1008
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object output: TRichEdit
    Left = 0
    Top = 113
    Width = 1008
    Height = 110
    Hint = #1042#1080#1093#1110#1076#1085#1080#1081' '#1092#1072#1081#1083
    Align = alTop
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Lucida Console'
    Font.Style = []
    HideSelection = False
    Constraints.MinHeight = 50
    ParentFont = False
    ParentShowHint = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 1
  end
  object input: TRichEdit
    Left = 0
    Top = 0
    Width = 1008
    Height = 110
    Hint = #1042#1093#1110#1076#1085#1080#1081' '#1092#1072#1081#1083
    Align = alTop
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Lucida Console'
    Font.Style = []
    HideSelection = False
    Constraints.MinHeight = 50
    ParentFont = False
    ParentShowHint = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 0
  end
  object code: TSynEdit
    Left = 0
    Top = 226
    Width = 1008
    Height = 236
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 2
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -13
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.Visible = False
    Gutter.Width = 0
    Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces]
    ReadOnly = True
    RightEdge = 0
    FontSmoothing = fsmNone
  end
  object cppsyn: TSynCppSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 224
    Top = 336
  end
  object passyn: TSynPasSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 272
    Top = 336
  end
  object javasyn: TSynJavaSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 320
    Top = 336
  end
  object pysyn: TSynPythonSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 360
    Top = 336
  end
end
