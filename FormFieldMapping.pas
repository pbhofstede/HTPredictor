unit FormFieldMapping;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxmdaset, Db, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TfrmFieldMapping = class(TForm)
    dsFields: TDataSource;
    dxmdFields: TdxMemData;
    dxmdFieldsFIELDNAME: TStringField;
    dxmdFieldsXLS_KOLOM: TStringField;
    cxgrdMappingView: TcxGridDBTableView;
    cxgrdMappingLevel1: TcxGridLevel;
    cxgrdMapping: TcxGrid;
    cxgrdMappingViewRecId: TcxGridDBColumn;
    cxgrdMappingViewFIELDNAME: TcxGridDBColumn;
    cxgrdMappingViewXLS_KOLOM: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FMapDataSet: TdxMemData;
    FIniSection: String;
    procedure SaveToIni;
    procedure SetMapDataSet(const Value: TdxMemData);
    { Private declarations }
  public
    { Public declarations }
    property MapDataSet: TdxMemData read FMapDataSet write SetMapDataSet;
    property IniSection: String read FIniSection write FIniSection;
  end;

implementation

uses
  IniFiles;

{$R *.DFM}

{ TfrmFieldMapping }

procedure TfrmFieldMapping.SetMapDataSet(const Value: TdxMemData);
var
  i:integer;
begin
  FMapDataSet := Value;
  if not dxmdFields.Active then
  begin
    dxmdFields.Open;
  end;
  with TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) do
  begin
    try
      for i:=0 to FMapDataSet.Fields.Count - 1 do
      begin
        if (FMapDataSet.Fields[i].Required) and (Uppercase(FMapDataSet.Fields[i].FieldName) <> 'RECID') then
        begin
          dxmdFields.Append;
          dxmdFields.FieldByName('FIELDNAME').asString := FMapDataSet.Fields[i].FieldName;
          dxmdFields.FieldByName('XLS_KOLOM').asString :=
            ReadString(FIniSection, FMapDataSet.Fields[i].FieldName, '');
          dxmdFields.Post;
        end;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfrmFieldMapping.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveToIni;
end;

procedure TfrmFieldMapping.SaveToIni;
begin
  dxmdFields.DisableControls;
  try
    dxmdFields.First;
    with TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) do
    begin
      try
        while not dxmdFields.Eof do
        begin
          WriteString(FIniSection, dxmdFields.FieldByName('FIELDNAME').asString,
            dxmdFields.FieldByName('XLS_KOLOM').asString);

          dxmdFields.Next;
        end;
      finally
        Free;
      end;
    end;
  finally
    dxmdFields.EnableControls;
  end;
end;

end.
