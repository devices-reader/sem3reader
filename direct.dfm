inherited frmDirect: TfrmDirect
  Left = 681
  Top = 427
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
  ClientHeight = 235
  ClientWidth = 481
  FormStyle = fsStayOnTop
  ExplicitWidth = 487
  ExplicitHeight = 263
  PixelsPerInch = 96
  TextHeight = 16
  inherited panClient: TPanel
    Width = 481
    Height = 194
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ExplicitWidth = 481
    ExplicitHeight = 194
    object lblInfo: TLabel
      Left = 56
      Top = 16
      Width = 206
      Height = 16
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1088#1086#1080#1079#1074#1086#1083#1100#1085#1099#1081' '#1079#1072#1087#1088#1086#1089' ?'
    end
    object imgInfo: TImage
      Left = 16
      Top = 9
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        055449636F6E0000010002002020100000000000E80200002600000010101000
        00000000280100000E0300002800000020000000400000000100040000000000
        8002000000000000000000000000000000000000000000000000800000800000
        0080800080000000800080008080000080808000C0C0C0000000FF0000FF0000
        00FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000000000077000
        0000000000000000000000000077700000000000000000000000000000077000
        0000000000000000000000000F077000000000000000000000000000FF077000
        00000000000000000000070FFF07700000000000000000000077770FFF077777
        00000000000000007770008FFF07777777000000000000070008FFFFFF800077
        77700000000000008FFFFFFFFFFFF800777700000000008FFFFFFFFFFFFFFFF8
        0777700000000FFFFFFFFFFFFFFFFFFFF07777000000FFFFFFFFFFFFFFFFFFFF
        FF077770007FFFFFFFFCCCCCCCCCFFFFFFF07770078FFFFFFFFFFCCCCCFFFFFF
        FFF8077707FFFFFFFFFFFCCCCCFFFFFFFFFF077778FFFFFFFFFFFCCCCCFFFFFF
        FFFF80777FFFFFFFFFFFFCCCCCFFFFFFFFFFF0777FFFFFFFFFFFFCCCCCFFFFFF
        FFFFF0777FFFFFFFFFFFFCCCCCFFFFFFFFFFF0777FFFFFFFFFFFFCCCCCFFFFFF
        FFFFF0777FFFFFFFFFFCCCCCCCFFFFFFFFFFF07078FFFFFFFFFFFFFFFFFFFFFF
        FFFF807007FFFFFFFFFFFFFFFFFFFFFFFFFF0700078FFFFFFFFF8CCCC8FFFFFF
        FFF80000007FFFFFFFFFCCCCCCFFFFFFFFF000000007FFFFFFFFCCCCCCFFFFFF
        FF00000000007FFFFFFF8CCCC8FFFFFFF00000000000078FFFFFFFFFFFFFFFF8
        70000000000000778FFFFFFFFFFFF87700000000000000007778FFFFFF877700
        0000000000000000000777777770000000000000FFFFE7FFFFFFC7FFFFFF87FF
        FFFF07FFFFFE07FFFFF807FFFFC000FFFF00003FFE00001FFC00000FF8000007
        F0000003E0000001C00000018000000080000000000000000000000000000000
        000000000000000000000001000000018000000380000007C000000FE000001F
        F000003FF800007FFC0000FFFF0003FFFFE01FFF280000001000000020000000
        0100040000000000C00000000000000000000000000000000000000000000000
        00008000008000000080800080000000800080008080000080808000C0C0C000
        0000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000
        00070000000000070F07000000000700FF0700000000008FFF07700000008FFF
        FF0077000078FFFFFFF8077007FFFFFFFFFFF07007FFFFCCCCFFF0777FFFFFFC
        CFFFFF077FFFFFFCCFFFFF077FFFFFCCCFFFFF077FFFFFFFFFFFFF0007FFFFFC
        CFFFF000078FFFF88FFFF00000778FFFFFF770000000777777700000FF8F0000
        FE0F0000F80F0000F0070000E0030000C0010000800100008000000000000000
        0000000000000000000100008003000080030000C0070000F01F0000}
    end
    object memDirect: TMemo
      Left = 16
      Top = 47
      Width = 449
      Height = 114
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Lucida Console'
      Font.Style = []
      Lines.Strings = (
        '55 00 00 0A 00 01 00 01 8D 09')
      ParentFont = False
      TabOrder = 0
    end
    object chbCRC: TCheckBox
      Left = 16
      Top = 167
      Width = 121
      Height = 17
      Caption = #1076#1086#1073#1072#1074#1080#1090#1100' CRC'
      TabOrder = 1
    end
  end
  inherited panBottom: TPanel
    Top = 194
    Width = 481
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    ExplicitTop = 194
    ExplicitWidth = 481
    inherited panRight: TPanel
      Left = 270
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ExplicitLeft = 270
      inherited btbOK: TBitBtn
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Default = False
      end
      inherited btbNo: TBitBtn
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Default = True
      end
    end
  end
end
