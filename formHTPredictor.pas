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
    pnlOpstellingTegenstander: TPanel;
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
    rgWedstrijdplaats: TcxRadioGroup;
    gbEigen: TcxGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ceEigenTeamgeest: TcxCurrencyEdit;
    ceEigenZelfvertrouwen: TcxCurrencyEdit;
    lblEigenZVOmschrijving: TLabel;
    lblEigenTSOmschrijving: TLabel;
    gbTegenstander: TcxGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    lblTegenstanderZVOmschrijving: TLabel;
    lblTegenstanderTSOmschrijving: TLabel;
    ceTegenstanderTeamgeest: TcxCurrencyEdit;
    ceTegenstanderZelfvertrouwen: TcxCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure Ratingbijdrages1Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ceTegenstanderZelfvertrouwenPropertiesChange(
      Sender: TObject);
    procedure ceTegenstanderTeamgeestPropertiesChange(Sender: TObject);
    procedure ceEigenZelfvertrouwenPropertiesChange(Sender: TObject);
    procedure ceEigenTeamgeestPropertiesChange(Sender: TObject);
    procedure Afsluiten1Click(Sender: TObject);
  private
    FSelectie_Eigen: TSelectie;
    FSelectie_Tegen: TSelectie;
    FRatingBijdrages: TRatingBijdrages;
    FFormOpstellingTegenstander: TForm;
    FFormOpstellingEigen: TForm;
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
var
  vWedstrijdPlaatsTegenstander: TWedstrijdPlaats;
begin
  btnOk.Visible := FALSE;

  case TWedstrijdPlaats(rgWedstrijdplaats.ItemIndex) of
    wThuis: vWedstrijdPlaatsTegenstander := wUit;
    wUit:   vWedstrijdPlaatsTegenstander := wThuis;
    else    vWedstrijdPlaatsTegenstander := wDerby;
  end;
  
  FFormOpstellingTegenstander :=
    FormOpstelling.ToonOpstelling(pnlOpstellingTegenstander, FSelectie_Tegen, vWedstrijdPlaatsTegenstander,
    ceTegenstanderZelfvertrouwen.Value, ceTegenstanderTeamgeest.Value, FALSE);

  FFormOpstellingEigen := FormOpstelling.ToonOpstelling(cxTabSheet1, FSelectie_Eigen, TWedstrijdPlaats(rgWedstrijdplaats.ItemIndex),
    ceEigenZelfvertrouwen.Value, ceEigenTeamgeest.Value, TRUE);

  pnlTop.Enabled := FALSE;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     20-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.FormDestroy(Sender: TObject);
begin
  FRatingBijdrages.SaveToXLS(ExtractFilePath(Application.ExeName)+'ratings.xlsx');
end;

procedure TfrmHTPredictor.ceTegenstanderZelfvertrouwenPropertiesChange(
  Sender: TObject);
begin
  lblTegenstanderZVOmschrijving.Caption := uHTPredictor.TeamZelfvertrouwenToString(TTeamZelfvertrouwen(Floor(ceTegenstanderZelfvertrouwen.Value)));
end;

procedure TfrmHTPredictor.ceTegenstanderTeamgeestPropertiesChange(
  Sender: TObject);
begin
  lblTegenstanderTSOmschrijving.Caption := uHTPredictor.TeamSpiritToString(TTeamSpirit(Floor(ceTegenstanderTeamgeest.Value)));
end;

procedure TfrmHTPredictor.ceEigenZelfvertrouwenPropertiesChange(
  Sender: TObject);
begin
  lblEigenZVOmschrijving.Caption := uHTPredictor.TeamZelfvertrouwenToString(TTeamZelfvertrouwen(Floor(ceEigenZelfvertrouwen.Value)));
end;

procedure TfrmHTPredictor.ceEigenTeamgeestPropertiesChange(
  Sender: TObject);
begin
  lblEigenTSOmschrijving.Caption := uHTPredictor.TeamSpiritToString(TTeamSpirit(Floor(ceEigenTeamgeest.Value)));
end;

procedure TfrmHTPredictor.Afsluiten1Click(Sender: TObject);
begin
  Close;
end;

end.
