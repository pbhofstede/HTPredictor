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
    dxmdPredictions: TdxMemData;
    dxmdPredictionsID: TIntegerField;
    dxmdPredictionsOPSTELLING: TStringField;
    dxmdPredictionsTAKTIEK: TStringField;
    dxmdPredictionsLV: TFloatField;
    dxmdPredictionsCV: TFloatField;
    dxmdPredictionsRV: TFloatField;
    dxmdPredictionsMID: TFloatField;
    dxmdPredictionsRA: TFloatField;
    dxmdPredictionsCA: TFloatField;
    dxmdPredictionsLA: TFloatField;
    dxmdPredictionsWINST_THUIS: TFloatField;
    dxmdPredictionsVERLIES_THUIS: TFloatField;
    dxmdPredictionsGELIJK: TFloatField;
    dxmdPredictionsGOALS_THUIS: TFloatField;
    dxmdPredictionsGOALS_UIT: TFloatField;
    dsPredictions: TDataSource;
    cxGrid1DBTableView1RecId: TcxGridDBColumn;
    cxGrid1DBTableView1ID: TcxGridDBColumn;
    cxGrid1DBTableView1OPSTELLING: TcxGridDBColumn;
    cxGrid1DBTableView1TAKTIEK: TcxGridDBColumn;
    cxGrid1DBTableView1LV: TcxGridDBColumn;
    cxGrid1DBTableView1CV: TcxGridDBColumn;
    cxGrid1DBTableView1RV: TcxGridDBColumn;
    cxGrid1DBTableView1MID: TcxGridDBColumn;
    cxGrid1DBTableView1RA: TcxGridDBColumn;
    cxGrid1DBTableView1CA: TcxGridDBColumn;
    cxGrid1DBTableView1LA: TcxGridDBColumn;
    cxGrid1DBTableView1WINST_THUIS: TcxGridDBColumn;
    cxGrid1DBTableView1VERLIES_THUIS: TcxGridDBColumn;
    cxGrid1DBTableView1GELIJK: TcxGridDBColumn;
    cxGrid1DBTableView1GOALS_THUIS: TcxGridDBColumn;
    cxGrid1DBTableView1GOALS_UIT: TcxGridDBColumn;
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
    procedure pcEigenOpstellingenCanClose(Sender: TObject;
      var ACanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    FSelectie_Eigen: TSelectie;
    FSelectie_Tegen: TSelectie;
    FRatingBijdrages: TRatingBijdrages;
    FFrameOpstellingTegenstander: TFrame;
    FFrameOpstellingEigen: TFrame;
    FAantalEigenOpstellingen: integer;
    FGeenNieuwTabAanmaken: Boolean;
    procedure ToonRatingbijdrages;
    procedure NotifyEigenSelectieChanged(Sender: TObject);
    procedure NotifyTegenSelectieChanged(Sender: TObject);
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
  FGeenNieuwTabAanmaken := FALSE;
  dxmdPredictions.Open;
  cxpgctrlHTPredictor.ActivePage := cxtbTegenstander;

  for vCount := Ord(Low(TWedstrijdPlaats)) to Ord(High(TWedstrijdPlaats)) do
  begin
    vItem := rgWedstrijdplaats.Properties.Items.Add;

    vItem.Caption := (uHTPredictor.WedstrijdPlaatsToString(TWedstrijdPlaats(vCount)));
    vItem.Value := vCount;
  end;
  rgWedstrijdplaats.ItemIndex := 0;
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
  FSelectie_Tegen.Zelfvertrouwen := Min(Max(ceTegenstanderZelfvertrouwen.Value, 1), 10);

  lblTegenstanderZVOmschrijving.Caption := uHTPredictor.TeamZelfvertrouwenToString(TTeamZelfvertrouwen(Floor(FSelectie_Tegen.Zelfvertrouwen)));
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     10-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.ceTegenstanderTeamgeestPropertiesChange(Sender: TObject);
begin                       
  FSelectie_Tegen.Teamgeest := Min(Max(ceTegenstanderTeamgeest.Value, 1), 10);

  lblTegenstanderTSOmschrijving.Caption := uHTPredictor.TeamSpiritToString(TTeamSpirit(Floor(FSelectie_Tegen.Teamgeest)));
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     10-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.ceEigenZelfvertrouwenPropertiesChange(Sender: TObject);
begin
  FSelectie_Eigen.Zelfvertrouwen := Min(Max(ceEigenZelfvertrouwen.Value, 1), 10);

  lblEigenZVOmschrijving.Caption := uHTPredictor.TeamZelfvertrouwenToString(TTeamZelfvertrouwen(Floor(FSelectie_Eigen.Zelfvertrouwen)));
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     10-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.ceEigenTeamgeestPropertiesChange(Sender: TObject);
begin
  FSelectie_Eigen.Teamgeest := Min(Max(ceEigenTeamgeest.Value, 1), 10);

  lblEigenTSOmschrijving.Caption := uHTPredictor.TeamSpiritToString(TTeamSpirit(Floor(FSelectie_Eigen.Teamgeest)));
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

  if (FSelectie_Eigen <> nil) then
  begin
    FSelectie_Eigen.WedstrijdPlaats := TWedstrijdPlaats(rgWedstrijdplaats.ItemIndex);
  end;

  if (FSelectie_Tegen <> nil) then
  begin
    FSelectie_Tegen.WedstrijdPlaats := vWedstrijdPlaatsTegenstander;
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
  vHuidigFormOpstelling,
  vNewFormOpstelling: TfrmOpstelling;
begin
  if (NewPage = tsNew) then
  begin
    if (FGeenNieuwTabAanmaken) then
    begin
      FGeenNieuwTabAanmaken := FALSE;

      pcEigenOpstellingen.ActivePage := cxTabSheet1;   
      AllowChange := FALSE;
    end
    else
    begin
      AllowChange := FALSE;

      if (pcEigenOpstellingen.ActivePage <> nil) then
      begin
        vHuidigFormOpstelling := TfrmOpstelling(pcEigenOpstellingen.ActivePage.Controls[0]);
      end
      else
      begin
        vHuidigFormOpstelling := nil;
      end;

      vPage := TcxTabSheet.Create(self);
      Inc(FAantalEigenOpstellingen);
      vPage.Caption := Format('Opstelling %d', [FAantalEigenOpstellingen]);
      vPage.PageControl := pcEigenOpstellingen;
      vPage.PageIndex := tsNew.TabIndex;
      tsNew.PageIndex := tsNew.TabIndex;

      vNewFormOpstelling := FormOpstelling.ToonOpstelling(vPage, FSelectie_Eigen, dxmdPredictions);

      if (vHuidigFormOpstelling <> nil) and
         (vNewFormOpstelling <> nil) then
      begin
        vNewFormOpstelling.NeemGegevensOver(vHuidigFormOpstelling);
      end;

      pcEigenOpstellingen.ActivePage := vPage;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     23-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.pcEigenOpstellingenCanClose(Sender: TObject; var ACanClose: Boolean);
begin
  if pcEigenOpstellingen.ActivePageIndex = pcEigenOpstellingen.PageCount - 2 then
  begin
    FGeenNieuwTabAanmaken := TRUE;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     25-05-2012
  Doel:

  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.NotifyEigenSelectieChanged(Sender: TObject);
var
  vCount: integer;
  vFormOpstelling: TfrmOpstelling;
begin
  for vCount := 0 to pcEigenOpstellingen.PageCount - 2 do
  begin
    vFormOpstelling := TfrmOpstelling(pcEigenOpstellingen.Pages[vCount].Controls[0]);

    if (vFormOpstelling <> nil) then
    begin
      vFormOpstelling.UpdateRatings;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     25-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.NotifyTegenSelectieChanged(Sender: TObject);
begin
  if (FFrameOpstellingTegenstander <> nil) then
  begin
    TfrmOpstelling(FFrameOpstellingTegenstander).UpdateRatings;
  end;
end;

procedure TfrmHTPredictor.FormShow(Sender: TObject);
begin
  FRatingBijdrages := TRatingBijdrages.Create;

  FSelectie_Tegen := ToonSpelersGrids(pnlSpelersGrid1, cxtbTegenstander);
  FSelectie_Tegen.EigenSelectie := FALSE;                             
  FSelectie_Tegen.NotifySelectieChanged := NotifyTegenSelectieChanged;

  FSelectie_Eigen := ToonSpelersGrids(pnlSpelersGrid2, cxtbEigenTeam);
  FSelectie_Eigen.EigenSelectie := TRUE;
  FSelectie_Eigen.NotifySelectieChanged := NotifyEigenSelectieChanged;

  FSelectie_Eigen.RatingBijdrages := FRatingBijdrages;
  FSelectie_Tegen.RatingBijdrages := FRatingBijdrages;

  
  FFrameOpstellingTegenstander := FormOpstelling.ToonOpstelling(pnlOpstellingTegenstander, FSelectie_Tegen, nil);

  FFrameOpstellingEigen := FormOpstelling.ToonOpstelling(cxTabSheet1, FSelectie_Eigen, dxmdPredictions);
  Inc(FAantalEigenOpstellingen);


  FSelectie_Eigen.TegenStander := TfrmOpstelling(FFrameOpstellingTegenstander).Opstelling;
  FSelectie_Tegen.TegenStander := nil;

  rgWedstrijdplaatsPropertiesChange(nil);

  ceTegenstanderZelfvertrouwenPropertiesChange(nil);
  ceTegenstanderTeamgeestPropertiesChange(nil);

  ceEigenZelfvertrouwenPropertiesChange(nil);
  ceEigenTeamgeestPropertiesChange(nil);

end;

end.
