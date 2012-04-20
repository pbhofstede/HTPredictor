object frmOpstelling: TfrmOpstelling
  Left = 356
  Top = 192
  BorderStyle = bsNone
  Caption = 'frmOpstelling'
  ClientHeight = 525
  ClientWidth = 1084
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
    Left = 747
    Top = 0
    Width = 337
    Height = 525
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object lblRV: TLabel
      Left = 128
      Top = 52
      Width = 203
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblLinkerVerdediging: TLabel
      Left = 12
      Top = 88
      Width = 87
      Height = 13
      Caption = 'Linker verdediging'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblLV: TLabel
      Left = 128
      Top = 88
      Width = 203
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblRechterVerdediging: TLabel
      Left = 12
      Top = 52
      Width = 97
      Height = 13
      Caption = 'Rechter verdediging'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 12
      Top = 70
      Width = 100
      Height = 13
      Caption = 'Centrale verdediging'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCV: TLabel
      Left = 128
      Top = 70
      Width = 203
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblRA: TLabel
      Left = 128
      Top = 106
      Width = 203
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblLinkerAanval: TLabel
      Left = 12
      Top = 142
      Width = 63
      Height = 13
      Caption = 'Linker aanval'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblLA: TLabel
      Left = 128
      Top = 142
      Width = 203
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblRechterAanval: TLabel
      Left = 12
      Top = 106
      Width = 73
      Height = 13
      Caption = 'Rechter aanval'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCentraleAanval: TLabel
      Left = 12
      Top = 124
      Width = 76
      Height = 13
      Caption = 'Centrale aanval'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCA: TLabel
      Left = 128
      Top = 124
      Width = 203
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblMiddenveld: TLabel
      Left = 12
      Top = 34
      Width = 54
      Height = 13
      Caption = 'Middenveld'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblIM: TLabel
      Left = 128
      Top = 34
      Width = 203
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblHatStatsCaption: TLabel
      Left = 12
      Top = 162
      Width = 42
      Height = 13
      Caption = 'HatStats'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblHatStats: TLabel
      Left = 128
      Top = 162
      Width = 128
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlOpstelling: TPanel
    Left = 0
    Top = 0
    Width = 747
    Height = 525
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
  end
end
