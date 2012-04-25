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
    FZelfvertrouwen: double;
    FMotivatie: TOpstellingMotivatie;
    FTactiek: TOpstellingTactiek;
    FCoach: TOpstellingCoach;
    FWedstrijdPlaats: TWedstrijdPlaats;
    FTS: double;
    procedure SetSelectie(const Value: TSelectie);
    procedure SetAanvoerder(const Value: TPlayer);
    procedure SetSpelhervatter(const Value: TPlayer);
    procedure UpdateRatings;
    procedure SetZelfvertrouwen(const Value: double);
    procedure SetMotivatie(const Value: TOpstellingMotivatie);
    procedure SetTactiek(const Value: TOpstellingTactiek);
    procedure SetCoach(const Value: TOpstellingCoach);
    function VerrekenTypeCoach(aRating: double; aVerdediging: boolean): double;
    procedure SetWedstrijdPlaats(const Value: TWedstrijdPlaats);
    procedure SetTS(const Value: double);
    function VerwerkTS(aRating: double): double;
    function OverCrowdingDef(aAantal: integer): double;
    function OverCrowdingMid(aAantal: integer): double;
    function OverCrowdingAan(aAantal: integer): double;
  public
    property Selectie: TSelectie read FSelectie write SetSelectie;
    property Spelhervatter: TPlayer read FSpelhervatter write SetSpelhervatter;
    property Aanvoerder: TPlayer read FAanvoerder write SetAanvoerder;
    property Zelfvertrouwen: double read FZelfvertrouwen write SetZelfvertrouwen;
    property WedstrijdPlaats: TWedstrijdPlaats read FWedstrijdPlaats write SetWedstrijdPlaats;
    property Motivatie: TOpstellingMotivatie read FMotivatie write SetMotivatie;
    property Tactiek: TOpstellingTactiek read FTactiek write SetTactiek;
    property Coach: TOpstellingCoach read FCoach write SetCoach;
    property TS: double read FTS write SetTS;
    
    constructor Create(aFormOpstelling: TForm; aWedstrijdPlaats: TWedstrijdPlaats; aZelfvertrouwen, aTS: double);
    destructor Destroy; override;

    function GetPlayerOnPosition(aPositie: TPlayerPosition): TPlayer;
    function GetPositionOfPlayer(aPlayer: TPlayer): TPlayerPosition;
    procedure ZetPlayerIDOpPositie(aPlayerID: integer; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);
    function AantalPositiesBezet: integer;
    function RV: double;          
    function CV: double;             
    function LV: double;  
    function RA: double;
    function CA: double;
    function LA: double;    
    function MID: double;
    function TeamZelfvertrouwen: double;
  end;


implementation
uses
  FormOpstelling, uRatingBijdrage, Math;


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
function TOpstelling.CA: double;
var
  vCount,
  vCentraalCount: integer;
  vPlayer: TPlayer;
begin
  Result := 0;

  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    vPlayer := FOpstellingPlayerArray[vCount];
    if vPlayer <> nil then
    begin
      //verminderde centrale bijdrage van de aanvallers
      if (vCount in [Ord(pRCA), Ord(pCA), Ord(pLCA)]) then
      begin
        vCentraalCount := 0;

        if (FOpstellingPlayerArray[Ord(pRCA)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pCA)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pLCA)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;

        Result := Result + (vPlayer.AANV_C_Bijdrage * OverCrowdingAan(vCentraalCount));
      end
      else if (vCount in [Ord(pRCM), Ord(pCM), Ord(pLCM)]) then
      begin
        //verminderde centrale aanval bijdrage van de mids
        vCentraalCount := 0;

        if (FOpstellingPlayerArray[Ord(pRCM)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pCM)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pLCM)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;

        Result := Result + (vPlayer.AANV_C_Bijdrage * OverCrowdingMid(vCentraalCount));
      end
      else
      begin
        Result := Result + vPlayer.AANV_C_Bijdrage;
      end;
    end;
  end;
  
  Result := Result * TeamZelfvertrouwen;

  Result := VerrekenTypeCoach(Result, FALSE);
end;

constructor TOpstelling.Create(aFormOpstelling: TForm; aWedstrijdPlaats: TWedstrijdPlaats; aZelfvertrouwen, aTS: double);
begin
  FFormOpstelling := aFormOpstelling;
  FMotivatie := mNormaal;
  FTactiek := tNormaal;
  FZelfvertrouwen := aZelfvertrouwen;
  FWedstrijdPlaats := aWedstrijdPlaats;
  FCoach := cNeutraal;
  FTS := aTS;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.CV: double;
var
  vCount,
  vCentraalCount: integer;
begin
  Result := 0;

  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if FOpstellingPlayerArray[vCount] <> nil then
    begin
      //verminderde centrale verdediging bijdrage van de verdedigers
      if (vCount in [Ord(pRCV), Ord(pCV), Ord(pLCV)]) then
      begin
        vCentraalCount := 0;

        if (FOpstellingPlayerArray[Ord(pRCV)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pCV)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pLCV)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;

        Result := Result + (FOpstellingPlayerArray[vCount].DEF_C_Bijdrage * OverCrowdingDef(vCentraalCount));
      end
      else if (vCount in [Ord(pRCM), Ord(pCM), Ord(pLCM)]) then
      begin
        //verminderde centrale verdediging bijdrage van de mids
        vCentraalCount := 0;

        if (FOpstellingPlayerArray[Ord(pRCM)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pCM)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pLCM)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        
        Result := Result + (FOpstellingPlayerArray[vCount].DEF_C_Bijdrage * OverCrowdingMid(vCentraalCount));
      end
      else
      begin
        Result := Result + FOpstellingPlayerArray[vCount].DEF_C_Bijdrage;
      end;
    end;
  end;

  Result := VerrekenTypeCoach(Result, TRUE);
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
function TOpstelling.GetPlayerOnPosition(aPositie: TPlayerPosition): TPlayer;
begin
  Result := FOpstellingPlayerArray[Ord(aPositie)];
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     25-04-2012
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
function TOpstelling.LA: double;
var
  vCount: integer;
begin
  Result := 0;

  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if FOpstellingPlayerArray[vCount] <> nil then
    begin
      Result := Result + FOpstellingPlayerArray[vCount].AANV_L_Bijdrage;
    end;
  end;

  Result := Result * TeamZelfvertrouwen;
  
  Result := VerrekenTypeCoach(Result, FALSE);
end;

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

  Result := VerrekenTypeCoach(Result, TRUE);
end;

function TOpstelling.MID: double;
var
  vCount,
  vCentraalCount: integer;
begin
  Result := 0;

  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if FOpstellingPlayerArray[vCount] <> nil then
    begin     
      //verminderde middenveld bijdrage van de mids
      if (vCount in [Ord(pRCM), Ord(pCM), Ord(pLCM)]) then
      begin
        vCentraalCount := 0;

        if (FOpstellingPlayerArray[Ord(pRCM)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pCM)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pLCM)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;

        Result := Result + (FOpstellingPlayerArray[vCount].MID_Bijdrage * OverCrowdingMid(vCentraalCount));
      end
      else if (vCount in [Ord(pRCV), Ord(pCV), Ord(pLCV)]) then
      begin
        //verminderde middenveld bijdrage van de verdedigers
        vCentraalCount := 0;

        if (FOpstellingPlayerArray[Ord(pRCV)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pCV)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pLCV)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;

        Result := Result + (FOpstellingPlayerArray[vCount].MID_Bijdrage * OverCrowdingDef(vCentraalCount));
      end
      else if (vCount in [Ord(pRCA), Ord(pCA), Ord(pLCA)]) then
      begin
        //verminderde middenveldbijdrage van de aanvallers
        vCentraalCount := 0;

        if (FOpstellingPlayerArray[Ord(pRCA)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pCA)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;
        if (FOpstellingPlayerArray[Ord(pLCA)] <> nil) then
        begin
          Inc(vCentraalCount);
        end;

        Result := Result + (FOpstellingPlayerArray[vCount].MID_Bijdrage * OverCrowdingAan(vCentraalCount));
      end
      else
      begin
        Result := Result + FOpstellingPlayerArray[vCount].MID_Bijdrage;
      end;
    end;
  end;

  Result := VerwerkTS(Result);

  case WedstrijdPlaats of
    wThuis: Result := Result * 1.199529;    //MMM + HO: 1.199529
    wDerby: Result := Result * 1.113699;    //MMM + HO: 1.113699
    wUit:   Result := Result * 1;
  end;

  case Motivatie of
    mPIC:     Result := Result * 0.839949;   //MMM + HO: 0.839949
    mMOTS:    Result := Result * 1.109650;   //MMM + HO: 1.109650
    mNormaal: Result := Result * 1;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     24-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.OverCrowdingAan(aAantal: integer): double;
begin
  case aAantal of
    2:    Result := 0.9480;  //0.9480 = HO 0.94 = MMM
    3:    Result := 0.8190;  //0.8190 = HO 0.865 = MMM
    else  Result := 1;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     24-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.OverCrowdingDef(aAantal: integer): double;
begin
  case aAantal of
    2:    Result := 0.9647;     //0.9647 = HO 0.96 = MMM
    3:    Result := 0.8731;     //0.8731 = HO 0.91 = MMM
    else  Result := 1;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     24-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.OverCrowdingMid(aAantal: integer): double;
begin
  case aAantal of
    2:    Result := 0.9356;     //0.9356 = HO 0.92=MMM
    3:    Result := 0.8268;     //0.8268 = HO 0.82=MMM
    else  Result := 1;
  end;
end;

function TOpstelling.RA: double;
var
  vCount: integer;
begin
  Result := 0;

  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if FOpstellingPlayerArray[vCount] <> nil then
    begin
      Result := Result + FOpstellingPlayerArray[vCount].AANV_R_Bijdrage;
    end;
  end;

  Result := Result * TeamZelfvertrouwen;

  Result := VerrekenTypeCoach(Result, FALSE);
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

  Result := VerrekenTypeCoach(Result, TRUE);
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
procedure TOpstelling.SetCoach(const Value: TOpstellingCoach);
begin
  if (FCoach <> Value) then
  begin
    FCoach := Value;
    UpdateRatings;
  end;
end;

procedure TOpstelling.SetMotivatie(const Value: TOpstellingMotivatie);
begin
  if (FMotivatie <> Value) then
  begin
    FMotivatie := Value;
    UpdateRatings;
  end;
end;

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
procedure TOpstelling.SetTactiek(const Value: TOpstellingTactiek);
begin
  if (FTactiek <> Value) then
  begin
    FTactiek := Value;
    UpdateRatings;
  end;
end;

procedure TOpstelling.SetTS(const Value: double);
begin
  if (FTS <> Value) then
  begin
    FTS := Value;
    UpdateRatings;
  end;
end;

procedure TOpstelling.SetWedstrijdPlaats(const Value: TWedstrijdPlaats);
begin
  if (FWedstrijdPlaats <> Value) then
  begin
    FWedstrijdPlaats := Value;
    UpdateRatings;
  end;
end;

procedure TOpstelling.SetZelfvertrouwen(const Value: double);
begin
  if (FZelfvertrouwen <> Value) then
  begin
    FZelfvertrouwen := Value;
    UpdateRatings;
  end;
end;

function TOpstelling.TeamZelfvertrouwen: double;
begin
  Result := 1 + (FZelfvertrouwen * 0.0525);
end;

procedure TOpstelling.UpdateRatings;
begin
  if (FFormOpstelling <> nil) then
  begin
    TfrmOpstelling(FFormOpstelling).UpdateRatings;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     19-04-2012
  Doel:

  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.VerrekenTypeCoach(aRating: double; aVerdediging: boolean): double;
begin
  Result := aRating;

  if aVerdediging then
  begin
    case Coach of
      //cVerdedigend: Result := aRating * ((2 * 1.197332) + 1.196307) / 3;    //MMM: 1,196990333
      cVerdedigend: Result := aRating * 1.196307; //HO
      cNeutraal:    Result := aRating * 1.05;
      //cAanvallend:  Result := aRating * 0.94;   //MMM
      cAanvallend: Result := aRating * 0.928162;  //HO
    end;
  end
  else
  begin
    case Coach of
      //cVerdedigend: Result := aRating * 0.928;  //MMM: 0.928
      cVerdedigend: Result := aRating * 0.927930; //HO
      cNeutraal:    Result := aRating * 1.05;
      //cAanvallend:  Result := aRating * ((2 * 1.133359) + 1.135257) / 3;    //MMM: 1,133991667
      cAanvallend:  Result := aRating *  1.135257
    end;
  end;
end;

function TOpstelling.VerwerkTS(aRating: double): double;
begin
  //Result := aRating * Power((FTS - 0.5) * 0.2, 0.417779);     //MMM
  //Result := aRating * Power((FTS - 0.5) * 0.147832, 0.417779);  //HO
  Result := aRating * Power((FTS - 1) * 0.147832, 0.417779);  
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
      //MID_Bijdrage
      vPlayer.MID_Bijdrage :=
        ((vRating.MID_PM * vPlayer.PM))
        * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;

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

      //AANV_R_Bijdrage
      if (aPositie in [pCM]) then
      begin
        vPlayer.AANV_R_Bijdrage :=
          (((vRating.WA_PASS * vPlayer.PAS) / 2) +
            (vRating.WA_WING * vPlayer.WNG) +
            (vRating.WA_SC * vPlayer.SCO))
          * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
      end
      else if (aPositie in [pLW, pLCM, pLB, pLCV]) then
      begin
        vPlayer.AANV_R_Bijdrage := 0;
      end
      else if (aPositie = pLCA) and (aPlayerOrder = oNaarVleugel) then
      begin
        vPlayer.AANV_R_Bijdrage :=
          (vRating.WA_SC_OTHER * vPlayer.SCO)
          * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
      end
      else
      begin
        vPlayer.AANV_R_Bijdrage :=
          ((vRating.WA_PASS * vPlayer.PAS) +
           (vRating.WA_WING * vPlayer.WNG) +
           (vRating.WA_SC * vPlayer.SCO))
         * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
      end;

      //AANV_L_Bijdrage
      if (aPositie in [pCM]) then
      begin
        vPlayer.AANV_L_Bijdrage :=
          (((vRating.WA_PASS * vPlayer.PAS) / 2) +
            (vRating.WA_WING * vPlayer.WNG) +
            (vRating.WA_SC * vPlayer.SCO))
          * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
      end
      else if (aPositie in [pRW, pRCM, pRB, pRCV]) then
      begin
        vPlayer.AANV_L_Bijdrage := 0;
      end
      else if (aPositie = pRCA) and (aPlayerOrder = oNaarVleugel) then
      begin
        vPlayer.AANV_L_Bijdrage :=
          (vRating.WA_SC_OTHER * vPlayer.SCO)
          * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
      end
      else
      begin
        vPlayer.AANV_L_Bijdrage :=
          ((vRating.WA_PASS * vPlayer.PAS) +
           (vRating.WA_WING * vPlayer.WNG) +
           (vRating.WA_SC * vPlayer.SCO))
         * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
      end;

      //AANV_C_Bijdrage
      vPlayer.AANV_C_Bijdrage :=
          ((vRating.CA_PASS * vPlayer.PAS) +
           (vRating.CA_SC * vPlayer.SCO))
          * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
    end;
  end;

  UpdateRatings;
end;

end.
