inherited frmMain: TfrmMain
  Left = 228
  Top = 161
  BorderStyle = bsSingle
  Caption = #1063#1090#1077#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1089#1091#1084#1084#1072#1090#1086#1088#1072' '#1057#1069#1052'-3'
  ClientHeight = 680
  ClientWidth = 1198
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 1204
  ExplicitHeight = 711
  PixelsPerInch = 120
  TextHeight = 19
  object stbMain: TStatusBar
    Left = 0
    Top = 662
    Width = 1198
    Height = 18
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Panels = <
      item
        Width = 140
      end
      item
        Width = 140
      end
      item
        Width = 140
      end
      item
        Width = 140
      end
      item
        Width = 140
      end
      item
        Width = 300
      end>
    SizeGrip = False
    OnDrawPanel = stbMainDrawPanel
  end
  object panClient: TPanel
    Left = 0
    Top = 0
    Width = 1198
    Height = 662
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pgcMain: TPageControl
      Left = 0
      Top = 0
      Width = 1198
      Height = 662
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ActivePage = tbsParams
      Align = alClient
      TabOrder = 0
      object tbsFirst: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1077
        PopupMenu = ppmMain
        object lblDevice: TLabel
          Left = 23
          Top = 10
          Width = 164
          Height = 19
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1091#1084#1084#1072#1090#1086#1088#1072
        end
        object lblAddress: TLabel
          Left = 23
          Top = 40
          Width = 44
          Height = 19
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = #1040#1076#1088#1077#1089
        end
        object lblColWidth: TLabel
          Left = 236
          Top = 78
          Width = 190
          Height = 19
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = #1064#1080#1088#1080#1085#1072' '#1089#1090#1086#1083#1073#1094#1072' '#1090#1072#1073#1083#1080#1094#1099
        end
        object lblDigits: TLabel
          Left = 236
          Top = 40
          Width = 250
          Height = 19
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1085#1072#1082#1086#1074' '#1087#1086#1089#1083#1077' '#1079#1072#1087#1103#1090#1086#1081
        end
        object lblSetting: TLabel
          Left = 236
          Top = 10
          Width = 137
          Height = 19
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
        end
        object lblDevicePass: TLabel
          Left = 23
          Top = 78
          Width = 54
          Height = 19
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = #1055#1072#1088#1086#1083#1100
        end
        object edtAddress: TEdit
          Left = 89
          Top = 36
          Width = 64
          Height = 27
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 0
          Text = '0'
        end
        object updAddress: TUpDown
          Left = 153
          Top = 36
          Width = 22
          Height = 27
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Associate = edtAddress
          Max = 255
          TabOrder = 1
          Thousands = False
        end
        object edtColWidth: TEdit
          Left = 498
          Top = 74
          Width = 34
          Height = 27
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 2
          Text = '10'
        end
        object updColWidth: TUpDown
          Left = 532
          Top = 74
          Width = 21
          Height = 27
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Associate = edtColWidth
          Min = 1
          Position = 10
          TabOrder = 3
          Thousands = False
        end
        object edtDigits: TEdit
          Left = 498
          Top = 36
          Width = 34
          Height = 27
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 4
          Text = '4'
        end
        object updDigits: TUpDown
          Left = 532
          Top = 36
          Width = 21
          Height = 27
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Associate = edtDigits
          Max = 10
          Position = 4
          TabOrder = 5
          Thousands = False
        end
        object medDevicePass: TMaskEdit
          Left = 89
          Top = 74
          Width = 124
          Height = 27
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 6
        end
        object panTAPI: TPanel
          Left = 0
          Top = 286
          Width = 1190
          Height = 342
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 7
          object memDial: TMemo
            Left = 0
            Top = 194
            Width = 1190
            Height = 148
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alBottom
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -20
            Font.Name = 'Lucida Console'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 0
          end
          object pgcMode: TPageControl
            Left = 0
            Top = 0
            Width = 1190
            Height = 194
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            ActivePage = tbsModem
            Align = alClient
            TabOrder = 1
            OnChange = pgcModeChange
            object tbsPort: TTabSheet
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1055#1086#1088#1090
              object lblComNumber: TLabel
                Left = 19
                Top = 17
                Width = 37
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1055#1086#1088#1090
              end
              object lblBaud: TLabel
                Left = 19
                Top = 55
                Width = 68
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1057#1082#1086#1088#1086#1089#1090#1100
              end
              object lblParity: TLabel
                Left = 19
                Top = 93
                Width = 67
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1063#1105#1090#1085#1086#1089#1090#1100
              end
              object lblTimeoutPort: TLabel
                Left = 19
                Top = 131
                Width = 88
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1058#1072#1081#1084#1072#1091#1090', '#1084#1089
                ParentShowHint = False
                ShowHint = True
              end
              object cmbComNumber: TComboBox
                Left = 119
                Top = 13
                Width = 85
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Style = csDropDownList
                DropDownCount = 16
                TabOrder = 0
                OnChange = cmbComNumberChange
                Items.Strings = (
                  'COM1'
                  'COM2'
                  'COM3'
                  'COM4'
                  'COM5'
                  'COM6'
                  'COM7'
                  'COM8'
                  'COM9'
                  'COM10'
                  'COM11'
                  'COM12'
                  'COM13'
                  'COM14'
                  'COM15'
                  'COM16')
              end
              object cmbBaud: TComboBox
                Left = 119
                Top = 51
                Width = 85
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Style = csDropDownList
                DropDownCount = 16
                TabOrder = 1
                OnChange = cmbBaudChange
                Items.Strings = (
                  '300'
                  '600'
                  '1200'
                  '2400'
                  '4800'
                  '9600'
                  '19200')
              end
              object cmbParity: TComboBox
                Left = 119
                Top = 89
                Width = 85
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Style = csDropDownList
                TabOrder = 2
                OnChange = cmbParityChange
                Items.Strings = (
                  'none'
                  'even'
                  'odd'
                  'mark'
                  'space')
              end
              object edtTimeoutPort: TEdit
                Left = 119
                Top = 127
                Width = 64
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                ParentShowHint = False
                ShowHint = True
                TabOrder = 3
                Text = '500'
              end
              object updTimeoutPort: TUpDown
                Left = 183
                Top = 127
                Width = 21
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtTimeoutPort
                Min = 50
                Max = 30000
                Increment = 50
                ParentShowHint = False
                Position = 500
                ShowHint = True
                TabOrder = 4
                Thousands = False
              end
            end
            object tbsModem: TTabSheet
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1052#1086#1076#1077#1084
              ImageIndex = 1
              object lblSelectedDevice: TLabel
                Left = 342
                Top = 24
                Width = 121
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = 'lblSelectedDevice'
              end
              object lblTimeoutModem: TLabel
                Left = 19
                Top = 119
                Width = 88
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1058#1072#1081#1084#1072#1091#1090', '#1084#1089
                ParentShowHint = False
                ShowHint = True
              end
              object btbSelectDevice: TBitBtn
                Left = 19
                Top = 19
                Width = 133
                Height = 29
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1052#1086#1076#1077#1084
                Margin = 20
                TabOrder = 0
                OnClick = btbSelectDeviceClick
              end
              object btbShowConfigDialog: TBitBtn
                Left = 181
                Top = 19
                Width = 133
                Height = 29
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
                Margin = 20
                NumGlyphs = 2
                TabOrder = 1
                OnClick = btbShowConfigDialogClick
              end
              object btbDial: TBitBtn
                Left = 19
                Top = 67
                Width = 133
                Height = 28
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1042#1099#1079#1086#1074
                Margin = 20
                NumGlyphs = 2
                TabOrder = 2
                OnClick = btbDialClick
              end
              object btbCancelCall: TBitBtn
                Left = 342
                Top = 67
                Width = 133
                Height = 28
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1054#1090#1084#1077#1085#1072
                Margin = 20
                TabOrder = 4
                OnClick = btbCancelCallClick
              end
              object edtDial: TEdit
                Left = 181
                Top = 67
                Width = 133
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 3
              end
              object edtTimeoutModem: TEdit
                Left = 119
                Top = 114
                Width = 73
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                ParentShowHint = False
                ShowHint = True
                TabOrder = 5
                Text = '500'
              end
              object updTimeoutModem: TUpDown
                Left = 192
                Top = 114
                Width = 21
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtTimeoutModem
                Min = 50
                Max = 30000
                Increment = 50
                ParentShowHint = False
                Position = 500
                ShowHint = True
                TabOrder = 6
                Thousands = False
              end
            end
            object tbsSocket: TTabSheet
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1057#1086#1082#1077#1090
              ImageIndex = 2
              object lblTimeoutSocket: TLabel
                Left = 19
                Top = 119
                Width = 88
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1058#1072#1081#1084#1072#1091#1090', '#1084#1089
                ParentShowHint = False
                ShowHint = True
              end
              object lblSocketHost: TLabel
                Left = 181
                Top = 24
                Width = 33
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1061#1086#1089#1090
              end
              object lblSocketPort: TLabel
                Left = 181
                Top = 71
                Width = 37
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1055#1086#1088#1090
              end
              object btbSocketOpen: TBitBtn
                Left = 19
                Top = 19
                Width = 133
                Height = 29
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1042#1099#1079#1086#1074
                Margin = 20
                NumGlyphs = 2
                TabOrder = 0
                OnClick = btbSocketOpenClick
              end
              object edtSocketHost: TEdit
                Left = 238
                Top = 19
                Width = 133
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 1
              end
              object btbSocketClose: TBitBtn
                Left = 19
                Top = 67
                Width = 133
                Height = 28
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1054#1090#1084#1077#1085#1072
                Margin = 20
                TabOrder = 2
                OnClick = btbSocketCloseClick
              end
              object edtSocketPort: TEdit
                Left = 238
                Top = 67
                Width = 133
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 3
              end
              object edtTimeoutSocket: TEdit
                Left = 119
                Top = 114
                Width = 73
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                ParentShowHint = False
                ShowHint = True
                TabOrder = 4
                Text = '500'
              end
              object updTimeoutSocket: TUpDown
                Left = 192
                Top = 114
                Width = 21
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtTimeoutSocket
                Min = 50
                Max = 30000
                Increment = 50
                ParentShowHint = False
                Position = 500
                ShowHint = True
                TabOrder = 5
                Thousands = False
              end
            end
          end
        end
      end
      object tbsParams: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        ImageIndex = 3
        object splMain: TSplitter
          Left = 345
          Top = 0
          Width = 9
          Height = 580
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          AutoSnap = False
          MinSize = 120
          ExplicitLeft = 305
          ExplicitHeight = 571
        end
        object panBottom2: TPanel
          Left = 0
          Top = 580
          Width = 1190
          Height = 48
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object panRigth2: TPanel
            Left = 780
            Top = 0
            Width = 410
            Height = 48
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
            object btbCrealInfo: TBitBtn
              Left = 147
              Top = 10
              Width = 119
              Height = 29
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1054#1095#1080#1089#1090#1080#1090#1100
              Margin = 12
              TabOrder = 1
              OnClick = btbCrealInfoClick
            end
            object btbSaveInfo: TBitBtn
              Left = 14
              Top = 10
              Width = 119
              Height = 29
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1042' '#1092#1072#1081#1083'  '
              Margin = 12
              NumGlyphs = 2
              TabOrder = 0
              OnClick = btbSaveInfoClick
            end
            object btbStopInfo: TBitBtn
              Left = 280
              Top = 10
              Width = 119
              Height = 29
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1057#1090#1086#1087' !'
              Margin = 8
              TabOrder = 2
              OnClick = btbStopInfoClick
            end
          end
        end
        object panClient2: TPanel
          Left = 354
          Top = 0
          Width = 836
          Height = 580
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          ExplicitLeft = 314
          ExplicitWidth = 876
          object memInfo: TMemo
            Left = 0
            Top = 267
            Width = 836
            Height = 313
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alClient
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clGray
            Font.Height = -20
            Font.Name = 'Lucida Console'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            ExplicitWidth = 876
          end
          object pgcTop2: TPageControl
            Left = 0
            Top = 0
            Width = 836
            Height = 267
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            ActivePage = tbsMain
            Align = alTop
            TabOrder = 1
            ExplicitWidth = 876
            object tbsMain: TTabSheet
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1054#1089#1085#1086#1074#1085#1099#1077
              ExplicitWidth = 868
              object lblIntervalC: TLabel
                Left = 24
                Top = 192
                Width = 85
                Height = 19
                Hint = #1080#1085#1090#1077#1088#1074#1072#1083' '#1084#1075#1085#1086#1074#1077#1085#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1080#1085#1090#1077#1088#1074#1072#1083#1099':'
                ParentShowHint = False
                ShowHint = True
                WordWrap = True
              end
              object Label1: TLabel
                Left = 470
                Top = 100
                Width = 17
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1086#1090
              end
              object Label2: TLabel
                Left = 470
                Top = 69
                Width = 17
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1086#1090
              end
              object Label3: TLabel
                Left = 470
                Top = 131
                Width = 17
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1086#1090
              end
              object lblDigitalsMin: TLabel
                Left = 470
                Top = 162
                Width = 17
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1086#1090
              end
              object Label5: TLabel
                Left = 116
                Top = 69
                Width = 17
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1086#1090
              end
              object Label6: TLabel
                Left = 116
                Top = 100
                Width = 17
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1086#1090
              end
              object Label7: TLabel
                Left = 116
                Top = 131
                Width = 17
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1086#1090
              end
              object Label8: TLabel
                Left = 116
                Top = 162
                Width = 17
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1086#1090
              end
              object Label9: TLabel
                Left = 116
                Top = 192
                Width = 17
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1086#1090
              end
              object Label10: TLabel
                Left = 228
                Top = 69
                Width = 39
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1074#1089#1077#1075#1086
              end
              object Label11: TLabel
                Left = 228
                Top = 100
                Width = 39
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1074#1089#1077#1075#1086
              end
              object Label12: TLabel
                Left = 228
                Top = 131
                Width = 39
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1074#1089#1077#1075#1086
              end
              object Label13: TLabel
                Left = 228
                Top = 162
                Width = 39
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1074#1089#1077#1075#1086
              end
              object Label14: TLabel
                Left = 228
                Top = 192
                Width = 39
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1074#1089#1077#1075#1086
              end
              object Label15: TLabel
                Left = 575
                Top = 69
                Width = 39
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1074#1089#1077#1075#1086
              end
              object Label16: TLabel
                Left = 575
                Top = 100
                Width = 39
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1074#1089#1077#1075#1086
              end
              object Label17: TLabel
                Left = 575
                Top = 131
                Width = 39
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1074#1089#1077#1075#1086
              end
              object lblDigitalsCount: TLabel
                Left = 575
                Top = 162
                Width = 39
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1074#1089#1077#1075#1086
              end
              object Label19: TLabel
                Left = 375
                Top = 69
                Width = 59
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1082#1072#1085#1072#1083#1099':'
              end
              object Label20: TLabel
                Left = 375
                Top = 100
                Width = 59
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1075#1088#1091#1087#1087#1099':'
              end
              object Label21: TLabel
                Left = 375
                Top = 131
                Width = 63
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1090#1072#1088#1080#1092#1099':'
              end
              object Label22: TLabel
                Left = 24
                Top = 69
                Width = 94
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1090#1088#1077#1093#1084#1080#1085#1091#1090#1099':'
              end
              object Label23: TLabel
                Left = 24
                Top = 100
                Width = 76
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1087#1086#1083#1091#1095#1072#1089#1099':'
              end
              object Label24: TLabel
                Left = 24
                Top = 131
                Width = 46
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1089#1091#1090#1082#1080':'
              end
              object Label25: TLabel
                Left = 24
                Top = 162
                Width = 59
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1084#1077#1089#1103#1094#1099':'
              end
              object lbllJournal: TLabel
                Left = 375
                Top = 192
                Width = 61
                Height = 19
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1078#1091#1088#1085#1072#1083':'
              end
              object clbCurrents: TCheckListBox
                Left = 703
                Top = 0
                Width = 125
                Height = 233
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Align = alRight
                ItemHeight = 19
                PopupMenu = ppmCurrents
                TabOrder = 0
                ExplicitLeft = 743
              end
              object edtlblIntervalCMin: TEdit
                Left = 152
                Top = 188
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 1
                Text = '0'
              end
              object updIntervalMin: TUpDown
                Left = 190
                Top = 188
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtlblIntervalCMin
                Max = 10000
                TabOrder = 2
              end
              object edtIntervalCCount: TEdit
                Left = 280
                Top = 188
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 3
                Text = '1'
              end
              object updIntervalCount: TUpDown
                Left = 318
                Top = 188
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtIntervalCCount
                Min = 1
                Max = 10000
                Position = 1
                TabOrder = 4
              end
              object edtMinutesMin: TEdit
                Left = 152
                Top = 64
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 5
                Text = '0'
              end
              object updMinutesMin: TUpDown
                Left = 190
                Top = 64
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtMinutesMin
                Max = 10000
                TabOrder = 6
              end
              object updHoursMin: TUpDown
                Left = 190
                Top = 95
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtHoursMin
                Max = 10000
                TabOrder = 7
              end
              object edtHoursMin: TEdit
                Left = 152
                Top = 95
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 8
                Text = '0'
              end
              object edtDaysMin: TEdit
                Left = 152
                Top = 126
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 9
                Text = '0'
              end
              object updDaysMin: TUpDown
                Left = 190
                Top = 126
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtDaysMin
                Max = 10000
                TabOrder = 10
              end
              object updMonthsMin: TUpDown
                Left = 190
                Top = 157
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtMonthsMin
                Max = 10000
                TabOrder = 11
              end
              object edtMonthsMin: TEdit
                Left = 152
                Top = 157
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 12
                Text = '0'
              end
              object edtMonthsCount: TEdit
                Left = 280
                Top = 157
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 13
                Text = '1'
              end
              object updMonthsCount: TUpDown
                Left = 318
                Top = 157
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtMonthsCount
                Min = 1
                Max = 10000
                Position = 1
                TabOrder = 14
              end
              object updDaysCount: TUpDown
                Left = 318
                Top = 126
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtDaysCount
                Min = 1
                Max = 10000
                Position = 1
                TabOrder = 15
              end
              object edtDaysCount: TEdit
                Left = 280
                Top = 126
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 16
                Text = '1'
              end
              object edtHoursCount: TEdit
                Left = 280
                Top = 95
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 17
                Text = '1'
              end
              object updHoursCount: TUpDown
                Left = 318
                Top = 95
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtHoursCount
                Min = 1
                Max = 10000
                Position = 1
                TabOrder = 18
              end
              object updMinutesCount: TUpDown
                Left = 317
                Top = 64
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtMinutesCount
                Min = 1
                Max = 10000
                Position = 1
                TabOrder = 19
              end
              object edtMinutesCount: TEdit
                Left = 279
                Top = 64
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 20
                Text = '1'
              end
              object edtDigitalsMin: TEdit
                Left = 504
                Top = 157
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 21
                Text = '1'
              end
              object updDigitalsMin: TUpDown
                Left = 542
                Top = 157
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtDigitalsMin
                Min = 1
                Max = 512
                Position = 1
                TabOrder = 22
              end
              object updTariffsMin: TUpDown
                Left = 542
                Top = 126
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtTariffsMin
                Min = 1
                Max = 48
                Position = 1
                TabOrder = 23
              end
              object edtTariffsMin: TEdit
                Left = 504
                Top = 126
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 24
                Text = '1'
              end
              object edtGroupsMin: TEdit
                Left = 504
                Top = 95
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 25
                Text = '1'
              end
              object updGroupsMin: TUpDown
                Left = 542
                Top = 95
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtGroupsMin
                Min = 1
                Max = 10000
                Position = 1
                TabOrder = 26
              end
              object updCanalsMin: TUpDown
                Left = 540
                Top = 64
                Width = 21
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtCanalsMin
                Min = 1
                Max = 10000
                Position = 1
                TabOrder = 27
              end
              object edtCanalsMin: TEdit
                Left = 502
                Top = 64
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 28
                Text = '1'
              end
              object edtCanalsCount: TEdit
                Left = 629
                Top = 64
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 29
                Text = '1'
              end
              object updCanalsCount: TUpDown
                Left = 667
                Top = 64
                Width = 21
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtCanalsCount
                Min = 1
                Max = 10000
                Position = 1
                TabOrder = 30
              end
              object updGroupsCount: TUpDown
                Left = 669
                Top = 95
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtGroupsCount
                Min = 1
                Max = 10000
                Position = 1
                TabOrder = 31
              end
              object edtGroupsCount: TEdit
                Left = 631
                Top = 95
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 32
                Text = '1'
              end
              object edtTariffsCount: TEdit
                Left = 631
                Top = 126
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 33
                Text = '1'
              end
              object updTariffsCount: TUpDown
                Left = 669
                Top = 126
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtTariffsCount
                Min = 1
                Max = 48
                Position = 1
                TabOrder = 34
              end
              object updDigitalsCount: TUpDown
                Left = 669
                Top = 157
                Width = 20
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Associate = edtDigitalsCount
                Min = 1
                Max = 512
                Position = 1
                TabOrder = 35
              end
              object edtDigitalsCount: TEdit
                Left = 631
                Top = 157
                Width = 38
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                TabOrder = 36
                Text = '1'
              end
              object btbRun: TBitBtn
                Left = 14
                Top = 15
                Width = 120
                Height = 30
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
                Margin = 8
                TabOrder = 37
                OnClick = btbRunClick
              end
              object chbDigitals: TCheckBox
                Left = 354
                Top = 162
                Width = 109
                Height = 20
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Caption = #1091#1089#1090#1088#1086#1081#1089#1090#1074#1072':'
                TabOrder = 38
                OnClick = chbDigitalsClick
              end
              object cmbJournal: TComboBox
                Left = 504
                Top = 188
                Width = 187
                Height = 27
                Margins.Left = 4
                Margins.Top = 4
                Margins.Right = 4
                Margins.Bottom = 4
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 39
                Text = #1078#1091#1088#1085#1072#1083' 1'
                Items.Strings = (
                  #1078#1091#1088#1085#1072#1083' 1'
                  #1078#1091#1088#1085#1072#1083' 2'
                  #1078#1091#1088#1085#1072#1083' 3')
              end
            end
          end
        end
        object pgcParams: TPageControl
          Left = 0
          Top = 0
          Width = 345
          Height = 580
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          ActivePage = tbsParamsRead
          Align = alLeft
          TabOrder = 2
          OnChange = pgcParamsChange
          object tbsParamsRead: TTabSheet
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = #1063#1090#1077#1085#1080#1077
            ExplicitWidth = 297
            object clbMain: TCheckListBox
              Left = 0
              Top = 0
              Width = 337
              Height = 546
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Align = alClient
              ItemHeight = 19
              ParentShowHint = False
              PopupMenu = ppmList
              ShowHint = True
              TabOrder = 0
              OnMouseMove = clbMainMouseMove
              ExplicitWidth = 302
            end
          end
          object tbsParamsWrite: TTabSheet
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = #1047#1072#1087#1080#1089#1100
            ImageIndex = 1
            ExplicitWidth = 297
            object lblTransitDevice: TLabel
              Left = 15
              Top = 186
              Width = 88
              Height = 19
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1091#1089#1090#1088#1086#1081#1089#1090#1074#1086':'
            end
            object lblTransitTimeout: TLabel
              Left = 15
              Top = 216
              Width = 49
              Height = 19
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1074#1088#1077#1084#1103':'
            end
            object btbCorrectTime: TBitBtn
              Left = 15
              Top = 67
              Width = 262
              Height = 30
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1058#1077#1082#1091#1097#1077#1077' '#1074#1088#1077#1084#1103': '#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1072#1090#1100
              Margin = 8
              TabOrder = 0
              OnClick = btbCorrectTimeClick
            end
            object btbSetTime: TBitBtn
              Left = 15
              Top = 19
              Width = 262
              Height = 30
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1058#1077#1082#1091#1097#1077#1077' '#1074#1088#1077#1084#1103': '#1087#1088#1086#1095#1080#1090#1072#1090#1100
              Margin = 8
              TabOrder = 1
              OnClick = btbSetTimeClick
            end
            object updTransitDevice: TUpDown
              Left = 153
              Top = 183
              Width = 20
              Height = 27
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Associate = edtTransitDevice
              Min = 1
              Max = 512
              Position = 1
              TabOrder = 2
            end
            object edtTransitDevice: TEdit
              Left = 115
              Top = 183
              Width = 38
              Height = 27
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 3
              Text = '1'
            end
            object btbTransit: TBitBtn
              Left = 15
              Top = 135
              Width = 262
              Height = 31
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1054#1090#1082#1088#1099#1090#1100' '#1090#1088#1072#1085#1079#1080#1090
              Margin = 8
              TabOrder = 4
              OnClick = btbTransitClick
            end
            object edtTransitTimeout: TEdit
              Left = 115
              Top = 213
              Width = 38
              Height = 27
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              TabOrder = 5
              Text = '250'
            end
            object updTransitTimeout: TUpDown
              Left = 153
              Top = 213
              Width = 20
              Height = 27
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Associate = edtTransitTimeout
              Min = 1
              Max = 255
              Position = 250
              TabOrder = 6
            end
          end
        end
      end
      object tbsLast: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1058#1077#1088#1084#1080#1085#1072#1083
        object panTop3: TPanel
          Left = 0
          Top = 580
          Width = 1190
          Height = 48
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object panRight3: TPanel
            Left = 780
            Top = 0
            Width = 410
            Height = 48
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
            object btbClearTerminal: TBitBtn
              Left = 147
              Top = 10
              Width = 119
              Height = 29
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1054#1095#1080#1089#1090#1080#1090#1100
              Margin = 12
              TabOrder = 1
              OnClick = btbClearTerminalClick
            end
            object btbSaveTerminal: TBitBtn
              Left = 14
              Top = 10
              Width = 119
              Height = 29
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1042' '#1092#1072#1081#1083'  '
              Margin = 12
              NumGlyphs = 2
              TabOrder = 0
              OnClick = btbSaveTerminalClick
            end
            object btbStopTerminal: TBitBtn
              Left = 280
              Top = 10
              Width = 119
              Height = 29
              Margins.Left = 4
              Margins.Top = 4
              Margins.Right = 4
              Margins.Bottom = 4
              Caption = #1057#1090#1086#1087' !'
              Margin = 8
              TabOrder = 2
              OnClick = btbStopInfoClick
            end
          end
          object chbTerminal: TCheckBox
            Left = 19
            Top = 17
            Width = 201
            Height = 20
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = #1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1090#1077#1088#1084#1080#1085#1072#1083
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object chbBulk: TCheckBox
            Left = 227
            Top = 17
            Width = 172
            Height = 20
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = #1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1087#1088#1086#1094#1077#1089#1089
            TabOrder = 2
          end
          object btbDirect: TBitBtn
            Left = 409
            Top = 12
            Width = 269
            Height = 30
            Margins.Left = 4
            Margins.Top = 4
            Margins.Right = 4
            Margins.Bottom = 4
            Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1079#1072#1087#1088#1086#1089
            Margin = 12
            NumGlyphs = 2
            TabOrder = 3
            OnClick = btbDirectClick
          end
        end
        object redTerminal: TMemo
          Left = 0
          Top = 0
          Width = 1190
          Height = 580
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clGray
          Font.Height = -20
          Font.Name = 'Lucida Console'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
    end
  end
  object prbMain: TProgressBar
    Left = 746
    Top = 75
    Width = 178
    Height = 21
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 2
  end
  object ComPort: TApdComPort
    ComNumber = 1
    Baud = 1200
    InSize = 8192
    AutoOpen = False
    TraceSize = 32000
    TraceName = 'sem3reader.trc'
    LogSize = 65000
    LogName = 'sem3reader.log'
    TapiMode = tmOn
    OnTriggerAvail = ComPortTriggerAvail
    Left = 504
    Top = 8
  end
  object timTimeout: TTimer
    Enabled = False
    OnTimer = timTimeoutTimer
    Left = 428
    Top = 8
  end
  object timNow: TTimer
    Interval = 300
    OnTimer = timNowTimer
    Left = 388
    Top = 8
  end
  object sd_RichToFile: TSaveDialog
    DefaultExt = 'rtf'
    Filter = #1092#1072#1081#1083' '#1092#1086#1088#1084#1072#1090#1072' TXT|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Title = #1047#1072#1087#1080#1089#1072#1090#1100' '#1092#1072#1081#1083
    Left = 468
    Top = 8
  end
  object TapiDevice: TApdTapiDevice
    ComPort = ComPort
    TapiLog = TapiLog
    ShowTapiDevices = True
    ShowPorts = False
    EnableVoice = False
    OnTapiStatus = TapiDeviceTapiStatus
    OnTapiLog = TapiDeviceTapiLog
    OnTapiPortOpen = TapiDeviceTapiPortOpen
    OnTapiPortClose = TapiDeviceTapiPortClose
    OnTapiConnect = TapiDeviceTapiConnect
    OnTapiFail = TapiDeviceTapiFail
    Left = 544
    Top = 8
  end
  object TapiLog: TApdTapiLog
    TapiHistoryName = 'sem3reader.his'
    TapiDevice = TapiDevice
    Left = 584
    Top = 8
  end
  object ppmMain: TPopupMenu
    Left = 624
    Top = 8
    object mitVersion: TMenuItem
      Caption = #1074#1077#1088#1089#1080#1103' '#1086#1090' 12 '#1072#1074#1075#1091#1089#1090#1072' 2015 '#1075#1086#1076#1072
    end
  end
  object ppmList: TPopupMenu
    Left = 664
    Top = 8
    object mitSetItems: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1089#1077' '#1087#1091#1085#1082#1090#1099
      OnClick = mitSetItemsClick
    end
    object mitClearItems: TMenuItem
      Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1074#1089#1077' '#1087#1091#1085#1082#1090#1099
      OnClick = mitClearItesClick
    end
  end
  object ppmCurrents: TPopupMenu
    Left = 920
    Top = 176
    object mniSetCurrents: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1089#1077' '#1087#1091#1085#1082#1090#1099
      OnClick = mniSetCurrentsClick
    end
    object mniClearCurrents: TMenuItem
      Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1074#1089#1077' '#1087#1091#1085#1082#1090#1099
      OnClick = mniClearCurrentsClick
    end
  end
  object IdTCPClient: TIdTCPClient
    OnStatus = IdTCPClientStatus
    OnDisconnected = IdTCPClientDisconnected
    OnWork = IdTCPClientWork
    OnWorkBegin = IdTCPClientWorkBegin
    OnWorkEnd = IdTCPClientWorkEnd
    OnConnected = IdTCPClientConnected
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    OnBeforeBind = IdTCPClientBeforeBind
    OnAfterBind = IdTCPClientAfterBind
    OnSocketAllocated = IdTCPClientSocketAllocated
    Left = 704
    Top = 8
  end
end
