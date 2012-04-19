unit uOpstelling;

interface

uses
  Contnrs, uSelectie, uPlayer, uHTPredictor, Forms;

type
  TOpstelling = class
  private
    FFormOpstelling: TForm;
    FSelectie: TSelectie;
    FOpstellingPlayerArray: array[1..14] of TPlayer;
    FOpstellingOrderArray: array[1..14] of TPlayerOrder;
    FSpelhervatter: TPlayer;
    FAanvoerder: TPlayer;
    procedure SetSelectie(const Value: TSelectie);
    procedure SetAanvoerder(const Value: TPlayer);
    procedure SetSpelhervatter(const Value: TPlayer);
    procedure UpdateRatings;
  public
    property Selectie: TSelectie read FSelectie write SetSelectie;
    property Spelhervatter: TPlayer read FSpelhervatter write SetSpelhervatter;
    property Aanvoerder: TPlayer read FAanvoerder write SetAanvoerder;
    
    constructor Create(aFormOpstelling: TForm);
    destructor Destroy; override;

    function GetPositionOfPlayer(aPlayer: TPlayer): TPlayerPosition;
    procedure ZetPlayerIDOpPositie(aPlayerID: integer; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);
    function AantalPositiesBezet: integer;
    function RV: double;          
    function CV: double;             
    function LV: double;
  end;


implementation
uses
  FormOpstelling, uRatingBijdrage;


{ TOpstelling }
{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.AantalPositiesBezet: integer;
var
  vCount: integer;
begin
  Result := 0;

  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if FOpstellingPlayerArray[vCount] <> nil then
    begin
      Inc(Result);
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
constructor TOpstelling.Create(aFormOpstelling: TForm);
begin
  FFormOpstelling := aFormOpstelling;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.CV: double;
var
  vCount: integer;
begin
  Result := 0;

  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if FOpstellingPlayerArray[vCount] <> nil then
    begin
      Result := Result + FOpstellingPlayerArray[vCount].DEF_C_Bijdrage;
    end;
  end;
end;

destructor TOpstelling.Destroy;
begin
  inherited;

end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.GetPositionOfPlayer(aPlayer: TPlayer): TPlayerPosition;
var
  vCount: integer;
begin
  Result := pOnbekend;
  vCount := Low(FOpstellingPlayerArray);

  while (Result = pOnbekend) and
        (vCount <= High(FOpstellingPlayerArray)) do
  begin
    if (FOpstellingPlayerArray[vCount] = aPlayer) then
    begin
      Result := TPlayerPosition(vCount);
    end;

    Inc(vCount);
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.LV: double;
var
  vCount: integer;
begin
  Result := 0;

  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if FOpstellingPlayerArray[vCount] <> nil then
    begin
      Result := Result + FOpstellingPlayerArray[vCount].DEF_L_Bijdrage;
    end;
  end;
end;

function TOpstelling.RV: double;
var
  vCount: integer;
begin
  Result := 0;

  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if FOpstellingPlayerArray[vCount] <> nil then
    begin
      Result := Result + FOpstellingPlayerArray[vCount].DEF_R_Bijdrage;
    end;
  end;
end;

procedure TOpstelling.SetAanvoerder(const Value: TPlayer);
begin
  if (FAanvoerder <> Value) then
  begin
    FAanvoerder := Value;
    if (FFormOpstelling <> nil) then
    begin
      (FFormOpstelling as TfrmOpstelling).UpdateAanvoerder;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TOpstelling.SetSelectie(const Value: TSelectie);
begin
  FSelectie := Value;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TOpstelling.SetSpelhervatter(const Value: TPlayer);
begin
  if (FSpelhervatter <> Value) then
  begin
    FSpelhervatter := Value;
    if (FFormOpstelling <> nil) then
    begin
      (FFormOpstelling as TfrmOpstelling).UpdateSpelhervatter;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TOpstelling.UpdateRatings;
begin
  TfrmOpstelling(FFormOpstelling).UpdateRatings;
end;

procedure TOpstelling.ZetPlayerIDOpPositie(aPlayerID: integer; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);
var
  vPlayer,
  vOldPlayer: TPlayer;
  vRating: TRatingBijdrage;
  vPos: String;
begin
  vPlayer := Selectie.GetPlayer(aPlayerID);

  vOldPlayer := FOpstellingPlayerArray[Ord(aPositie)];
  FOpstellingPlayerArray[Ord(aPositie)] := vPlayer;
  FOpstellingOrderArray[Ord(aPositie)] := aPlayerOrder;

  if (vOldPlayer <> nil) and
     (vOldPlayer <> vPlayer) then
  begin
    if (vOldPlayer = FSpelhervatter) then
    begin
      Spelhervatter := nil;
    end;

    if (vOldPlayer = FAanvoerder) then
    begin
      Aanvoerder := nil;
    end;
    vOldPlayer.ClearBijdrages;
  end;

  if (FFormOpstelling <> nil) then
  begin
    (FFormOpstelling as TfrmOpstelling).EnableDisableOpstellingPlayer;
  end;

  if (vPlayer <> nil) then
  begin
    vPos := uHTPredictor.PlayerPosToRatingPos(aPositie, aPlayerOrder, vPlayer.Spec);

    vRating := Selectie.RatingBijdrages.GetRatingBijdrageByPositie(vPos);
    if (vRating <> nil) then
    begin
      // Rating berekenen
  //    result :=
  //      (vRating.MID_PM * vPlayer.PM) +
  //      (vRating.CD_GK * vPlayer.GK) +
  //      (vRating.CD_DEF * vPlayer.DEF) +
  //      (vRating.WB_GK * vPlayer.GK) +
  //      (vRating.WB_DEF * vPlayer.DEF) +
  //      (vRating.CA_PASS * vPlayer.PAS) +
  //      (vRating.CA_SC * vPlayer.SCO) +
  //      (vRating.WING_PASS * vPlayer.PAS) +
  //      (vRating.WING_WING * vPlayer.WNG) +
  //      (vRating.WING_SC * vPlayer.SCO) +
  //      (vRating.WING_SC_OTHER * vPlayer.SCO);

      //DEF_R_Bijdrage
      if (aPositie in [pCV, pCM]) then
      begin
        vPlayer.DEF_R_Bijdrage :=
          ((vRating.WB_DEF * vPlayer.DEF / 2) +
           (vRating.WB_GK * vPlayer.GK))
          * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
      end
      else if (aPositie in [pLB, pLCV, pLW, pLCM]) then
      begin
        vPlayer.DEF_R_Bijdrage := 0;
      end
      else
      begin
        vPlayer.DEF_R_Bijdrage := 
          ((vRating.WB_DEF * vPlayer.DEF) +
           (vRating.WB_GK * vPlayer.GK))
          * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
      end;

      //DEF_L_Bijdrage
      if (aPositie in [pCV, pCM]) then
      begin
        vPlayer.DEF_L_Bijdrage :=
          ((vRating.WB_DEF * vPlayer.DEF / 2) +
           (vRating.WB_GK * vPlayer.GK))
          * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
      end
      else if (aPositie in [pRB, pRCV, pRW, pRCM]) then
      begin
        vPlayer.DEF_L_Bijdrage := 0;
      end
      else
      begin
        vPlayer.DEF_L_Bijdrage := 
          ((vRating.WB_DEF * vPlayer.DEF) +
           (vRating.WB_GK * vPlayer.GK))
          * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
      end;

      //DEF_C_Bijdrage
      vPlayer.DEF_C_Bijdrage :=
        ((vRating.CD_DEF * vPlayer.DEF) +
         (vRating.CD_GK * vPlayer.GK))
        * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
    end;
  end;

  UpdateRatings;
end;

end.
