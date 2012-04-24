object frmRatingBijdrages: TfrmRatingBijdrages
  Left = 480
  Top = 231
  Width = 888
  Height = 502
  Caption = 'Ratingbijdrage per positie'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cxpgctlRatingBijdrages: TcxPageControl
    Left = 0
    Top = 0
    Width = 872
    Height = 464
    ActivePage = cxtbHO
    Align = alClient
    TabOrder = 0
    ClientRectBottom = 464
    ClientRectRight = 872
    ClientRectTop = 24
    object cxtbCustom: TcxTabSheet
      Caption = 'Gebruiker'
      ImageIndex = 1
      object cxGrdUser: TcxGrid
        Left = 0
        Top = 0
        Width = 872
        Height = 440
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView1: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = dsUser
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGridDBColumn1: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            PropertiesClassName = 'TcxTextEditProperties'
            Visible = False
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = 'Positie'
            DataBinding.FieldName = 'POSITIE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Styles.Content = cxStyle1
            Width = 82
          end
          object cxGridDBColumn3: TcxGridDBColumn
            Caption = 'CD-GK'
            DataBinding.FieldName = 'CD_GK'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 72
          end
          object cxGridDBColumn4: TcxGridDBColumn
            Caption = 'CD-DEF'
            DataBinding.FieldName = 'CD_DEF'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 71
          end
          object cxGridDBColumn5: TcxGridDBColumn
            Caption = 'WB-GK'
            DataBinding.FieldName = 'WB_GK'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 71
          end
          object cxGridDBColumn6: TcxGridDBColumn
            Caption = 'WB-DEF'
            DataBinding.FieldName = 'WB_DEF'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 73
          end
          object cxGridDBColumn7: TcxGridDBColumn
            Caption = 'Mid-PM'
            DataBinding.FieldName = 'MID_PM'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 72
          end
          object cxGridDBColumn8: TcxGridDBColumn
            Caption = 'CA-Pass'
            DataBinding.FieldName = 'CA_PASS'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 71
          end
          object cxGridDBColumn9: TcxGridDBColumn
            Caption = 'CA-Sco'
            DataBinding.FieldName = 'CA_SC'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 72
          end
          object cxGridDBColumn10: TcxGridDBColumn
            Caption = 'WA-Pass'
            DataBinding.FieldName = 'WA_PASS'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 71
          end
          object cxGridDBColumn11: TcxGridDBColumn
            Caption = 'WA-Wing'
            DataBinding.FieldName = 'WA_WING'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 72
          end
          object cxGridDBColumn12: TcxGridDBColumn
            Caption = 'WA-Sco'
            DataBinding.FieldName = 'WA_SC'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 72
          end
          object cxGridDBColumn13: TcxGridDBColumn
            Caption = 'WA-Sc (andere vleugel)'
            DataBinding.FieldName = 'WA_SC_OTHER'
            PropertiesClassName = 'TcxTextEditProperties'
            Width = 71
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
    object cxtbHO: TcxTabSheet
      Caption = 'HO!'
      ImageIndex = 2
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 872
        Height = 440
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView2: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = dsHO
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxGridDBColumn14: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            PropertiesClassName = 'TcxTextEditProperties'
            Visible = False
          end
          object cxGridDBColumn15: TcxGridDBColumn
            Caption = 'Positie'
            DataBinding.FieldName = 'POSITIE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Styles.Content = cxStyle1
            Width = 82
          end
          object cxGridDBColumn16: TcxGridDBColumn
            Caption = 'CD-GK'
            DataBinding.FieldName = 'CD_GK'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 72
          end
          object cxGridDBColumn17: TcxGridDBColumn
            Caption = 'CD-DEF'
            DataBinding.FieldName = 'CD_DEF'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 71
          end
          object cxGridDBColumn18: TcxGridDBColumn
            Caption = 'WB-GK'
            DataBinding.FieldName = 'WB_GK'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 71
          end
          object cxGridDBColumn19: TcxGridDBColumn
            Caption = 'WB-DEF'
            DataBinding.FieldName = 'WB_DEF'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 73
          end
          object cxGridDBColumn20: TcxGridDBColumn
            Caption = 'Mid-PM'
            DataBinding.FieldName = 'MID_PM'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 72
          end
          object cxGridDBColumn21: TcxGridDBColumn
            Caption = 'CA-Pass'
            DataBinding.FieldName = 'CA_PASS'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 71
          end
          object cxGridDBColumn22: TcxGridDBColumn
            Caption = 'CA-Sco'
            DataBinding.FieldName = 'CA_SC'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 72
          end
          object cxGridDBColumn23: TcxGridDBColumn
            Caption = 'WA-Pass'
            DataBinding.FieldName = 'WA_PASS'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 71
          end
          object cxGridDBColumn24: TcxGridDBColumn
            Caption = 'WA-Wing'
            DataBinding.FieldName = 'WA_WING'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 72
          end
          object cxGridDBColumn25: TcxGridDBColumn
            Caption = 'WA-Sco'
            DataBinding.FieldName = 'WA_SC'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 72
          end
          object cxGridDBColumn26: TcxGridDBColumn
            Caption = 'WA-Sc (andere vleugel)'
            DataBinding.FieldName = 'WA_SC_OTHER'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 71
          end
        end
        object cxGridLevel2: TcxGridLevel
          GridView = cxGridDBTableView2
        end
      end
    end
    object cxtbFlattermann: TcxTabSheet
      Caption = 'Flattermann'
      ImageIndex = 0
      object cxgrdFlattermann: TcxGrid
        Left = 0
        Top = 0
        Width = 872
        Height = 440
        Align = alClient
        TabOrder = 0
        object cxgrdFlattermannDBTableView1: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = dsFlatterMann
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object cxgrdFlattermannDBTableView1RecId: TcxGridDBColumn
            DataBinding.FieldName = 'RecId'
            PropertiesClassName = 'TcxTextEditProperties'
            Visible = False
          end
          object cxgrdFlattermannDBTableView1POSITIE: TcxGridDBColumn
            Caption = 'Positie'
            DataBinding.FieldName = 'POSITIE'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Styles.Content = cxStyle1
            Width = 82
          end
          object cxgrdFlattermannDBTableView1CD_GK: TcxGridDBColumn
            Caption = 'CD-GK'
            DataBinding.FieldName = 'CD_GK'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 72
          end
          object cxgrdFlattermannDBTableView1CD_DEF: TcxGridDBColumn
            Caption = 'CD-DEF'
            DataBinding.FieldName = 'CD_DEF'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 71
          end
          object cxgrdFlattermannDBTableView1WB_GK: TcxGridDBColumn
            Caption = 'WB-GK'
            DataBinding.FieldName = 'WB_GK'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 71
          end
          object cxgrdFlattermannDBTableView1WB_DEF: TcxGridDBColumn
            Caption = 'WB-DEF'
            DataBinding.FieldName = 'WB_DEF'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 73
          end
          object cxgrdFlattermannDBTableView1MID_PM: TcxGridDBColumn
            Caption = 'Mid-PM'
            DataBinding.FieldName = 'MID_PM'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 72
          end
          object cxgrdFlattermannDBTableView1CA_PASS: TcxGridDBColumn
            Caption = 'CA-Pass'
            DataBinding.FieldName = 'CA_PASS'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 71
          end
          object cxgrdFlattermannDBTableView1CA_SC: TcxGridDBColumn
            Caption = 'CA-Sco'
            DataBinding.FieldName = 'CA_SC'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 72
          end
          object cxgrdFlattermannDBTableView1WA_PASS: TcxGridDBColumn
            Caption = 'WA-Pass'
            DataBinding.FieldName = 'WA_PASS'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 71
          end
          object cxgrdFlattermannDBTableView1WA_WING: TcxGridDBColumn
            Caption = 'WA-Wing'
            DataBinding.FieldName = 'WA_WING'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 72
          end
          object cxgrdFlattermannDBTableView1WA_SC: TcxGridDBColumn
            Caption = 'WA-Sco'
            DataBinding.FieldName = 'WA_SC'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 72
          end
          object cxgrdFlattermannDBTableView1WA_SC_OTHER: TcxGridDBColumn
            Caption = 'WA-Sc (andere vleugel)'
            DataBinding.FieldName = 'WA_SC_OTHER'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            Options.Editing = False
            Width = 71
          end
        end
        object cxgrdFlattermannLevel1: TcxGridLevel
          GridView = cxgrdFlattermannDBTableView1
        end
      end
    end
  end
  object dxmdFlatterMann: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 104
    Top = 160
    object dxmdFlatterMannPOSITIE: TStringField
      FieldName = 'POSITIE'
    end
    object dxmdFlatterMannMID_PM: TFloatField
      FieldName = 'MID_PM'
    end
    object dxmdFlatterMannCD_GK: TFloatField
      FieldName = 'CD_GK'
    end
    object dxmdFlatterMannCD_DEF: TFloatField
      FieldName = 'CD_DEF'
    end
    object dxmdFlatterMannWB_GK: TFloatField
      FieldName = 'WB_GK'
    end
    object dxmdFlatterMannWB_DEF: TFloatField
      FieldName = 'WB_DEF'
    end
    object dxmdFlatterMannCA_PASS: TFloatField
      FieldName = 'CA_PASS'
    end
    object dxmdFlatterMannCA_SC: TFloatField
      FieldName = 'CA_SC'
    end
    object dxmdFlatterMannWA_PASS: TFloatField
      FieldName = 'WA_PASS'
    end
    object dxmdFlatterMannWA_WING: TFloatField
      FieldName = 'WA_WING'
    end
    object dxmdFlatterMannWA_SC: TFloatField
      FieldName = 'WA_SC'
    end
    object dxmdFlatterMannWA_SC_OTHER: TFloatField
      FieldName = 'WA_SC_OTHER'
    end
  end
  object dsFlatterMann: TDataSource
    DataSet = dxmdFlatterMann
    Left = 96
    Top = 88
  end
  object dxmdUser: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 272
    Top = 144
    object StringField1: TStringField
      FieldName = 'POSITIE'
    end
    object FloatField1: TFloatField
      FieldName = 'MID_PM'
    end
    object FloatField2: TFloatField
      FieldName = 'CD_GK'
    end
    object FloatField3: TFloatField
      FieldName = 'CD_DEF'
    end
    object FloatField4: TFloatField
      FieldName = 'WB_GK'
    end
    object FloatField5: TFloatField
      FieldName = 'WB_DEF'
    end
    object FloatField6: TFloatField
      FieldName = 'CA_PASS'
    end
    object FloatField7: TFloatField
      FieldName = 'CA_SC'
    end
    object FloatField8: TFloatField
      FieldName = 'WA_PASS'
    end
    object FloatField9: TFloatField
      FieldName = 'WA_WING'
    end
    object FloatField10: TFloatField
      FieldName = 'WA_SC'
    end
    object FloatField11: TFloatField
      FieldName = 'WA_SC_OTHER'
    end
  end
  object dsUser: TDataSource
    DataSet = dxmdUser
    OnStateChange = dsUserStateChange
    Left = 272
    Top = 88
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clSilver
    end
  end
  object dsHO: TDataSource
    DataSet = dxmdHO
    OnStateChange = dsUserStateChange
    Left = 448
    Top = 88
  end
  object dxmdHO: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 448
    Top = 152
    object StringField2: TStringField
      FieldName = 'POSITIE'
    end
    object FloatField12: TFloatField
      FieldName = 'MID_PM'
    end
    object FloatField13: TFloatField
      FieldName = 'CD_GK'
    end
    object FloatField14: TFloatField
      FieldName = 'CD_DEF'
    end
    object FloatField15: TFloatField
      FieldName = 'WB_GK'
    end
    object FloatField16: TFloatField
      FieldName = 'WB_DEF'
    end
    object FloatField17: TFloatField
      FieldName = 'CA_PASS'
    end
    object FloatField18: TFloatField
      FieldName = 'CA_SC'
    end
    object FloatField19: TFloatField
      FieldName = 'WA_PASS'
    end
    object FloatField20: TFloatField
      FieldName = 'WA_WING'
    end
    object FloatField21: TFloatField
      FieldName = 'WA_SC'
    end
    object FloatField22: TFloatField
      FieldName = 'WA_SC_OTHER'
    end
  end
end
