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
