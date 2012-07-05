unit FormSpelerGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxBar, cxGridLevel, cxGridCustomTableView, cxGridTableView, cxPC,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  ExtCtrls, Db, dxmdaset, uSelectie, uHTPredictor;

type
  TfrmSpelerGrid = class(TFrame)
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
    mdSpelersLOYALITEIT: TFloatField;
    cxGridSpelersViewLOYALITEIT: TcxGridDBColumn;
    btnLaadFromHO: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    btnLoadFree: TdxBarButton;
    procedure mdSpelersAfterPost(DataSet: TDataSet);
    procedure dsSpelersStateChange(Sender: TObject);
    procedure btnOpslaanClick(Sender: TObject);
    procedure btnLoadFreeClick(Sender: TObject);
    procedure btnLaadFromHOClick(Sender: TObject);
  private
    FLoading: boolean;
    FSelectie: TSelectie;
    FTabSheet: TcxTabSheet;
    FOldCaption : String;
    procedure LoadPlayers(aPlayerFileType:TPlayerFileType);
    procedure SetTabSheet(const Value: TcxTabSheet);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MapPlayerFields(aFileType: TPlayerFileType);
    property Selectie: TSelectie read FSelectie write FSelectie;
    property TabSheet: TcxTabSheet read FTabSheet write SetTabSheet;
  end;

implementation

uses
  FormHTPredictor, FormFieldMapping;

{$R *.DFM}

{-----------------------------------------------------------------------------
  Procedure: LoadPlayers
  Author:    Harry
  Date:      11-mei-2012
  Arguments: aPlayerFile: TPlayerFile
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.LoadPlayers(aPlayerFileType: TPlayerFileType);
var
  vFileName, vSheetName: String;
begin
  if (mdSpelers.Active) then
    mdSpelers.Close;

  vFileName := '';

  with TOpenDialog.Create(nil) do
  begin
    try
      case aPlayerFileType of
        pfNTXls: Filter := 'Excel files|*.xls;*.xlsx';
        pfHOCsv: Filter := 'CSV files|*.csv';
      end;
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
    if not (uHTPredictor.AllPlayerFieldsMapped(aPlayerFileType, mdSpelers)) then
    begin
      MapPlayerFields(aPlayerFileType);
    end;

    if (uHTPredictor.AllPlayerFieldsMapped(aPlayerFileType,mdSpelers)) then
    begin
      FLoading := TRUE;
      try
        vSheetName := uHTPredictor.ImportSpelers(aPlayerFileType, vFileName, mdSpelers);
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
procedure TfrmSpelerGrid.MapPlayerFields(aFileType: TPlayerFileType);
begin
  with TfrmFieldMapping.Create(nil) do
  begin
    try
      IniSection := uHTPredictor.GetIniSection(aFileType);
      MapDataSet := mdSpelers;
      ShowModal;
    finally
      Free;
    end;
  end;
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

{-----------------------------------------------------------------------------
  Procedure: btnLoadFreeClick
  Author:    Harry
  Date:      11-mei-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.btnLoadFreeClick(Sender: TObject);
begin
  LoadPlayers(pfNTXls);
end;

{-----------------------------------------------------------------------------
  Procedure: btnLaadFromHOClick
  Author:    Harry
  Date:      11-mei-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmSpelerGrid.btnLaadFromHOClick(Sender: TObject);
begin
  LoadPlayers(pfHOCsv);
end;

constructor TfrmSpelerGrid.Create(AOwner: TComponent);
begin
  inherited;

  Name := '';
  FSelectie := TSelectie.Create;
end;

destructor TfrmSpelerGrid.Destroy;
begin
  FSelectie.Free;
  
  inherited;
end;

end.
