unit FormOpstelling;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uHTPredictor,
  ExtCtrls, uSelectie, uOpstelling, FormOpstellingPlayer, StdCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxImageComboBox;

type
  TfrmOpstelling = class(TForm)
    pnlRatings: TPanel;
    pnlOpstelling: TPanel;
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
    cbMotivatie: TcxImageComboBox;
    cbTactiek: TcxImageComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbMotivatiePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbTactiekPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
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
  aTeamgeest: double): TfrmOpstelling;

implementation
uses
  Math;

{$R *.DFM}


function ToonOpstelling(aParent: TWinControl; aSelectie: TSelectie; aWedstrijdPlaats: TWedstrijdPlaats; aZelfvertrouwen,
  aTeamgeest: double): TfrmOpstelling;
begin
  
  Result := TfrmOpstelling.Create(nil);

  Result.Parent := aParent;
  Result.FWedstrijdPlaats := aWedstrijdPlaats;    
  Result.FZelfvertrouwen := aZelfvertrouwen;
  Result.FTeamgeest := aTeamgeest;
  Result.Selectie := aSelectie;

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
  vMID,
  vRV,
  vCV,
  vLV,
  vRA,
  vCA,
  vLA,
  vTotRating: double;
begin
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

end.
