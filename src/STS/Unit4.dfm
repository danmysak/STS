object wa_view: Twa_view
  Left = 231
  Top = 182
  Width = 1024
  Height = 535
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1055#1077#1088#1077#1075#1083#1103#1076' '#1090#1077#1089#1090#1091': '#1087#1086#1088#1110#1074#1085#1103#1085#1085#1103' '#1074#1080#1093#1110#1076#1085#1080#1093' '#1092#1072#1081#1083#1110#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnResize = FormResize
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
    Top = 273
    Width = 1008
    Height = 4
    Cursor = crVSplit
    Align = alBottom
  end
  object Panel1: TPanel
    Left = 0
    Top = 277
    Width = 1008
    Height = 219
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter3: TSplitter
      Left = 588
      Top = 0
      Width = 5
      Height = 219
      OnMoved = Splitter3Moved
    end
    object output2: TRichEdit
      Left = 593
      Top = 0
      Width = 415
      Height = 219
      Hint = #1055#1088#1072#1074#1080#1083#1100#1085#1080#1081' '#1074#1080#1093#1110#1076#1085#1080#1081' '#1092#1072#1081#1083
      Align = alClient
      Ctl3D = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Lucida Console'
      Font.Style = []
      HideSelection = False
      Constraints.MinWidth = 50
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      PlainText = True
      ReadOnly = True
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 1
    end
    object output1: TRichEdit
      Left = 0
      Top = 0
      Width = 588
      Height = 219
      Hint = #1042#1080#1093#1110#1076#1085#1080#1081' '#1092#1072#1081#1083', '#1089#1090#1074#1086#1088#1077#1085#1080#1081' '#1087#1088#1086#1075#1088#1072#1084#1086#1102' '#1091#1095#1072#1089#1085#1080#1082#1072
      Align = alLeft
      Ctl3D = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Lucida Console'
      Font.Style = []
      HideSelection = False
      Constraints.MinWidth = 50
      ParentCtl3D = False
      ParentFont = False
      ParentShowHint = False
      PlainText = True
      ReadOnly = True
      ScrollBars = ssVertical
      ShowHint = True
      TabOrder = 0
    end
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
    Top = 113
    Width = 1008
    Height = 160
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 1
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
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 200
    Top = 120
  end
  object cppsyn: TSynCppSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 240
    Top = 120
  end
  object passyn: TSynPasSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 280
    Top = 120
  end
  object javasyn: TSynJavaSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 320
    Top = 120
  end
  object pysyn: TSynPythonSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 360
    Top = 120
  end
end
