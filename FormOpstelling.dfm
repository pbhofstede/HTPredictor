object frmOpstelling: TfrmOpstelling
  Left = 296
  Top = 304
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
      ActivePage = tbshtVoorspelling
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
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ImageIndex = 1
        ParentFont = False
        object lblTeam1: TLabel
          Left = 120
          Top = 16
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object lblTeam2: TLabel
          Left = 230
          Top = 16
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object Label2: TLabel
          Left = 24
          Top = 48
          Width = 45
          Height = 13
          Caption = 'Balbezit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblBBZ1: TLabel
          Left = 119
          Top = 48
          Width = 52
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblBBZ2: TLabel
          Left = 229
          Top = 48
          Width = 52
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 24
          Top = 64
          Width = 35
          Height = 13
          Caption = 'Kansen'
        end
        object lblKansen1: TLabel
          Left = 120
          Top = 64
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object lblKansen2: TLabel
          Left = 230
          Top = 64
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object Label4: TLabel
          Left = 24
          Top = 96
          Width = 57
          Height = 13
          Caption = 'Goals (links)'
        end
        object lblLinks1: TLabel
          Left = 120
          Top = 96
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object lblLinks2: TLabel
          Left = 230
          Top = 96
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object Label5: TLabel
          Left = 24
          Top = 112
          Width = 76
          Height = 13
          Caption = 'Goals (centraal)'
        end
        object lblCentrum1: TLabel
          Left = 120
          Top = 112
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object lblCentrum2: TLabel
          Left = 230
          Top = 112
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object Label6: TLabel
          Left = 24
          Top = 128
          Width = 67
          Height = 13
          Caption = 'Goals (rechts)'
        end
        object lblRechts1: TLabel
          Left = 120
          Top = 128
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object lblRechts2: TLabel
          Left = 230
          Top = 128
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object Label7: TLabel
          Left = 24
          Top = 144
          Width = 50
          Height = 13
          Caption = 'Goals (SH)'
        end
        object lblSH1: TLabel
          Left = 120
          Top = 144
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object lblSH2: TLabel
          Left = 230
          Top = 144
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object Label8: TLabel
          Left = 24
          Top = 160
          Width = 80
          Height = 13
          Caption = 'Goals (Totaal)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblGoals1: TLabel
          Left = 110
          Top = 160
          Width = 52
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblGoals2: TLabel
          Left = 220
          Top = 160
          Width = 52
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel1: TBevel
          Left = 129
          Top = 150
          Width = 33
          Height = 10
          Shape = bsBottomLine
        end
        object Bevel2: TBevel
          Left = 238
          Top = 150
          Width = 33
          Height = 10
          Shape = bsBottomLine
        end
        object Label9: TLabel
          Left = 24
          Top = 192
          Width = 61
          Height = 13
          Caption = 'Winstkansen'
        end
        object lblWinst1: TLabel
          Left = 120
          Top = 192
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object lblWinst2: TLabel
          Left = 230
          Top = 192
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'lblTeam1'
        end
        object lblTeamsGelijk: TLabel
          Left = 184
          Top = 192
          Width = 42
          Height = 13
          Alignment = taCenter
          Caption = 'lblTeam1'
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
    object pnlVoorspelling: TPanel
      Left = 470
      Top = 0
      Width = 284
      Height = 58
      BevelInner = bvLowered
      BevelOuter = bvNone
      TabOrder = 0
      object spdbtnGetVoorspelling: TSpeedButton
        Left = 5
        Top = 4
        Width = 23
        Height = 22
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000000000000000000000000000000000008000FF8000FF
          8000FF8000FF8000FFCBCBCBB6B6B6B1B1B1B3B3B3C3C3C38000FF8000FF8000
          FF8000FF8000FF8000FF8000FF8000FF8000FFC1C1C1B1A49EEAD5CAF0DCD1F0
          DCD1EFDBD0C0AFA5585858A7A7A78000FF8000FF8000FF8000FF8000FF8000FF
          A7A6A6F2DFD5F2F4F5EBEEEFDFE2E3ECEFF1EDF0F2EFF2F2F4E9E39889828383
          838000FF8000FF8000FF8000FFBDB8B5F6F1EFF0F4F5D5AB95BB5B2AC06133C6
          7349BB5827C98767EDF0F2F4F6F6C1AEA48C8C8C8000FF8000FFDCDCDCF6E8E1
          F2F7F8C36D43C36231CA622EC1C4C5FFFFFFC76330C46232BC5A28ECEAE9F6F7
          F7726863BCBCBC8000FFE6D3C8F6F8F9CE8866C66433CC6734CC6633C98563DD
          A88FCC6431CC6634C66333BE5D2CF1F5F7F2DFD57575758000FFF4E5DCF4F4F4
          C35E2BCD6836CC6734CC6532CB957CEAC0AACB622ECC6633CC6734C56332DCB6
          A3F6F6F55956548000FFFCF8F5E4BCA9CC6938CE6836CC6633CC6632C1AEA5FF
          FFFFCA5D28CC6633CD6734CB6735C77349F7F9FBBFADA58000FFFFFEFEDFA081
          D26E3CCE6936CC6633CC6633C66839F1F6F8FAF1ECCA602BCC6734CE6937C869
          39F9FCFEC9B7AE8000FFFEFBFBECB99FDA7644D06B38CC6633CC6633CC6633C5
          693AFCFFFFF5E0D7CD6531D26D3BCE7143FFFFFFC8B7AD8000FFF8ECE6FEFAF7
          E8824FD8723FCF9071E7B9A3CB622DCC6633E1CDC2FFFFFFD06733D87441E5AB
          8EFFFEFE988E888000FFF0DBD0FFFFFFFDA374F48F5CC69F8CFFFFFFE6B299D1
          7F56FCFEFFEDEDECDF7641E07744FFFFFFF6E9E1A9A9A98000FF8000FFFDFAF9
          FFFFFFFFB580FFA26ED7CECBF5F9FBF7FBFCF1F6F9F19C73FA9360FEE2D2FFFF
          FFCFBDB38000FF8000FF8000FFEEDDD3FFFFFFFFFFFFFFEFC6FFDDA6FFC696FD
          BD8CFFBB87FFC28EFFFCF8FFFFFFF1DDD2D0D0D08000FF8000FF8000FF8000FF
          EEDDD5FCF7F5FFFFFFFFFFFFFFFFFDFFFFFCFFFFFDFFFFFFFFFFFFEFDBD0D4D4
          D48000FF8000FF8000FF8000FF8000FF8000FFF4F4F3EFDCD0F6E9E1FDFAF9FE
          FCFBF9EEE9EFDBD0D1C7C28000FF8000FF8000FF8000FF8000FF}
        OnClick = spdbtnGetVoorspellingClick
      end
      object lblWinst: TLabel
        Left = 34
        Top = 2
        Width = 38
        Height = 13
        Caption = 'Winst: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblGelijk: TLabel
        Left = 34
        Top = 17
        Width = 35
        Height = 13
        Caption = 'Gelijk:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblVerlies: TLabel
        Left = 34
        Top = 32
        Width = 44
        Height = 13
        Caption = 'Verlies: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblWinstPerc: TLabel
        Left = 108
        Top = 2
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Winst: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblGelijkPerc: TLabel
        Left = 108
        Top = 17
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Winst: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblVerliesPerc: TLabel
        Left = 108
        Top = 32
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Winst: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblUitslag: TLabel
        Left = 217
        Top = 27
        Width = 57
        Height = 19
        Alignment = taRightJustify
        Caption = 'Winst: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblWinstDiff: TLabel
        Left = 151
        Top = 2
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Winst: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblGelijkDiff: TLabel
        Left = 151
        Top = 17
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Winst: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblVerliesDiff: TLabel
        Left = 151
        Top = 32
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Winst: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object JvPrediction: TJvHttpUrlGrabber
    FileName = 'output.txt'
    OutputMode = omStream
    Agent = 'JEDI-VCL'
    Port = 0
    OnDoneStream = JvPredictionDoneStream
    Left = 608
    Top = 77
  end
  object jvXML: TJvSimpleXML
    IndentString = '  '
    Left = 616
    Top = 152
  end
end
