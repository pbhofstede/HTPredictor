object frmSpelerGrid: TfrmSpelerGrid
  Left = 0
  Top = 0
  Width = 657
  Height = 438
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 657
    Height = 438
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object cxGridSpelers: TcxGrid
      Left = 1
      Top = 25
      Width = 655
      Height = 412
      Align = alClient
      TabOrder = 0
      object cxGridSpelersView: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = dsSpelers
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.FocusCellOnTab = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object cxGridSpelersViewLAND: TcxGridDBColumn
          Caption = 'Land'
          DataBinding.FieldName = 'LAND'
          Visible = False
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
          Properties.ReadOnly = True
          Width = 253
        end
        object cxGridSpelersViewSPECIALITEIT: TcxGridDBColumn
          Caption = 'Specialiteit'
          DataBinding.FieldName = 'SPECIALITEIT'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          Width = 120
        end
        object cxGridSpelersViewVORM: TcxGridDBColumn
          Caption = 'Vorm'
          DataBinding.FieldName = 'VORM'
          PropertiesClassName = 'TcxSpinEditProperties'
          Properties.AssignedValues.MinValue = True
          Properties.Increment = 0.1
          Properties.MaxValue = 8
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
          Properties.MaxValue = 30
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
        object cxGridSpelersViewLOYALITEIT: TcxGridDBColumn
          Caption = 'Loyaliteit'
          DataBinding.FieldName = 'LOYALITEIT'
        end
      end
      object cxGridSpelersLevel1: TcxGridLevel
        GridView = cxGridSpelersView
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 1
      Top = 1
      Width = 655
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
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnOpslaan'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object btnOpslaan: TdxBarButton
      Caption = 'Opslaan'
      Category = 0
      Enabled = False
      Hint = 'Opslaan'
      Visible = ivAlways
      ImageIndex = 27
      OnClick = btnOpslaanClick
    end
    object btnLaadFromHO: TdxBarButton
      Caption = 'HO! (csv)'
      Category = 0
      Hint = 'HO! (csv)'
      Visible = ivAlways
      ImageIndex = 75
      OnClick = btnLaadFromHOClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Laad spelers'
      Category = 0
      Visible = ivAlways
      ImageIndex = 25
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnLoadFree'
        end
        item
          Visible = True
          ItemName = 'btnLaadFromHO'
        end>
    end
    object btnLoadFree: TdxBarButton
      Caption = 'NT/U20 (xls)'
      Category = 0
      Hint = 'NT/U20 (xls)'
      Visible = ivAlways
      ImageIndex = 75
      OnClick = btnLoadFreeClick
    end
  end
  object dsSpelers: TDataSource
    DataSet = mdSpelers
    OnStateChange = dsSpelersStateChange
    Left = 264
    Top = 176
  end
  object mdSpelers: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterPost = mdSpelersAfterPost
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
    object mdSpelersLOYALITEIT: TFloatField
      FieldName = 'LOYALITEIT'
      Required = True
    end
  end
end
