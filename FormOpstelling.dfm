object frmOpstelling: TfrmOpstelling
  Left = 327
  Top = 249
  BorderStyle = bsNone
  Caption = 'frmOpstelling'
  ClientHeight = 525
  ClientWidth = 1168
  Color = clBtnFace
  Constraints.MinHeight = 180
  Constraints.MinWidth = 950
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlRatings: TPanel
    Left = 760
    Top = 0
    Width = 408
    Height = 525
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object cxpgctrlRatings: TcxPageControl
      Left = 0
      Top = 0
      Width = 408
      Height = 525
      ActivePage = tbshtRatings
      Align = alClient
      TabOrder = 0
      ClientRectBottom = 525
      ClientRectRight = 408
      ClientRectTop = 24
      object tbshtRatings: TcxTabSheet
        Caption = 'Ratings'
        ImageIndex = 0
        object pnlRatingsMain: TPanel
          Left = 0
          Top = 0
          Width = 408
          Height = 501
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object lblRV: TLabel
            Left = 130
            Top = 92
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblLinkerVerdediging: TLabel
            Left = 12
            Top = 132
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
            Left = 130
            Top = 132
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblRechterVerdediging: TLabel
            Left = 12
            Top = 92
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
            Top = 112
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
            Left = 130
            Top = 112
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblRA: TLabel
            Left = 130
            Top = 152
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblLinkerAanval: TLabel
            Left = 12
            Top = 192
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
            Left = 130
            Top = 192
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblRechterAanval: TLabel
            Left = 12
            Top = 152
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
            Top = 172
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
            Left = 130
            Top = 172
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblMiddenveld: TLabel
            Left = 12
            Top = 72
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
            Left = 130
            Top = 72
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblHatStatsCaption: TLabel
            Left = 12
            Top = 214
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
            Left = 130
            Top = 214
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblMotivatie: TLabel
            Left = 12
            Top = 10
            Width = 44
            Height = 13
            Caption = 'Motivatie'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblTactiek: TLabel
            Left = 12
            Top = 31
            Width = 34
            Height = 13
            Caption = 'Tactiek'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblCoach: TLabel
            Left = 12
            Top = 52
            Width = 30
            Height = 13
            Caption = 'Coach'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object lblTacticLevel: TLabel
            Left = 254
            Top = 31
            Width = 147
            Height = 13
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object cbMotivatie: TcxImageComboBox
            Left = 128
            Top = 5
            Properties.ImmediatePost = True
            Properties.ImmediateUpdateText = True
            Properties.Items = <>
            Properties.OnValidate = cbMotivatiePropertiesValidate
            TabOrder = 0
            Width = 121
          end
          object cbTactiek: TcxImageComboBox
            Left = 128
            Top = 26
            Properties.ImmediatePost = True
            Properties.ImmediateUpdateText = True
            Properties.Items = <>
            Properties.OnValidate = cbTactiekPropertiesValidate
            TabOrder = 1
            Width = 121
          end
          object cbCoach: TcxImageComboBox
            Left = 128
            Top = 47
            Properties.ImmediatePost = True
            Properties.ImmediateUpdateText = True
            Properties.Items = <>
            Properties.OnValidate = cbCoachPropertiesValidate
            TabOrder = 2
            Width = 121
          end
          object pnlHandmatig: TPanel
            Left = 351
            Top = 0
            Width = 57
            Height = 501
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 3
            object edMID: TcxCurrencyEdit
              Left = 5
              Top = 69
              Properties.DisplayFormat = ',0.00'
              Properties.MaxValue = 25
              Properties.OnEditValueChanged = edPropertiesChange
              TabOrder = 0
              Width = 49
            end
            object edRV: TcxCurrencyEdit
              Left = 5
              Top = 89
              Properties.DisplayFormat = ',0.00'
              Properties.MaxValue = 25
              Properties.OnEditValueChanged = edPropertiesChange
              TabOrder = 1
              Width = 49
            end
            object edCV: TcxCurrencyEdit
              Left = 5
              Top = 109
              Properties.DisplayFormat = ',0.00'
              Properties.MaxValue = 25
              Properties.OnEditValueChanged = edPropertiesChange
              TabOrder = 2
              Width = 49
            end
            object edLV: TcxCurrencyEdit
              Left = 5
              Top = 129
              Properties.DisplayFormat = ',0.00'
              Properties.MaxValue = 25
              Properties.OnEditValueChanged = edPropertiesChange
              TabOrder = 3
              Width = 49
            end
            object edRA: TcxCurrencyEdit
              Left = 5
              Top = 149
              Properties.DisplayFormat = ',0.00'
              Properties.MaxValue = 25
              Properties.OnEditValueChanged = edPropertiesChange
              TabOrder = 4
              Width = 49
            end
            object edCA: TcxCurrencyEdit
              Left = 5
              Top = 169
              Properties.DisplayFormat = ',0.00'
              Properties.MaxValue = 25
              Properties.OnEditValueChanged = edPropertiesChange
              TabOrder = 5
              Width = 49
            end
            object edLA: TcxCurrencyEdit
              Left = 5
              Top = 189
              Properties.DisplayFormat = ',0.00'
              Properties.MaxValue = 25
              Properties.OnEditValueChanged = edPropertiesChange
              TabOrder = 6
              Width = 49
            end
          end
        end
      end
      object tbshtVoorspelling: TcxTabSheet
        Caption = 'Voorspelling'
        ImageIndex = 1
        object Panel1: TPanel
          Left = 0
          Top = 320
          Width = 408
          Height = 181
          Align = alBottom
          Caption = 'Panel1'
          TabOrder = 0
        end
      end
    end
  end
  object pnlOpstelling: TPanel
    Left = 0
    Top = 0
    Width = 760
    Height = 525
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
  end
end
