object frmOpstellingPlayer: TfrmOpstellingPlayer
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  ParentShowHint = False
  ShowHint = True
  TabOrder = 0
  object pnlPlayer: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 240
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 0
    object lblCaption: TLabel
      Left = 7
      Top = 5
      Width = 47
      Height = 13
      Caption = 'lblCaption'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object cbPlayer: TcxImageComboBox
      Left = 4
      Top = 2
      ParentFont = False
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.Items = <>
      Properties.OnChange = cbPlayerPropertiesChange
      Properties.OnInitPopup = cbPlayerPropertiesPopup
      Properties.OnValidate = cbPlayerPropertiesValidate
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 121
    end
    object cbOrder: TcxImageComboBox
      Left = 4
      Top = 23
      ParentFont = False
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.Items = <>
      Properties.OnValidate = cbOrderPropertiesValidate
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 121
    end
    object vTempCB: TcxImageComboBox
      Left = 124
      Top = 38
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.Items = <>
      TabOrder = 2
      Visible = False
      Width = 121
    end
  end
  object tiHint: TTimer
    Enabled = False
    OnTimer = tiHintTimer
    Left = 54
    Top = 26
  end
end
