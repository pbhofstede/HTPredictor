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
    Caption = 'pnlRatings'
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
