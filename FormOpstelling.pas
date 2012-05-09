unit FormOpstelling;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uHTPredictor,
  ExtCtrls, uSelectie, uOpstelling, FormOpstellingPlayer, StdCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxImageComboBox, cxCurrencyEdit, cxPC, OleCtrls, ComCtrls, JvComponent,
  JvUrlListGrabber, JvUrlGrabbers, Buttons, JvSimpleXml;

type
  TfrmOpstelling = class(TForm)
   pnlRatings: TPanel;
    pnlOpstelling: TPanel;
    cxpgctrlRatings: TcxPageControl;
    tbshtRatings: TcxTabSheet;
    tbshtVoorspelling: TcxTabSheet;
    pnlRatingsMain: TPanel;
    lblRV: TLabel;
    lblLinkerVerdediging: TLabel;
    lblLV: TLabel;
    lblRechterVerdediging: TLabel;
    Label1: TLabel;
    lblCV: TLabel;
    lblRA: TLabel;
    lblLinkerAanval: TLabel;
    lblLA: TLabel;
    lblRechterAanval: TLabel;
    lblCentraleAanval: TLabel;
    lblCA: TLabel;
    lblMiddenveld: TLabel;
    lblIM: TLabel;
    lblHatStatsCaption: TLabel;
    lblHatStats: TLabel;
    lblMotivatie: TLabel;
    lblTactiek: TLabel;
    lblCoach: TLabel;
    cbMotivatie: TcxImageComboBox;
    cbTactiek: TcxImageComboBox;
    cbCoach: TcxImageComboBox;
    pnlHandmatig: TPanel;
    edMID: TcxCurrencyEdit;
    edRV: TcxCurrencyEdit;
    edCV: TcxCurrencyEdit;
    edLV: TcxCurrencyEdit;
    edRA: TcxCurrencyEdit;
    edCA: TcxCurrencyEdit;
    edLA: TcxCurrencyEdit;
    lblTacticLevel: TLabel;
    pnlVoorspelling: TPanel;
    spdbtnGetVoorspelling: TSpeedButton;
    lblWinst: TLabel;
    lblGelijk: TLabel;
    lblVerlies: TLabel;
    JvPrediction: TJvHttpUrlGrabber;
    jvXML: TJvSimpleXML;
    lblWinstPerc: TLabel;
    lblGelijkPerc: TLabel;
    lblVerliesPerc: TLabel;
    lblUitslag: TLabel;
    lblTeam1: TLabel;
    lblTeam2: TLabel;
    Label2: TLabel;
    lblBBZ1: TLabel;
    lblBBZ2: TLabel;
    Label3: TLabel;
    lblKansen1: TLabel;
    lblKansen2: TLabel;
    Label4: TLabel;
    lblLinks1: TLabel;
    lblLinks2: TLabel;
    Label5: TLabel;
    lblCentrum1: TLabel;
    lblCentrum2: TLabel;
    Label6: TLabel;
    lblRechts1: TLabel;
    lblRechts2: TLabel;
    Label7: TLabel;
    lblSH1: TLabel;
    lblSH2: TLabel;
    Label8: TLabel;
    lblGoals1: TLabel;
    lblGoals2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label9: TLabel;
    lblWinst1: TLabel;
    lblWinst2: TLabel;
    lblTeamsGelijk: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbMotivatiePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbTactiekPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbCoachPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure edPropertiesChange(Sender: TObject);
    procedure spdbtnGetVoorspellingClick(Sender: TObject);
    procedure JvPredictionDoneStream(Sender: TObject; Stream: TStream;
      StreamSize: Integer; Url: String);
  private
    FTeam1, FTeam2: TOpstelling;
    FBusy: boolean;
    FSelectie: TSelectie;
    FOpstelling: TOpstelling;
    FOpstellingPlayerArray: array[1..14] of TfrmOpstellingPlayer;
    FOpstellingAanvoerder: TfrmOpstellingPlayer;                     
    FOpstellingSpelhervatter: TfrmOpstellingPlayer;
    FWedstrijdPlaats: TWedstrijdPlaats;
    FZelfVertrouwen: double;
    FTeamgeest: double;
    FMID: double;
    FRV: double;
    FCV: double;
    FLV: double;
    FRA: double;
    FCA: double;
    FLA: double;
    procedure SetSelectie(const Value: TSelectie);
    procedure FreeObjecten;
    procedure ShowResults;
    procedure ShowDetailedResults;
    procedure ClearVoorspelling;
    { Private declarations }
  public
    { Public declarations }
    property Selectie: TSelectie read FSelectie write SetSelectie; 

    procedure EnableDisableOpstellingPlayer;
    procedure UpdateAanvoerder;
    procedure UpdateSpelhervatter;

    procedure UpdateRatings;
  end;


function ToonOpstelling(aParent: TWinControl; aSelectie: TSelectie; aWedstrijdPlaats: TWedstrijdPlaats; aZelfvertrouwen,
  aTeamgeest: double; aEigenOpstelling: Boolean): TfrmOpstelling;

implementation
uses
  Math;

{$R *.DFM}


function ToonOpstelling(aParent: TWinControl; aSelectie: TSelectie; aWedstrijdPlaats: TWedstrijdPlaats; aZelfvertrouwen,
  aTeamgeest: double; aEigenOpstelling: Boolean): TfrmOpstelling;
begin
  
  Result := TfrmOpstelling.Create(nil);

  Result.Parent := aParent;
  Result.FWedstrijdPlaats := aWedstrijdPlaats;
  
  Result.FZelfvertrouwen := aZelfvertrouwen;
  if (aTeamgeest < 1) then
  begin
    aTeamgeest := 1;
  end;
  Result.FTeamgeest := aTeamgeest;
  Result.Selectie := aSelectie;
  Result.pnlHandmatig.Visible := not aEigenOpstelling;
  result.tbshtVoorspelling.TabVisible := aEigenOpstelling;
  result.pnlVoorspelling.Visible := aEigenOpstelling;

  aSelectie.CurOpstelling := result.FOpstelling;

  Result.Align := alClient;

  Result.Show;
end;
                                   
{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.EnableDisableOpstellingPlayer;
var
  vDisable: Boolean;
  vCount: integer;
begin
  vDisable := FOpstelling.AantalPositiesBezet = 11;

  if (FOpstelling.AantalPositiesBezet = 10) and
     (FOpstelling.GetPlayerOnPosition(pKP) = nil) then
  begin
    vDisable := TRUE;
  end;
  
  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    //een keeper moet altijd opgesteld kunnen worden
    if TPlayerPosition(vCount) <> pKP then
    begin
      if (FOpstellingPlayerArray[vCount].cbPlayer.EditValue = Null) or
         (FOpstellingPlayerArray[vCount].cbPlayer.EditValue = -1) then
      begin
        FOpstellingPlayerArray[vCount].cbPlayer.Enabled := not vDisable;
        FOpstellingPlayerArray[vCount].cbOrder.Enabled := not vDisable;
      end;
    end;
  end;
end;

procedure TfrmOpstelling.FormCreate(Sender: TObject);
var
  vCount: integer;
  vItem: TcxImageComboBoxItem;
begin
  lblGelijkPerc.Caption := '';
  lblWinstPerc.Caption := '';
  lblVerliesPerc.Caption := '';
  lblUitslag.Caption := '';

  for vCount := Ord(Low(TOpstellingMotivatie)) to Ord(High(TOpstellingMotivatie)) do
  begin
    vItem := cbMotivatie.Properties.Items.Add;
    vItem.Value := vCount;
    vItem.Description := uHTPredictor.OpstellingMotivatieToString(TOpstellingMotivatie(vCount));
  end;

  for vCount := Ord(Low(TOpstellingTactiek)) to Ord(High(TOpstellingTactiek)) do
  begin
    vItem := cbTactiek.Properties.Items.Add;
    vItem.Value := vCount;
    vItem.Description := uHTPredictor.OpstellingTactiekToString(TOpstellingTactiek(vCount));
  end;


  for vCount := Ord(Low(TOpstellingCoach)) to Ord(High(TOpstellingCoach)) do
  begin
    vItem := cbCoach.Properties.Items.Add;
    vItem.Value := vCount;
    vItem.Description := uHTPredictor.OpstellingCoachToString(TOpstellingCoach(vCount));
  end;

  cxpgctrlRatings.ActivePage := tbshtRatings;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.SetSelectie(const Value: TSelectie);
begin
  FreeObjecten;

  FSelectie := Value;

  FOpstelling := TOpstelling.Create(Self, FWedstrijdPlaats, FZelfvertrouwen, FTeamgeest);
  FOpstelling.Selectie := Selectie;

  cbMotivatie.ItemIndex := Ord(mNormaal);
  cbTactiek.ItemIndex := Ord(tNormaal);
  cbCoach.ItemIndex := Ord(cNeutraal);

  FOpstellingPlayerArray[1] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pKP);
  FOpstellingPlayerArray[2] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pRB);
  FOpstellingPlayerArray[3] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pRCV);
  FOpstellingPlayerArray[4] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pCV);
  FOpstellingPlayerArray[5] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pLCV);
  FOpstellingPlayerArray[6] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pLB);
  FOpstellingPlayerArray[7] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pRW);
  FOpstellingPlayerArray[8] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pRCM);
  FOpstellingPlayerArray[9] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pCM);
  FOpstellingPlayerArray[10] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pLCM);
  FOpstellingPlayerArray[11] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pLW);
  FOpstellingPlayerArray[12] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pRCA);
  FOpstellingPlayerArray[13] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pCA);
  FOpstellingPlayerArray[14] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pLCA);


  FOpstellingAanvoerder := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, TRUE);
  FOpstellingSpelhervatter := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, FALSE);

  pnlVoorspelling.Top := FOpstellingAanvoerder.Top;
  pnlVoorspelling.Left := FOpstellingPlayerArray[5].Left;
  pnlVoorspelling.Height := FOpstellingAanvoerder.Height;
  pnlVoorspelling.Width := (FOpstellingPlayerArray[6].Left + FOpstellingPlayerArray[6].Width) -
             FOpstellingPlayerArray[5].Left;

  case FWedstrijdPlaats of
    wThuis, wDerbyThuis:
    begin
      FTeam1 := FOpstelling;
      FTeam2 := TOpstelling(FOpstelling.Selectie.TegenStander.CurOpstelling);
    end
    else
    begin
      FTeam1 := TOpstelling(FOpstelling.Selectie.TegenStander.CurOpstelling);
      FTeam2 := FOpstelling;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.FormDestroy(Sender: TObject);
begin
  FreeObjecten;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.UpdateAanvoerder;
begin
  if (FOpstellingAanvoerder <> nil) then
  begin
    if (FOpstelling.Aanvoerder = nil) then
    begin
      FOpstellingAanvoerder.cbPlayer.ItemIndex := -1;
    end
    else
    begin
      if (FOpstellingAanvoerder.cbPlayer.ItemIndex <> FOpstelling.Aanvoerder.ID) then
      begin
        FOpstellingAanvoerder.cbPlayer.ItemIndex := FOpstelling.Aanvoerder.ID;
      end;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.UpdateSpelhervatter;
begin
  if (FOpstellingSpelhervatter <> nil) then
  begin
    if (FOpstelling.Spelhervatter = nil) then
    begin
      FOpstellingSpelhervatter.cbPlayer.ItemIndex := -1;
    end
    else
    begin
      if FOpstellingSpelhervatter.cbPlayer.ItemIndex <> FOpstelling.Spelhervatter.ID then
      begin
        FOpstellingSpelhervatter.cbPlayer.ItemIndex := FOpstelling.Spelhervatter.ID;
      end;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.FreeObjecten;
var
  vCount: integer;
begin
  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if (FOpstellingPlayerArray[vCount] <> nil) then
    begin
      FOpstellingPlayerArray[vCount].Close;
      FOpstellingPlayerArray[vCount].Release;
      FOpstellingPlayerArray[vCount] := nil;
    end;
  end;

  if (FOpstellingAanvoerder <> nil) then
  begin
    FOpstellingAanvoerder.Close;
    FOpstellingAanvoerder.Release;
    FOpstellingAanvoerder := nil;
  end;

  if (FOpstellingSpelhervatter <> nil) then
  begin
    FOpstellingSpelhervatter.Close;
    FOpstellingSpelhervatter.Release;
    FOpstellingSpelhervatter := nil;
  end;

  if (FOpstelling <> nil) then
  begin
    FOpstelling.Free;
    FOpstelling := nil;
  end;
end;

procedure TfrmOpstelling.UpdateRatings;
var
  vTacticLevel,
  vMID,
  vRV,
  vCV,
  vLV,
  vRA,
  vCA,
  vLA,
  vTotRating: double;
begin
  ClearVoorspelling;

  vMID := FOpstelling.MID;
  vRV := FOpstelling.RV;
  vCV := FOpstelling.CV;
  vLV := FOpstelling.LV;
  vRA := FOpstelling.RA;
  vCA := FOpstelling.CA;
  vLA := FOpstelling.LA;

  lblIM.Caption := uHTPredictor.FormatRating(vMID, FMid);
  lblRV.Caption := uHTPredictor.FormatRating(vRV, FRV);
  lblCV.Caption := uHTPredictor.FormatRating(vCV, FCV);
  lblLV.Caption := uHTPredictor.FormatRating(vLV, FLV);
  lblRA.Caption := uHTPredictor.FormatRating(vRA, FRA);
  lblCA.Caption := uHTPredictor.FormatRating(vCA, FCA);
  lblLA.Caption := uHTPredictor.FormatRating(vLA, FLA);

  vTacticLevel := FOpstelling.TacticLevel;
  lblTacticLevel.Caption := uHTPredictor.FormatRating(vTacticLevel, vTacticLevel, TRUE);

  vTotRating := (vMID * 3)
                  + vRV
                  + vCV
                  + vLV
                  + vRA
                  + vCA
                  + vLA;

  vTotRating := 9 + (4 * (vTotRating - 9));
  lblHatStats.Caption := Format('%d', [Ceil(vTotRating)]);
  FMid := vMID;
  FRV := vRV;
  FCV := vCV;
  FLV := vLV;
  FRA := vRA;
  FCA := vCA;
  FLA := vLA;
end;

procedure TfrmOpstelling.cbMotivatiePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if (FOpstelling <> nil) then
  begin
    FOpstelling.Motivatie := TOpstellingMotivatie(cbMotivatie.EditValue);
  end;
end;

procedure TfrmOpstelling.cbTactiekPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if (FOpstelling <> nil) then
  begin
    FOpstelling.Tactiek := TOpstellingTactiek(cbTactiek.EditValue);
  end;
end;

procedure TfrmOpstelling.cbCoachPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if (FOpstelling <> nil) then
  begin
    FOpstelling.Coach := TOpstellingCoach(cbCoach.EditValue);
  end;
end;

procedure TfrmOpstelling.edPropertiesChange(Sender: TObject);
begin
  FOpstelling.HandmatigMID := edMID.Value;
  FOpstelling.HandmatigRV := edRV.Value;
  FOpstelling.HandmatigCV := edCV.Value;
  FOpstelling.HandmatigLV := edLV.Value;
  FOpstelling.HandmatigRA := edRA.Value;
  FOpstelling.HandmatigCA := edCA.Value;
  FOpstelling.HandmatigLA := edLA.Value;
  
  UpdateRatings;
end;

{-----------------------------------------------------------------------------
  Procedure: spdbtnGetVoorspellingClick
  Author:    Harry
  Date:      08-mei-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.spdbtnGetVoorspellingClick(Sender: TObject);
var
  vURL, vTaktiek: String;
  vSeperator: Char;
begin
  if (JvPrediction.Status = gsStopped) and not(FBusy) then
  begin
    FBusy := TRUE;

    vSeperator := DecimalSeparator;
    DecimalSeparator := '.';
    try
      vURL := 'http://www.fantamondi.it/HTMS/dorequest.php?action=predict&'+
        Format('TAM=%.2f&',[FTeam1.MID * 4])+
        Format('TBM=%.2f&',[FTeam2.MID * 4])+
        Format('TARD=%.2f&',[FTeam1.RV * 4])+
        Format('TBRD=%.2f&',[FTeam2.RV * 4])+
        Format('TACD=%.2f&',[FTeam1.CV * 4])+
        Format('TBCD=%.2f&',[FTeam2.CV * 4])+
        Format('TALD=%.2f&',[FTeam1.LV * 4])+
        Format('TBLD=%.2f&',[FTeam2.LV * 4])+
        Format('TARA=%.2f&',[FTeam1.RA * 4])+
        Format('TBRA=%.2f&',[FTeam2.RA * 4])+
        Format('TACA=%.2f&',[FTeam1.CA * 4])+
        Format('TBCA=%.2f&',[FTeam2.CA * 4])+
        Format('TALA=%.2f&',[FTeam1.LA * 4])+
        Format('TBLA=%.2f',[FTeam2.LA * 4]);

      case FTeam1.Tactiek of
        tPressie: vTaktiek := Format('&TATAC=PRES&TATACLEV=%.0f',[FTeam1.TacticLevel]);
        tCounter: vTaktiek := Format('&TATAC=CA&TATACLEV=%.0f',[FTeam1.TacticLevel]);
        tCentrumAanval: vTaktiek := Format('&TATAC=AIM&TATACLEV=%.0f',[FTeam1.TacticLevel]);
        tVleugelAanval: vTaktiek := Format('&TATAC=AOW&TATACLEV=%.0f',[FTeam1.TacticLevel]);
        tCreatiefSpel, tAfstandsSchoten: vTaktiek := '';
      end;
      if (vTaktiek <> '') then
      begin
        vURL := Format('%s%s',[vUrl, vTaktiek]);
      end;

      case FTeam2.Tactiek of
        tPressie: vTaktiek := Format('&TBTAC=PRES&TBTACLEV=%.0f',[FTeam2.TacticLevel]);
        tCounter: vTaktiek := Format('&TBTAC=CA&TBTACLEV=%.0f',[FTeam2.TacticLevel]);
        tCentrumAanval: vTaktiek := Format('&TBTAC=AIM&TBTACLEV=%.0f',[FTeam2.TacticLevel]);
        tVleugelAanval: vTaktiek := Format('&TBTAC=AOW&TBTACLEV=%.0f',[FTeam2.TacticLevel]);
        tCreatiefSpel, tAfstandsSchoten: vTaktiek := '';
      end;
      if (vTaktiek <> '') then
      begin
        vURL := Format('%s%s',[vUrl, vTaktiek]);
      end;
    finally
      DecimalSeparator := vSeperator;
    end;
    JvPrediction.Url := vURL;
    Screen.Cursor := crHourGlass;
    JvPrediction.Start;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: JvPredictionDoneStream
  Author:    Harry
  Date:      08-mei-2012
  Arguments: Sender: TObject; Stream: TStream; StreamSize: Integer; Url: String
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.JvPredictionDoneStream(Sender: TObject;
  Stream: TStream; StreamSize: Integer; Url: String);
begin
  Screen.Cursor := crDefault;
  jvXML.LoadFromStream(Stream);
  ShowResults;
  ShowDetailedResults;
  FBusy := FALSE;
end;

{-----------------------------------------------------------------------------
  Procedure: ClearVoorspelling
  Author:    Harry
  Date:      09-mei-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.ClearVoorspelling;
begin
  lblGelijkPerc.Caption := '?';
  lblWinstPerc.Caption := '?';
  lblVerliesPerc.Caption := '?';
  lblUitslag.Caption := '';
  lblBBZ1.Caption := '?';
  lblBBZ2.Caption := '?';
  lblKansen1.Caption := '?';
  lblKansen2.Caption := '?';
  lblLinks1.Caption := '?';
  lblLinks2.Caption := '?';
  lblCentrum1.Caption := '?';
  lblCentrum2.Caption := '?';
  lblRechts1.Caption := '?';
  lblRechts2.Caption := '?';
  lblSH1.Caption := '?';
  lblSH2.Caption := '?';
  lblGoals1.Caption := '?';
  lblGoals2.Caption := '?';
  lblTeamsGelijk.Caption := '?';
  lblWinst1.Caption := '?';
  lblWinst2.Caption := '?'; 
end;

{-----------------------------------------------------------------------------
  Procedure: ShowResults
  Author:    Harry
  Date:      08-mei-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.ShowResults;
begin
  case FWedstrijdPlaats of
    wThuis, wDerbyThuis:
    begin
      lblWinstPerc.Caption := Format('%s %%',[jvXML.Root.Items.Value('S1P')]);
      lblVerliesPerc.Caption := Format('%s %%',[jvXML.Root.Items.Value('S2P')]);
    end
    else
    begin
      lblWinstPerc.Caption := Format('%s %%',[jvXML.Root.Items.Value('S2P')]);
      lblVerliesPerc.Caption := Format('%s %%',[jvXML.Root.Items.Value('S1P')]);
    end;
  end;
  lblGelijkPerc.Caption := Format('%s %%',[jvXML.Root.Items.Value('SXP')]);
  lblUitslag.Caption := Format('%s - %s',[jvXML.Root.Items.Value('T1'), jvXML.Root.Items.Value('T2')]);
end;

procedure TfrmOpstelling.ShowDetailedResults;
var
  vGoals1, vGoals2: double;
  vSeperator: Char;
begin
  vSeperator := DecimalSeparator;
  DecimalSeparator := '.';
  try
    if (FTeam1.Selectie <> nil) then
    begin
      lblTeam1.Caption := FTeam1.Selectie.Naam;
    end
    else
    begin
      lblTeam1.Caption := '?';
    end;
      
    if (FTeam2.Selectie <> nil) then
    begin
      lblTeam2.Caption := FTeam2.Selectie.Naam;
    end
    else
    begin
      lblTeam2.Caption := '?';
    end;

    vGoals1 := StrToFloat(jvXML.Root.Items.Value('T1'));
    vGoals2 := StrToFloat(jvXML.Root.Items.Value('T2'));
    lblUitslag.Caption := Format('%.0f - %.0f',[vGoals1, vGoals2]);
    lblBBZ1.Caption := Format('%s',[jvXML.Root.Items.Value('P1')]);
    lblBBZ2.Caption := Format('%s',[jvXML.Root.Items.Value('P2')]);
    lblKansen1.Caption := Format('%s',[jvXML.Root.Items.Value('A1')]);
    lblKansen2.Caption := Format('%s',[jvXML.Root.Items.Value('A2')]);
    lblLinks1.Caption := Format('%s',[jvXML.Root.Items.Value('C1L')]);
    lblLinks2.Caption := Format('%s',[jvXML.Root.Items.Value('C2L')]);
    lblCentrum1.Caption := Format('%s',[jvXML.Root.Items.Value('C1C')]);
    lblCentrum2.Caption := Format('%s',[jvXML.Root.Items.Value('C2C')]);
    lblRechts1.Caption := Format('%s',[jvXML.Root.Items.Value('C1R')]);
    lblRechts2.Caption := Format('%s',[jvXML.Root.Items.Value('C2R')]);
    lblSH1.Caption := Format('%s',[jvXML.Root.Items.Value('CP1')]);
    lblSH2.Caption := Format('%s',[jvXML.Root.Items.Value('CP2')]);
    lblGoals1.Caption := Format('%s',[jvXML.Root.Items.Value('T1')]);
    lblGoals2.Caption := Format('%s',[jvXML.Root.Items.Value('T2')]);
    lblTeamsGelijk.Caption := Format('%s%%',[jvXML.Root.Items.Value('SXP')]);
    lblWinst1.Caption := Format('%s%%',[jvXML.Root.Items.Value('S1P')]);
    lblWinst2.Caption := Format('%s%%',[jvXML.Root.Items.Value('S2P')]);
  finally
    DecimalSeparator := vSeperator;
  end;
end;

end.
