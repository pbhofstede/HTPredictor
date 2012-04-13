unit FormSpelerGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxBar, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxPC,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  ExtCtrls, Db, dxmdaset, uSelectie;

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
    btnOpslaan: TdxBarButton;
    procedure btnLoadPlayersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mdSpelersAfterPost(DataSet: TDataSet);
    procedure dsSpelersStateChange(Sender: TObject);
    procedure btnOpslaanClick(Sender: TObject);
  private
    FLoading: boolean;
    FSelectie: TSelectie;
    FTabSheet: TcxTabSheet;
    FOldCaption : String;
    procedure SetTabSheet(const Value: TcxTabSheet);
    { Private declarations }
  public
    { Public declarations }
    procedure MapPlayerFields;
    property Selectie: TSelectie read FSelectie write FSelectie;
    property TabSheet: TcxTabSheet read FTabSheet write SetTabSheet;
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
  vFileName, vSheetName: String;
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
      FLoading := TRUE;
      try
        vSheetName := uHTPredictor.ImportSpelers(vFileName, mdSpelers);
        FSelectie.Naam := vSheetName;
        FSelectie.LoadFromMemDataSet(mdSpelers, FALSE);
        FTabSheet.Caption := Format('%s (%s)',[FOldCaption, vSheetName]);
        mdSpelers.First;
      finally
        FLoading := FALSE;
      end;
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
      Release;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: FormCreate
  Author:    Harry
  Date:      13-apr-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.FormCreate(Sender: TObject);
begin
  FSelectie := TSelectie.Create;
end;

{-----------------------------------------------------------------------------
  Procedure: FormDestroy
  Author:    Harry
  Date:      13-apr-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.FormDestroy(Sender: TObject);
begin
  FSelectie.Free;
end;

{-----------------------------------------------------------------------------
  Procedure: SetTabSheet
  Author:    Harry
  Date:      13-apr-2012
  Arguments: const Value: TcxTabSheet
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.SetTabSheet(const Value: TcxTabSheet);
begin
  FTabSheet := Value;
  FOldCaption := FTabSheet.Caption;
end;

{-----------------------------------------------------------------------------
  Procedure: mdSpelersAfterPost
  Author:    Harry
  Date:      13-apr-2012
  Arguments: DataSet: TDataSet
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.mdSpelersAfterPost(DataSet: TDataSet);
begin
  if not (FLoading) then
  begin
    FSelectie.LoadFromMemDataSet(TdxMemData(DataSet), TRUE);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: dsSpelersStateChange
  Author:    Harry
  Date:      13-apr-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.dsSpelersStateChange(Sender: TObject);
begin
  btnOpslaan.Enabled := TDataSource(Sender).State <> dsBrowse;
end;

{-----------------------------------------------------------------------------
  Procedure: btnOpslaanClick
  Author:    Harry
  Date:      13-apr-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.btnOpslaanClick(Sender: TObject);
begin
  if (mdSpelers.State in [dsEdit, dsInsert]) then
  begin
    mdSpelers.Post;
  end;
end;

end.
