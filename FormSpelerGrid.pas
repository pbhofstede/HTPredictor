unit FormSpelerGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxBar, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  ExtCtrls, Db, dxmdaset;

type
  TfrmSpelerGrid = class(TForm)
    Panel1: TPanel;
    cxGridSpelers: TcxGrid;
    cxGridSpelersView: TcxGridDBTableView;
    cxGridSpelersViewLAND: TcxGridDBColumn;
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
    cxGridSpelersLevel1: TcxGridLevel;
    dxBarDockControl1: TdxBarDockControl;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    btnLoadPlayers: TdxBarButton;
    dsSpelers: TDataSource;
    mdSpelers: TdxMemData;
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
    mdSpelersLAND: TStringField;
    procedure btnLoadPlayersClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MapPlayerFields;
  end;

implementation

uses
  FormHTPredictor, uHTPredictor, FormFieldMapping;

{$R *.DFM}

{-----------------------------------------------------------------------------
  Procedure: btnLoadPlayersClick
  Author:    Harry
  Date:      12-apr-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.btnLoadPlayersClick(Sender: TObject);
var
  vFileName: String;
begin
  if (mdSpelers.Active) then
    mdSpelers.Close;

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
  Date:      12-apr-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.MapPlayerFields;
begin
  with TfrmFieldMapping.Create(nil) do
  begin
    try
      IniSection := 'PLAYER_MAPPING';
      MapDataSet := mdSpelers;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

end.
