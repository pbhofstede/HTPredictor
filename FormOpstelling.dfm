object frmOpstelling: TfrmOpstelling
  Left = 356
  Top = 192
  BorderStyle = bsNone
  Caption = 'frmOpstelling'
  ClientHeight = 525
  ClientWidth = 934
  Color = clBtnFace
  Constraints.MinHeight = 180
  Constraints.MinWidth = 950
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlRatings: TPanel
    Left = 749
    Top = 0
    Width = 185
    Height = 525
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object lblRV: TLabel
      Left = 136
      Top = 52
      Width = 40
      Height = 13
      AutoSize = False
    end
    object lblLinkerVerdediging: TLabel
      Left = 20
      Top = 88
      Width = 87
      Height = 13
      Caption = 'Linker verdediging'
    end
    object lblLV: TLabel
      Left = 136
      Top = 88
      Width = 40
      Height = 13
      AutoSize = False
    end
    object lblRechterVerdediging: TLabel
      Left = 20
      Top = 52
      Width = 96
      Height = 13
      Caption = 'Rechter verdediging'
    end
    object Label1: TLabel
      Left = 20
      Top = 70
      Width = 97
      Height = 13
      Caption = 'Centrale verdediging'
    end
    object lblCV: TLabel
      Left = 136
      Top = 70
      Width = 40
      Height = 13
      AutoSize = False
    end
    object lblRA: TLabel
      Left = 136
      Top = 106
      Width = 40
      Height = 13
      AutoSize = False
    end
    object lblLinkerAanval: TLabel
      Left = 20
      Top = 142
      Width = 64
      Height = 13
      Caption = 'Linker aanval'
    end
    object lblLA: TLabel
      Left = 136
      Top = 142
      Width = 40
      Height = 13
      AutoSize = False
    end
    object lblRechterAanval: TLabel
      Left = 20
      Top = 106
      Width = 73
      Height = 13
      Caption = 'Rechter aanval'
    end
    object lblCentraleAanval: TLabel
      Left = 20
      Top = 124
      Width = 74
      Height = 13
      Caption = 'Centrale aanval'
    end
    object lblCA: TLabel
      Left = 136
      Top = 124
      Width = 40
      Height = 13
      AutoSize = False
    end
    object lblMiddenveld: TLabel
      Left = 20
      Top = 34
      Width = 55
      Height = 13
      Caption = 'Middenveld'
    end
    object lblIM: TLabel
      Left = 136
      Top = 34
      Width = 40
      Height = 13
      AutoSize = False
    end
    object lblHatStatsCaption: TLabel
      Left = 20
      Top = 162
      Width = 41
      Height = 13
      Caption = 'HatStats'
    end
    object lblHatStats: TLabel
      Left = 136
      Top = 162
      Width = 40
      Height = 13
      AutoSize = False
    end
  end
  object pnlOpstelling: TPanel
    Left = 0
    Top = 0
    Width = 749
    Height = 525
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
  end
end
