object frmFieldMapping: TfrmFieldMapping
  Left = 610
  Top = 253
  Width = 371
  Height = 425
  Caption = 'Velden koppelen'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object cxgrdMapping: TcxGrid
    Left = 0
    Top = 0
    Width = 355
    Height = 387
    Align = alClient
    TabOrder = 0
    object cxgrdMappingView: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = dsFields
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxgrdMappingViewRecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        PropertiesClassName = 'TcxTextEditProperties'
        Visible = False
      end
      object cxgrdMappingViewFIELDNAME: TcxGridDBColumn
        Caption = 'Veldnaam'
        DataBinding.FieldName = 'FIELDNAME'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ReadOnly = True
        Width = 215
      end
      object cxgrdMappingViewXLS_KOLOM: TcxGridDBColumn
        Caption = 'Kolom XLS'
        DataBinding.FieldName = 'XLS_KOLOM'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Width = 138
      end
    end
    object cxgrdMappingLevel1: TcxGridLevel
      GridView = cxgrdMappingView
    end
  end
  object dsFields: TDataSource
    DataSet = dxmdFields
    Left = 192
    Top = 88
  end
  object dxmdFields: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 192
    Top = 168
    object dxmdFieldsFIELDNAME: TStringField
      FieldName = 'FIELDNAME'
    end
    object dxmdFieldsXLS_KOLOM: TStringField
      FieldName = 'XLS_KOLOM'
      Size = 2
    end
  end
end
