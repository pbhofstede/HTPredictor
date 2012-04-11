unit formHTPredictor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxPC, cxControls, dxBar, ImgList, cxClasses, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Db, dxmdaset;

type
  TfrmHTPredictor = class(TForm)
    cxpgctrlHTPredictor: TcxPageControl;
    cxtbshtPlayers: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    imgListHTPredictor: TImageList;
    dxBarManager1Bar1: TdxBar;
    btnLaadSpelers: TdxBarButton;
    cxGridSpelersView: TcxGridDBTableView;
    cxGridSpelersLevel1: TcxGridLevel;
    cxGridSpelers: TcxGrid;
    mdSpelers: TdxMemData;
    dsSpelers: TDataSource;
    mdSpelersNAAM: TStringField;
    mdSpelersSPECIALITEIT: TStringField;
    mdSpelersVORM: TFloatField;
    mdSpelersCONDITIE: TFloatField;
    mdSpelersKEEPEN: TFloatField;
    mdSpelersVERDEDIGEN: TFloatField;
    mdSpelersPOSITIESPEL: TFloatField;
    mdSpelersVLEUGELSPEL: TFloatField;
    mdSpelersPASSEN: TFloatField;
    mdSpelersSCOREN: TFloatField;
    mdSpelersSPELHERVATTEN: TFloatField;
    mdSpelersERVARING: TFloatField;
    cxGridSpelersViewRecId: TcxGridDBColumn;
    cxGridSpelersViewNAAM: TcxGridDBColumn;
    cxGridSpelersViewSPECIALITEIT: TcxGridDBColumn;
    cxGridSpelersViewVORM: TcxGridDBColumn;
    cxGridSpelersViewCONDITIE: TcxGridDBColumn;
    cxGridSpelersViewKEEPEN: TcxGridDBColumn;
    cxGridSpelersViewVERDEDIGEN: TcxGridDBColumn;
    cxGridSpelersViewPOSITIESPEL: TcxGridDBColumn;
    cxGridSpelersViewVLEUGELSPEL: TcxGridDBColumn;
    cxGridSpelersViewPASSEN: TcxGridDBColumn;
    cxGridSpelersViewSCOREN: TcxGridDBColumn;
    cxGridSpelersViewSPELHERVATTEN: TcxGridDBColumn;
    cxGridSpelersViewERVARING: TcxGridDBColumn;
    mdSpelersLAND: TStringField;
    cxGridSpelersViewLAND: TcxGridDBColumn;
    procedure btnLaadSpelersClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MapPlayerFields;
  end;

var
  frmHTPredictor: TfrmHTPredictor;

implementation

uses
  uHTPredictor, FormFieldMapping;

{$R *.DFM}

procedure TfrmHTPredictor.btnLaadSpelersClick(Sender: TObject);
var
  vFileName: String;
begin
  vFileName := '';

  with TOpenDialog.Create(nil) do
  begin
    try
      Filter := 'Excel files|*.xls;*.xlsx';
      if Execute then
      begin
        vFileName := FileName;
      end;
    finally
      Free;
    end;
  end;

  if (vFileName <> '') then
  begin
    if not (uHTPredictor.AllPlayerFieldsMapped(mdSpelers)) then
    begin
      MapPlayerFields;
    end;

    if (uHTPredictor.AllPlayerFieldsMapped(mdSpelers)) then
    begin
      uHTPredictor.ImportSpelers(vFileName, mdSpelers);
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: MapPlayerFields
  Author:    Harry
  Date:      11-apr-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.MapPlayerFields;
begin
  with TfrmFieldMapping.Create(nil) do
  begin
    try
      IniSection := 'PLAYER_MAPPING';
      MapDataSet := mdSpelers;
      ShowModal;
    finally
      Release;
    end;
  end;
end;

end.
