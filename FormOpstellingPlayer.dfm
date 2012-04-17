object frmOpstellingPlayer: TfrmOpstellingPlayer
  Left = 440
  Top = 199
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmOpstellingPlayer'
  ClientHeight = 48
  ClientWidth = 134
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPlayer: TPanel
    Left = 0
    Top = 0
    Width = 134
    Height = 48
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 0
    object cbPlayer: TcxImageComboBox
      Left = 4
      Top = 2
      Properties.Images = frmHTPredictor.imgListHTPredictor
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.Items = <>
      Properties.OnChange = cbPlayerPropertiesChange
      Properties.OnInitPopup = cbPlayerPropertiesPopup
      Properties.OnValidate = cbPlayerPropertiesValidate
      TabOrder = 0
      Width = 121
    end
    object cbOrder: TcxImageComboBox
      Left = 4
      Top = 23
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.Items = <>
      Properties.OnValidate = cbOrderPropertiesValidate
      TabOrder = 1
      Width = 121
    end
  end
end
