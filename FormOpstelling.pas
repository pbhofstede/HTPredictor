unit FormOpstelling;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uHTPredictor,
  ExtCtrls, uSelectie, uOpstelling, FormOpstellingPlayer, StdCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxImageComboBox, cxCurrencyEdit, cxPC, OleCtrls, ComCtrls;

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
    Panel1: TPanel;
    lblTacticLevel: TLabel;
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
  private
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
  if (edMID.Value > 0) then
  begin
    vMID := edMID.Value;
  end
  else
  begin
    vMID := FOpstelling.MID;
  end;
  if (edRV.Value > 0) then
  begin
    vRV := edRV.Value;
  end
  else
  begin
    vRV := FOpstelling.RV;
  end;
  if (edCV.Value > 0) then
  begin
    vCV := edCV.Value;
  end
  else
  begin
    vCV := FOpstelling.CV;
  end;
  if (edLV.Value > 0) then
  begin
    vLV := edLV.Value;
  end
  else
  begin
    vLV := FOpstelling.LV;
  end;
  if (edRA.Value > 0) then
  begin
    vRA := edRA.Value;
  end
  else
  begin
    vRA := FOpstelling.RA;
  end;
  if (edCA.Value > 0) then
  begin
    vCA := edCA.Value;
  end
  else
  begin
    vCA := FOpstelling.CA;
  end;
  if (edLA.Value > 0) then
  begin
    vLA := edLA.Value;
  end
  else
  begin
    vLA := FOpstelling.LA;
  end;

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
  UpdateRatings;
end;

end.
