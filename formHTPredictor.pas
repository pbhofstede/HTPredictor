unit formHTPredictor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxPC, cxControls, dxBar, ImgList, cxClasses, cxGridLevel, uSelectie,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, uRatingBijdrages,
  cxGridDBTableView, cxGrid, Db, dxmdaset, ExtCtrls, StdCtrls, dxCntner,
  Menus, dxEditor, dxExEdtr, dxEdLib, dxDBELib, cxContainer, cxEdit,
  cxTextEdit, cxCurrencyEdit, cxGroupBox, cxRadioGroup, OleCtrls,
  JvComponent, JvUrlListGrabber, JvUrlGrabbers, JvSimpleXml, JvHtmlParser;

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
    pcEigenOpstellingen: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
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
    tsNew: TcxTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure Ratingbijdrages1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ceTegenstanderZelfvertrouwenPropertiesChange(
      Sender: TObject);
    procedure ceTegenstanderTeamgeestPropertiesChange(Sender: TObject);
    procedure ceEigenZelfvertrouwenPropertiesChange(Sender: TObject);
    procedure ceEigenTeamgeestPropertiesChange(Sender: TObject);
    procedure Afsluiten1Click(Sender: TObject);
    procedure rgWedstrijdplaatsPropertiesChange(Sender: TObject);
    procedure pcEigenOpstellingenPageChanging(Sender: TObject;
      NewPage: TcxTabSheet; var AllowChange: Boolean);
  private
    FSelectie_Eigen: TSelectie;
    FSelectie_Tegen: TSelectie;
    FRatingBijdrages: TRatingBijdrages;
    FFormOpstellingTegenstander: TForm;
    FFormOpstellingEigen: TForm;
    FAantalEigenOpstellingen: integer;
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
  FSelectie_Eigen.TegenStander := FSelectie_Tegen;
  FSelectie_Tegen.TegenStander := FSelectie_Eigen;

  
  FFormOpstellingTegenstander :=
    FormOpstelling.ToonOpstelling(pnlOpstellingTegenstander, FSelectie_Tegen, wUit,
    ceTegenstanderZelfvertrouwen.Value, ceTegenstanderTeamgeest.Value, FALSE);

  FFormOpstellingEigen := FormOpstelling.ToonOpstelling(cxTabSheet1, FSelectie_Eigen, wThuis,
    ceEigenZelfvertrouwen.Value, ceEigenTeamgeest.Value, TRUE);
  Inc(FAantalEigenOpstellingen);
end;

procedure TfrmHTPredictor.Ratingbijdrages1Click(Sender: TObject);
begin
  ToonRatingbijdrages;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     20-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.FormDestroy(Sender: TObject);
begin
  if (FRatingBijdrages <> nil) then
  begin
    FRatingBijdrages.SaveToXLS(ExtractFilePath(Application.ExeName)+'ratings.xlsx');
    FRatingBijdrages.Free;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     10-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.ceTegenstanderZelfvertrouwenPropertiesChange(Sender: TObject);
begin
  TfrmOpstelling(FFormOpstellingTegenstander).Zelfvertrouwen := ceTegenstanderZelfvertrouwen.Value;

  lblTegenstanderZVOmschrijving.Caption := uHTPredictor.TeamZelfvertrouwenToString(TTeamZelfvertrouwen(Floor(ceTegenstanderZelfvertrouwen.Value)));
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     10-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.ceTegenstanderTeamgeestPropertiesChange(Sender: TObject);
begin                       
  TfrmOpstelling(FFormOpstellingTegenstander).Teamgeest := ceTegenstanderTeamgeest.Value;

  lblTegenstanderTSOmschrijving.Caption := uHTPredictor.TeamSpiritToString(TTeamSpirit(Floor(ceTegenstanderTeamgeest.Value)));
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     10-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.ceEigenZelfvertrouwenPropertiesChange(Sender: TObject);
begin
  TfrmOpstelling(FFormOpstellingEigen).Zelfvertrouwen := ceEigenZelfvertrouwen.Value;

  lblEigenZVOmschrijving.Caption := uHTPredictor.TeamZelfvertrouwenToString(TTeamZelfvertrouwen(Floor(ceEigenZelfvertrouwen.Value)));
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     10-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.ceEigenTeamgeestPropertiesChange(Sender: TObject);
begin
  TfrmOpstelling(FFormOpstellingEigen).Teamgeest := ceEigenTeamgeest.Value;

  lblEigenTSOmschrijving.Caption := uHTPredictor.TeamSpiritToString(TTeamSpirit(Floor(ceEigenTeamgeest.Value)));
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     10-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.Afsluiten1Click(Sender: TObject);
begin
  Close;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     10-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.rgWedstrijdplaatsPropertiesChange(Sender: TObject);
var
  vWedstrijdPlaatsTegenstander: TWedstrijdPlaats;
begin
  case TWedstrijdPlaats(rgWedstrijdplaats.ItemIndex) of
    wThuis:     vWedstrijdPlaatsTegenstander := wUit;
    wUit:       vWedstrijdPlaatsTegenstander := wThuis;
    wDerbyThuis:vWedstrijdPlaatsTegenstander := wDerbyUit;
    else        vWedstrijdPlaatsTegenstander := wDerbyThuis;
  end;

  if (FFormOpstellingTegenstander <> nil) then
  begin
    TfrmOpstelling(FFormOpstellingTegenstander).WedstrijdPlaats := vWedstrijdPlaatsTegenstander;
  end;

  if (FFormOpstellingEigen <> nil) then
  begin
    TfrmOpstelling(FFormOpstellingEigen).WedstrijdPlaats := TWedstrijdPlaats(rgWedstrijdplaats.ItemIndex);
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     10-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.pcEigenOpstellingenPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
var
  vPage: TcxTabSheet;
begin
  if (NewPage = tsNew) then
  begin
    AllowChange := FALSE;

    vPage := TcxTabSheet.Create(self);
    Inc(FAantalEigenOpstellingen);
    vPage.Caption := Format('Opstelling %d', [FAantalEigenOpstellingen]);
    vPage.PageControl := pcEigenOpstellingen;
    vPage.PageIndex := NewPage.TabIndex;

    FormOpstelling.ToonOpstelling(vPage, FSelectie_Eigen, TWedstrijdPlaats(rgWedstrijdplaats.ItemIndex),
      ceEigenZelfvertrouwen.Value, ceEigenTeamgeest.Value, TRUE);

    pcEigenOpstellingen.ActivePage := vPage;
  end;
end;

end.
