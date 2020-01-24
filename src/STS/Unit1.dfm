object main: Tmain
  Left = 274
  Top = 130
  Width = 644
  Height = 740
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1057#1080#1089#1090#1077#1084#1072' '#1090#1077#1089#1090#1091#1074#1072#1085#1085#1103' '#171'STS'#187
  Color = clBtnFace
  Constraints.MaxWidth = 644
  Constraints.MinHeight = 740
  Constraints.MinWidth = 644
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    628
    701)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 607
    Height = 16
    Caption = 
      #1056#1086#1073#1086#1095#1072' '#1090#1077#1082#1072' ('#1084#1110#1089#1090#1080#1090#1100' '#1090#1077#1082#1080' '#1079' '#1088#1086#1079#1074#8217#1103#1079#1082#1072#1084#1080' '#1091#1095#1072#1089#1085#1080#1082#1110#1074' '#1090#1072' ('#1086#1087#1094#1110#1086#1085#1072#1083#1100#1085 +
      #1086') '#1092#1072#1081#1083'-'#1089#1087#1080#1089#1086#1082' '#1091#1095#1072#1089#1085#1080#1082#1110#1074'):'
  end
  object Label2: TLabel
    Left = 10
    Top = 396
    Width = 88
    Height = 16
    Caption = #1053#1072#1079#1074#1080' '#1079#1072#1076#1072#1095':'
  end
  object Label3: TLabel
    Left = 10
    Top = 89
    Width = 144
    Height = 16
    Caption = #1044#1080#1088#1077#1082#1090#1086#1088#1110#1103' '#1079' '#1090#1077#1089#1090#1072#1084#1080':'
  end
  object Gauge1: TGauge
    Left = 10
    Top = 619
    Width = 607
    Height = 21
    ForeColor = clActiveCaption
    Progress = 0
    Visible = False
  end
  object Label7: TLabel
    Left = 10
    Top = 514
    Width = 589
    Height = 16
    Caption = 
      #1053#1072#1079#1074#1080' '#1074#1093#1110#1076#1085#1080#1093' '#1092#1072#1081#1083#1110#1074' '#1090#1077#1089#1090#1110#1074' '#1074#1110#1076#1085#1086#1089#1085#1086' '#1076#1080#1088#1077#1082#1090#1086#1088#1110#1111' '#1079' '#1090#1077#1089#1090#1072#1084#1080' ('#1074#1080#1082#1086#1088 +
      #1080#1089#1090#1086#1074#1091#1081#1090#1077' %task, %num):'
  end
  object Label8: TLabel
    Left = 10
    Top = 563
    Width = 597
    Height = 16
    Caption = 
      #1053#1072#1079#1074#1080' '#1074#1080#1093#1110#1076#1085#1080#1093' '#1092#1072#1081#1083#1110#1074' '#1090#1077#1089#1090#1110#1074' '#1074#1110#1076#1085#1086#1089#1085#1086' '#1076#1080#1088#1077#1082#1090#1086#1088#1110#1111' '#1079' '#1090#1077#1089#1090#1072#1084#1080' ('#1074#1080#1082#1086 +
      #1088#1080#1089#1090#1086#1074#1091#1081#1090#1077' %task, %num):'
  end
  object Label9: TLabel
    Left = 226
    Top = 440
    Width = 298
    Height = 32
    Caption = 
      #1053#1072#1079#1074#1080' '#1086#1087#1080#1089#1086#1074#1080#1093' '#1092#1072#1081#1083#1110#1074' '#1090#1077#1089#1090#1110#1074' '#1074#1110#1076#1085#1086#1089#1085#1086' '#1076#1080#1088#1077#1082#1090#1086#1088#1110#1111' '#1079#160#1090#1077#1089#1090#1072#1084#1080' ('#1074#1080#1082#1086 +
      #1088#1080#1089#1090#1086#1074#1091#1081#1090#1077' %task):'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 10
    Top = 144
    Width = 84
    Height = 16
    Caption = #1056#1086#1079#1096#1080#1088#1077#1085#1085#1103':'
  end
  object Label5: TLabel
    Left = 118
    Top = 144
    Width = 85
    Height = 16
    Caption = #1050#1086#1084#1087#1110#1083#1103#1090#1086#1088#1080':'
  end
  object Label6: TLabel
    Left = 226
    Top = 144
    Width = 191
    Height = 16
    Caption = #1064#1083#1103#1093' '#1076#1086' '#1082#1086#1084#1087#1110#1083#1103#1090#1086#1088#1072' ('#1103#1082#1097#1086' '#1108'):'
  end
  object Label10: TLabel
    Left = 226
    Top = 193
    Width = 335
    Height = 16
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1080' '#1082#1086#1084#1087#1110#1083#1103#1094#1110#1111' ('#1074#1080#1082#1086#1088#1080#1089#1090#1086#1074#1091#1081#1090#1077' %file, %exe):'
  end
  object Label11: TLabel
    Left = 226
    Top = 340
    Width = 278
    Height = 16
    Caption = #1050#1086#1084#1077#1085#1090#1072#1088'-'#1110#1076#1077#1085#1090#1080#1092#1110#1082#1072#1090#1086#1088' '#1091' '#1087#1077#1088#1096#1086#1084#1091' '#1088#1103#1076#1082#1091':'
  end
  object Label12: TLabel
    Left = 226
    Top = 242
    Width = 214
    Height = 16
    Caption = #1064#1083#1103#1093' '#1076#1086' '#1110#1085#1090#1077#1088#1087#1088#1077#1090#1072#1090#1086#1088#1072' ('#1103#1082#1097#1086' '#1108'):'
  end
  object Label13: TLabel
    Left = 226
    Top = 291
    Width = 361
    Height = 16
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1080' '#1110#1085#1090#1077#1088#1087#1088#1077#1090#1072#1094#1110#1111' ('#1074#1080#1082#1086#1088#1080#1089#1090#1086#1074#1091#1081#1090#1077' %file, %task):'
  end
  object Label14: TLabel
    Left = 545
    Top = 407
    Width = 33
    Height = 16
    Caption = #1073#1072#1083' '#1093
  end
  object dxButton1: TButton
    Left = 529
    Top = 29
    Width = 87
    Height = 25
    Caption = #1042#1080#1073#1088#1072#1090#1080'...'
    TabOrder = 1
    OnClick = dxButton1Click
  end
  object workfname: TEdit
    Left = 10
    Top = 30
    Width = 511
    Height = 24
    TabOrder = 0
    OnExit = workfnameExit
  end
  object tasklist: TListBox
    Left = 10
    Top = 416
    Width = 168
    Height = 87
    ItemHeight = 16
    TabOrder = 23
    OnClick = tasklistClick
    OnDblClick = tasklistDblClick
    OnKeyDown = tasklistKeyDown
  end
  object addb: TButton
    Left = 182
    Top = 416
    Width = 26
    Height = 27
    Hint = #1044#1086#1076#1072#1090#1080' '#1079#1072#1076#1072#1095#1091
    Caption = '+'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 24
    OnClick = addbClick
  end
  object delb: TButton
    Left = 182
    Top = 446
    Width = 26
    Height = 27
    Hint = #1042#1080#1076#1072#1083#1080#1090#1080' '#1074#1080#1076#1110#1083#1077#1085#1091' '#1079#1072#1076#1072#1095#1091
    Caption = #8212
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 25
    OnClick = delbClick
  end
  object dxButton2: TButton
    Left = 529
    Top = 107
    Width = 87
    Height = 26
    Caption = #1042#1080#1073#1088#1072#1090#1080'...'
    TabOrder = 5
    OnClick = dxButton2Click
  end
  object testpath: TEdit
    Left = 10
    Top = 108
    Width = 511
    Height = 24
    TabOrder = 4
    OnExit = testpathExit
  end
  object dxButton4: TButton
    Left = 477
    Top = 614
    Width = 139
    Height = 30
    Caption = #1055#1088#1086' '#1087#1088#1086#1075#1088#1072#1084#1091'...'
    TabOrder = 36
    OnClick = dxButton4Click
  end
  object dxButton5: TButton
    Left = 10
    Top = 614
    Width = 168
    Height = 30
    Caption = #1055#1086#1095#1072#1090#1080' '#1090#1077#1089#1090#1091#1074#1072#1085#1085#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 34
    OnClick = dxButton5Click
  end
  object res: TMemo
    Left = 10
    Top = 652
    Width = 607
    Height = 40
    Anchors = [akLeft, akTop, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 37
  end
  object dxButton6: TButton
    Left = 10
    Top = 59
    Width = 218
    Height = 26
    Caption = #1057#1090#1074#1086#1088#1080#1090#1080' '#1089#1087#1080#1089#1086#1082' '#1091#1095#1072#1089#1085#1080#1082#1110#1074
    TabOrder = 2
    OnClick = dxButton6Click
  end
  object intestname: TEdit
    Left = 10
    Top = 533
    Width = 365
    Height = 24
    ParentShowHint = False
    ShowHint = False
    TabOrder = 30
    OnChange = intestnameChange
  end
  object outtestname: TEdit
    Left = 10
    Top = 582
    Width = 365
    Height = 24
    TabOrder = 32
    OnChange = outtestnameChange
  end
  object testname: TEdit
    Left = 226
    Top = 479
    Width = 391
    Height = 24
    TabOrder = 29
    OnChange = testnameChange
  end
  object dxButton9: TButton
    Left = 236
    Top = 59
    Width = 218
    Height = 26
    Caption = #1055#1077#1088#1077#1075#1083#1103#1085#1091#1090#1080' '#1089#1087#1080#1089#1086#1082' '#1091#1095#1072#1089#1085#1080#1082#1110#1074
    TabOrder = 3
    OnClick = dxButton9Click
  end
  object infname: TEdit
    Left = 384
    Top = 533
    Width = 233
    Height = 24
    TabOrder = 31
    OnChange = infnameChange
  end
  object outfname: TEdit
    Left = 384
    Top = 582
    Width = 233
    Height = 24
    TabOrder = 33
    OnChange = outfnameChange
  end
  object extlist: TListBox
    Left = 10
    Top = 164
    Width = 60
    Height = 220
    ItemHeight = 16
    TabOrder = 6
    OnClick = extlistClick
    OnDblClick = extlistDblClick
    OnKeyDown = extlistKeyDown
  end
  object extaddb: TButton
    Left = 74
    Top = 164
    Width = 26
    Height = 27
    Hint = #1044#1086#1076#1072#1090#1080' '#1088#1086#1079#1096#1080#1088#1077#1085#1085#1103
    Caption = '+'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = extaddbClick
  end
  object extdelb: TButton
    Left = 74
    Top = 193
    Width = 26
    Height = 27
    Hint = #1042#1080#1076#1072#1083#1080#1090#1080' '#1074#1080#1076#1110#1083#1077#1085#1077' '#1088#1086#1079#1096#1080#1088#1077#1085#1085#1103
    Caption = #8212
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = extdelbClick
  end
  object complist: TListBox
    Left = 118
    Top = 164
    Width = 60
    Height = 220
    ItemHeight = 16
    TabOrder = 11
    OnClick = complistClick
    OnDblClick = complistDblClick
    OnKeyDown = complistKeyDown
  end
  object compaddb: TButton
    Left = 182
    Top = 164
    Width = 26
    Height = 27
    Hint = #1044#1086#1076#1072#1090#1080' '#1082#1086#1084#1087#1110#1083#1103#1090#1086#1088
    Caption = '+'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = compaddbClick
  end
  object compdelb: TButton
    Left = 182
    Top = 193
    Width = 26
    Height = 27
    Hint = #1042#1080#1076#1072#1083#1080#1090#1080' '#1074#1080#1076#1110#1083#1077#1085#1080#1081' '#1082#1086#1084#1087#1110#1083#1103#1090#1086#1088
    Caption = #8212
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnClick = compdelbClick
  end
  object compupdown: TUpDown
    Left = 182
    Top = 334
    Width = 26
    Height = 50
    Hint = #1047#1084#1110#1085#1080#1090#1080' '#1087#1086#1079#1080#1094#1110#1102
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    TabStop = True
    OnClick = compupdownClick
  end
  object Button5: TButton
    Left = 529
    Top = 163
    Width = 87
    Height = 26
    Caption = #1042#1080#1073#1088#1072#1090#1080'...'
    TabOrder = 17
    OnClick = Button5Click
  end
  object comppath: TEdit
    Left = 226
    Top = 164
    Width = 295
    Height = 24
    TabOrder = 16
    OnExit = comppathExit
  end
  object comppars: TEdit
    Left = 226
    Top = 213
    Width = 391
    Height = 24
    TabOrder = 18
    OnChange = compparsChange
  end
  object compid: TEdit
    Left = 226
    Top = 360
    Width = 391
    Height = 24
    TabOrder = 22
    OnChange = compidChange
  end
  object extupdown: TUpDown
    Left = 74
    Top = 334
    Width = 26
    Height = 50
    Hint = #1047#1084#1110#1085#1080#1090#1080' '#1087#1086#1079#1080#1094#1110#1102
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    TabStop = True
    OnClick = extupdownClick
  end
  object linebreak_pts: TEdit
    Left = 584
    Top = 403
    Width = 33
    Height = 24
    TabOrder = 28
    OnExit = linebreak_ptsExit
  end
  object Button1: TButton
    Left = 299
    Top = 614
    Width = 169
    Height = 30
    Caption = #1040#1085#1072#1083#1110#1079'...'
    TabOrder = 35
    Visible = False
    OnClick = Button1Click
  end
  object largewin: TCheckBox
    Left = 184
    Top = 621
    Width = 110
    Height = 17
    Caption = #1042#1077#1083#1080#1082#1077' '#1074#1110#1082#1085#1086
    TabOrder = 38
  end
  object Button2: TButton
    Left = 529
    Top = 261
    Width = 87
    Height = 26
    Caption = #1042#1080#1073#1088#1072#1090#1080'...'
    TabOrder = 20
    OnClick = Button2Click
  end
  object interpath: TEdit
    Left = 226
    Top = 262
    Width = 295
    Height = 24
    TabOrder = 19
    OnExit = interpathExit
  end
  object interpars: TEdit
    Left = 226
    Top = 311
    Width = 391
    Height = 24
    TabOrder = 21
    OnChange = interparsChange
  end
  object editb: TButton
    Left = 182
    Top = 476
    Width = 26
    Height = 27
    Hint = #1056#1077#1076#1072#1075#1091#1074#1072#1090#1080' '#1085#1072#1079#1074#1091' '#1074#1080#1076#1110#1083#1077#1085#1086#1111' '#1079#1072#1076#1072#1095#1110
    Caption = #1056
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 26
    OnClick = editbClick
  end
  object exteditb: TButton
    Left = 74
    Top = 222
    Width = 26
    Height = 27
    Hint = #1056#1077#1076#1072#1075#1091#1074#1072#1090#1080' '#1085#1072#1079#1074#1091' '#1074#1080#1076#1110#1083#1077#1085#1086#1075#1086' '#1088#1086#1079#1096#1080#1088#1077#1085#1085#1103
    Caption = #1056
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = exteditbClick
  end
  object compeditb: TButton
    Left = 182
    Top = 222
    Width = 26
    Height = 27
    Hint = #1056#1077#1076#1072#1075#1091#1074#1072#1090#1080' '#1085#1072#1079#1074#1091' '#1074#1080#1076#1110#1083#1077#1085#1086#1075#1086' '#1082#1086#1084#1087#1110#1083#1103#1090#1086#1088#1072
    Caption = #1056
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    OnClick = compeditbClick
  end
  object linebreak: TComboBox
    Left = 226
    Top = 403
    Width = 311
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 27
    Text = #1055#1088#1080#1081#1084#1072#1090#1080' '#1083#1080#1096#1077' '#1110#1076#1077#1085#1090#1080#1095#1085#1080#1081' '#1074#1080#1093#1110#1076#1085#1080#1081' '#1092#1072#1081#1083
    OnChange = linebreakChange
    Items.Strings = (
      #1055#1088#1080#1081#1084#1072#1090#1080' '#1083#1080#1096#1077' '#1110#1076#1077#1085#1090#1080#1095#1085#1080#1081' '#1074#1080#1093#1110#1076#1085#1080#1081' '#1092#1072#1081#1083
      #1055#1088#1080#1081#1084#1072#1090#1080' '#1092#1072#1081#1083' '#1073#1077#1079' '#1086#1079#1085#1072#1082#1080' '#1082#1110#1085#1094#1103' '#1088#1103#1076#1082#1072
      #1055#1088#1080#1081#1084#1072#1090#1080' '#1092#1072#1081#1083' '#1110#1079' '#1079#1072#1081#1074#1080#1084#1080' '#1087#1088#1086#1073#1110#1083#1072#1084#1080
      #1055#1088#1080#1081#1084#1072#1090#1080' '#1079' '#1110#1075#1085#1086#1088#1091#1074#1072#1085#1085#1103#1084' '#1087#1088#1086#1073#1110#1083#1110#1074' '#1110' '#1088#1103#1076#1082#1110#1074)
  end
  object od1: TOpenDialog
    Filter = #1042#1080#1082#1086#1085#1091#1074#1072#1085#1110' '#1092#1072#1081#1083#1080' (*.exe)|*.exe'
    Title = #1042#1080#1073#1110#1088' '#1082#1086#1084#1087#1110#1083#1103#1090#1086#1088#1072
    Left = 456
    Top = 56
  end
  object XPManifest1: TXPManifest
    Left = 424
    Top = 64
  end
  object VistaAltFix1: TVistaAltFix
    Left = 264
    Top = 136
  end
end
