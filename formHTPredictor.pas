unit formHTPredictor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxPC, cxControls, dxBar, ImgList, cxClasses, cxGridLevel, uSelectie,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, uRatingBijdrages,
  cxGridDBTableView, cxGrid, Db, dxmdaset, ExtCtrls, StdCtrls, dxCntner,
  Menus, dxEditor, dxExEdtr, dxEdLib, dxDBELib, cxContainer, cxEdit,
  cxTextEdit, cxCurrencyEdit, cxGroupBox, cxRadioGroup;

type
  TfrmHTPredictor = class(TForm)
    cxpgctrlHTPredictor: TcxPageControl;
    cxtbTegenstander: TcxTabSheet;
    cxtbEigenTeam: TcxTabSheet;
    dxBarManager1: TdxBarManager;
    imgListHTPredictor: TImageList;
    Panel1: TPanel;
    pnlSpelersGrid1: TPanel;
    Splitter1: TSplitter;
    pnlSpelersGrid2: TPanel;
    Panel4: TPanel;
    Splitter2: TSplitter;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    tbResultaat: TcxTabSheet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    MainMenu1: TMainMenu;
    Bestand1: TMenuItem;
    Afsluiten1: TMenuItem;
    Instellingen1: TMenuItem;
    Ratingbijdrages1: TMenuItem;
    pnlTop: TPanel;
    btnOk: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ceZelfvertrouwen: TcxCurrencyEdit;
    ceTeamgeest: TcxCurrencyEdit;
    lblZVOmschrijving: TLabel;
    lblTSOmschrijving: TLabel;
    rgWedstrijdplaats: TcxRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure Ratingbijdrages1Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure ceZelfvertrouwenPropertiesChange(Sender: TObject);
    procedure ceTeamgeestPropertiesChange(Sender: TObject);
  private
    FSelectie_Eigen: TSelectie;
    FSelectie_Tegen: TSelectie;
    FRatingBijdrages: TRatingBijdrages;
    procedure ToonRatingbijdrages;
    { Private declarations }
  public
    { Public declarations }
    function ToonSpelersGrids(aPanel: TPanel; aTabSheet: TcxTabSheet):TSelectie;
    property RatingBijdrages:TRatingBijdrages read FRatingBijdrages write FRatingBijdrages;
    property Selectie_Eigen: TSelectie read FSelectie_Eigen write FSelectie_Eigen;
    property Selectie_Tegen: TSelectie read FSelectie_Tegen write FSelectie_Tegen;
  end;

var
  frmHTPredictor: TfrmHTPredictor;

implementation

uses
  FormSpelerGrid, uPlayer, FormOpstelling, FormRatingBijdrages, uHTPredictor, Math;

{$R *.DFM}

{-----------------------------------------------------------------------------
  Procedure: ToonSpelersGrids
  Author:    Harry
  Date:      13-apr-2012
  Arguments: aPanel: TPanel
  Result:    TSelectie
-----------------------------------------------------------------------------}
function TfrmHTPredictor.ToonSpelersGrids(aPanel: TPanel; aTabSheet: TcxTabSheet):TSelectie;
begin
  with TfrmSpelerGrid.Create(Self) do
  begin
    Parent := aPanel;
    Visible := TRUE;
    Align := alClient;
    TabSheet := aTabsheet;
    result := Selectie;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: ToonRatingbijdrages
  Author:    Harry
  Date:      19-apr-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.ToonRatingbijdrages;
begin
  if FormRatingBijdrages.ToonRatingbijdrages(FRatingBijdrages) then
  begin
    FSelectie_Eigen.UpdateOpstellingen;
    FSelectie_Tegen.UpdateOpstellingen;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: FormCreate
  Author:    Harry
  Date:      13-apr-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.FormCreate(Sender: TObject);
var
  vCount: integer;
  vItem: TcxRadioGroupItem;
begin
  cxpgctrlHTPredictor.ActivePage := cxtbTegenstander;

  for vCount := Ord(Low(TWedstrijdPlaats)) to Ord(High(TWedstrijdPlaats)) do
  begin
    vItem := rgWedstrijdplaats.Properties.Items.Add;

    vItem.Caption := (uHTPredictor.WedstrijdPlaatsToString(TWedstrijdPlaats(vCount)));
    vItem.Value := vCount;
  end;
  rgWedstrijdplaats.ItemIndex := 0;

  FRatingBijdrages := TRatingBijdrages.Create;

  FSelectie_Tegen := ToonSpelersGrids(pnlSpelersGrid1, cxtbTegenstander);
  FSelectie_Eigen := ToonSpelersGrids(pnlSpelersGrid2, cxtbEigenTeam);
  FSelectie_Eigen.RatingBijdrages := FRatingBijdrages;
  FSelectie_Tegen.RatingBijdrages := FRatingBijdrages;
end;

procedure TfrmHTPredictor.Ratingbijdrages1Click(Sender: TObject);
begin
  ToonRatingbijdrages;
end;

procedure TfrmHTPredictor.btnOkClick(Sender: TObject);
begin
  btnOk.Visible := FALSE;

  FormOpstelling.ToonOpstelling(cxTabSheet1, FSelectie_Eigen, TWedstrijdPlaats(rgWedstrijdplaats.ItemIndex),
    ceZelfvertrouwen.Value, ceTeamgeest.Value);

  pnlTop.Enabled := FALSE;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     20-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.ceZelfvertrouwenPropertiesChange(Sender: TObject);
begin
  lblZVOmschrijving.Caption := uHTPredictor.TeamZelfvertrouwenToString(TTeamZelfvertrouwen(Floor(ceZelfvertrouwen.Value)));
end;

procedure TfrmHTPredictor.ceTeamgeestPropertiesChange(Sender: TObject);
begin
  lblTSOmschrijving.Caption := uHTPredictor.TeamSpiritToString(TTeamSpirit(Floor(ceTeamgeest.Value)));
end;

end.
