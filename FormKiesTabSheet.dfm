object frmKiesTabsheet: TfrmKiesTabsheet
  Left = 692
  Top = 302
  BorderStyle = bsToolWindow
  Caption = 'Kies tabsheet'
  ClientHeight = 304
  ClientWidth = 264
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxtrlTabsheets: TcxTreeList
    Left = 0
    Top = 0
    Width = 264
    Height = 304
    Align = alClient
    Bands = <
      item
      end>
    BufferedPaint = False
    OptionsData.CancelOnExit = False
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsView.ColumnAutoWidth = True
    OptionsView.Headers = False
    OptionsView.ShowRoot = False
    TabOrder = 0
    OnDblClick = cxtrlTabsheetsDblClick
    object cxtrlTabsheetscxTreeListColumn1: TcxTreeListColumn
      PropertiesClassName = 'TcxTextEditProperties'
      DataBinding.ValueType = 'String'
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
    end
  end
end
