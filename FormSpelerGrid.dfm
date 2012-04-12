object frmSpelerGrid: TfrmSpelerGrid
  Left = 463
  Top = 264
  BorderStyle = bsNone
  Caption = 'frmSpelerGrid'
  ClientHeight = 525
  ClientWidth = 1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1072
    Height = 525
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object cxGridSpelers: TcxGrid
      Left = 1
      Top = 25
      Width = 1070
      Height = 499
      Align = alClient
      TabOrder = 0
      object cxGridSpelersView: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = dsSpelers
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        object cxGridSpelersViewLAND: TcxGridDBColumn
          Caption = 'Land'
          DataBinding.FieldName = 'LAND'
        end
        object cxGridSpelersViewRecId: TcxGridDBColumn
          DataBinding.FieldName = 'RecId'
          PropertiesClassName = 'TcxTextEditProperties'
          Visible = False
        end
        object cxGridSpelersViewNAAM: TcxGridDBColumn
          Caption = 'Naam'
          DataBinding.FieldName = 'NAAM'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 253
        end
        object cxGridSpelersViewSPECIALITEIT: TcxGridDBColumn
          Caption = 'Specialiteit'
          DataBinding.FieldName = 'SPECIALITEIT'
          PropertiesClassName = 'TcxTextEditProperties'
          Width = 120
        end
        object cxGridSpelersViewVORM: TcxGridDBColumn
          Caption = 'Vorm'
          DataBinding.FieldName = 'VORM'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.Increment = 0.1
          Properties.MinValue = 8
          Properties.ValueType = vtFloat
          Width = 63
        end
        object cxGridSpelersViewCONDITIE: TcxGridDBColumn
          Caption = 'Conditie'
          DataBinding.FieldName = 'CONDITIE'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.Increment = 0.1
          Properties.MaxValue = 8
          Properties.ValueType = vtFloat
          Width = 64
        end
        object cxGridSpelersViewKEEPEN: TcxGridDBColumn
          Caption = 'GK'
          DataBinding.FieldName = 'KEEPEN'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.Increment = 0.1
          Properties.MaxValue = 30
          Properties.ValueType = vtFloat
          Width = 63
        end
        object cxGridSpelersViewVERDEDIGEN: TcxGridDBColumn
          Caption = 'DEF'
          DataBinding.FieldName = 'VERDEDIGEN'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.Increment = 0.1
          Properties.MaxValue = 30
          Properties.ValueType = vtFloat
          Width = 62
        end
        object cxGridSpelersViewPOSITIESPEL: TcxGridDBColumn
          Caption = 'POS'
          DataBinding.FieldName = 'POSITIESPEL'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.Increment = 0.1
          Properties.MaxValue = 30
          Properties.ValueType = vtFloat
          Width = 62
        end
        object cxGridSpelersViewVLEUGELSPEL: TcxGridDBColumn
          Caption = 'WNG'
          DataBinding.FieldName = 'VLEUGELSPEL'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.Increment = 0.1
          Properties.MaxValue = 30
          Properties.ValueType = vtFloat
          Width = 63
        end
        object cxGridSpelersViewPASSEN: TcxGridDBColumn
          Caption = 'PAS'
          DataBinding.FieldName = 'PASSEN'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.Increment = 0.1
          Properties.MaxValue = 30
          Properties.ValueType = vtFloat
          Width = 63
        end
        object cxGridSpelersViewSCOREN: TcxGridDBColumn
          Caption = 'SC'
          DataBinding.FieldName = 'SCOREN'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.Increment = 0.1
          Properties.ValueType = vtFloat
          Width = 61
        end
        object cxGridSpelersViewSPELHERVATTEN: TcxGridDBColumn
          Caption = 'SP'
          DataBinding.FieldName = 'SPELHERVATTEN'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.Increment = 0.1
          Properties.MaxValue = 30
          Properties.ValueType = vtFloat
          Width = 63
        end
        object cxGridSpelersViewERVARING: TcxGridDBColumn
          Caption = 'XP'
          DataBinding.FieldName = 'ERVARING'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.Increment = 0.1
          Properties.MaxValue = 30
          Properties.ValueType = vtFloat
          Width = 63
        end
      end
      object cxGridSpelersLevel1: TcxGridLevel
        GridView = cxGridSpelersView
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 1
      Top = 1
      Width = 1070
      Height = 24
      Align = dalTop
      BarManager = dxBarManager1
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = frmHTPredictor.imgListHTPredictor
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 176
    Top = 120
    DockControlHeights = (
      0
      0
      0
      0)
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Spelers'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 413
      FloatTop = 264
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'btnLoadPlayers'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object btnLoadPlayers: TdxBarButton
      Caption = 'Laad spelers'
      Category = 0
      Hint = 'Laad spelers'
      Visible = ivAlways
      ImageIndex = 25
      OnClick = btnLoadPlayersClick
    end
  end
  object dsSpelers: TDataSource
    DataSet = mdSpelers
    Left = 264
    Top = 176
  end
  object mdSpelers: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 264
    Top = 256
    object mdSpelersNAAM: TStringField
      FieldName = 'NAAM'
      Required = True
      Size = 100
    end
    object mdSpelersSPECIALITEIT: TStringField
      FieldName = 'SPECIALITEIT'
      Required = True
    end
    object mdSpelersVORM: TFloatField
      FieldName = 'VORM'
      Required = True
    end
    object mdSpelersCONDITIE: TFloatField
      FieldName = 'CONDITIE'
      Required = True
    end
    object mdSpelersKEEPEN: TFloatField
      FieldName = 'KEEPEN'
      Required = True
    end
    object mdSpelersVERDEDIGEN: TFloatField
      FieldName = 'VERDEDIGEN'
      Required = True
    end
    object mdSpelersPOSITIESPEL: TFloatField
      FieldName = 'POSITIESPEL'
      Required = True
    end
    object mdSpelersVLEUGELSPEL: TFloatField
      FieldName = 'VLEUGELSPEL'
      Required = True
    end
    object mdSpelersPASSEN: TFloatField
      FieldName = 'PASSEN'
      Required = True
    end
    object mdSpelersSCOREN: TFloatField
      FieldName = 'SCOREN'
      Required = True
    end
    object mdSpelersSPELHERVATTEN: TFloatField
      FieldName = 'SPELHERVATTEN'
      Required = True
    end
    object mdSpelersERVARING: TFloatField
      FieldName = 'ERVARING'
      Required = True
    end
    object mdSpelersLAND: TStringField
      FieldName = 'LAND'
    end
  end
end
