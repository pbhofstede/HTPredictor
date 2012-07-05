unit uOpstelling;

interface

uses
  Contnrs, uSelectie, uPlayer, uHTPredictor, Forms, Classes;

type
  TOpstelling = class
  private
    FFrameOpstelling: TFrame;
    FSelectie: TSelectie;
    FOpstellingPlayerArray: array[1..14] of TPlayer;
    FOpstellingOrderArray: array[1..14] of TPlayerOrder;
    FSpelhervatter: TPlayer;
    FAanvoerder: TPlayer;
    FMotivatie: TOpstellingMotivatie;
    FTactiek: TOpstellingTactiek;
    FCoach: TOpstellingCoach;
    FTacticLevel: double;
    FHandmatigRV: double;
    FHandmatigCV: double;
    FHandmatigLV: double;
    FHandmatigRA: double;
    FHandmatigCA: double;
    FHandmatigLA: double;
    FHandmatigMID: double;
    FFormatie: String;  
    procedure UpdateRatings;
    procedure SetSelectie(const Value: TSelectie);
    procedure SetAanvoerder(const Value: TPlayer);
    procedure SetSpelhervatter(const Value: TPlayer);
    procedure SetMotivatie(const Value: TOpstellingMotivatie);
    procedure SetTactiek(const Value: TOpstellingTactiek);
    procedure SetCoach(const Value: TOpstellingCoach);
    procedure SetHandmatigRV(const Value: double);
    function VerrekenTypeCoach(aRating: double; aVerdediging: boolean): double;
    function VerwerkTeamgeest(aRating: double): double;
    function OverCrowdingDef: double;
    function OverCrowdingMid: double;
    function OverCrowdingAanval: double;
    function GetTacticLevel: double;
    procedure SetHandmatigCA(const Value: double);
    procedure SetHandmatigCV(const Value: double);
    procedure SetHandmatigLA(const Value: double);
    procedure SetHandmatigLV(const Value: double);
    procedure SetHandmatigMID(const Value: double);
    procedure SetHandmatigRA(const Value: double);
  public
    property HandmatigMID: double write SetHandmatigMID;
    property HandmatigRV: double write SetHandmatigRV;
    property HandmatigCV: double write SetHandmatigCV;
    property HandmatigLV: double write SetHandmatigLV;
    property HandmatigRA: double write SetHandmatigRA;
    property HandmatigCA: double write SetHandmatigCA;
    property HandmatigLA: double write SetHandmatigLA;
    property Formatie: String read FFormatie write FFormatie;
    property Selectie: TSelectie read FSelectie write SetSelectie;
    property Spelhervatter: TPlayer read FSpelhervatter write SetSpelhervatter;
    property Aanvoerder: TPlayer read FAanvoerder write SetAanvoerder;
    property Motivatie: TOpstellingMotivatie read FMotivatie write SetMotivatie;
    property Tactiek: TOpstellingTactiek read FTactiek write SetTactiek;
    property Coach: TOpstellingCoach read FCoach write SetCoach;
    property TacticLevel: double read GetTacticLevel;
    
    constructor Create(aFrameOpstelling: TFrame);

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
  vCount: integer;
begin
  Result := 0;

  if (FHandmatigCA > 0) then
  begin
    Result := FHandmatigCA;
  end
  else
  begin
    for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
    begin
      if FOpstellingPlayerArray[vCount] <> nil then
      begin
        if (vCount in [Ord(pRCA), Ord(pCA), Ord(pLCA)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].AANV_C_Bijdrage(Self) * OverCrowdingAanval);
        end
        else if (vCount in [Ord(pRCM), Ord(pCM), Ord(pLCM)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].AANV_C_Bijdrage(Self) * OverCrowdingMid);
        end
        else if (vCount in [Ord(pRCV), Ord(pCV), Ord(pLCV)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].AANV_C_Bijdrage(Self) * OverCrowdingDef);
        end
        else
        begin
          Result := Result + FOpstellingPlayerArray[vCount].AANV_C_Bijdrage(Self);
        end;
      end;
    end;

    Result := Result + (0.011339 * Result * Result);

    Result := Result + (-0.000029 * Result * Result * Result);
    
    Result := Result / 4;

    Result := Result * TeamZelfvertrouwen;

    if (Tactiek = tAfstandsSchoten) then
    begin
      Result := Result * 0.970577;
    end;
    
    //PB toegevoegd dikke duim in samenwerking HO
    Result := Result * 0.77;

    Result := 1 + VerrekenTypeCoach(Result, FALSE);
  end;
end;

constructor TOpstelling.Create(aFrameOpstelling: TFrame);
begin
  FFrameOpstelling := aFrameOpstelling;

  FMotivatie := mNormaal;
  FTactiek := tNormaal;

  FCoach := cNeutraal;
  FFormatie := '2-5-3 of zo?';
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

  if (FHandmatigCV > 0) then
  begin
    Result := FHandmatigCV;
  end
  else
  begin
    for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
    begin
      if FOpstellingPlayerArray[vCount] <> nil then
      begin
        if (vCount in [Ord(pRCA), Ord(pCA), Ord(pLCA)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].DEF_C_Bijdrage(Self) * OverCrowdingAanval);
        end
        else if (vCount in [Ord(pRCM), Ord(pCM), Ord(pLCM)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].DEF_C_Bijdrage(Self) * OverCrowdingMid);
        end
        else if (vCount in [Ord(pRCV), Ord(pCV), Ord(pLCV)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].DEF_C_Bijdrage(Self) * OverCrowdingDef);
        end
        else
        begin
          Result := Result + FOpstellingPlayerArray[vCount].DEF_C_Bijdrage(Self);
        end;
      end;
    end;

    Result := Result + (0.008462 * Result * Result);

    Result := Result + (-0.000017 * Result * Result * Result);

    Result := Result / 4;

    case Tactiek of
      tVleugelAanval:   Result := Result * 0.858029;
      tCreatiefSpel:    Result := Result * 0.930999;
    end;

    Result := 1 + VerrekenTypeCoach(Result, TRUE);
  end;
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
function TOpstelling.GetTacticLevel: double;
var
  vCount: integer;
  vLevel: double;
begin
  if (FTacticLevel = 0) then
  begin
    if (FTactiek = tCounter) then
    begin
      for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
      begin
        if FOpstellingPlayerArray[vCount] <> nil then
        begin
          if (vCount in [Ord(pRB), Ord(pRCV), Ord(pCV), Ord(pLCV), Ord(pLB)]) then
          begin
            vLevel := (0.923695 * FOpstellingPlayerArray[vCount].PAS) +
                      (0.404393 * FOpstellingPlayerArray[vCount].DEF);
                       
            vLevel := vLevel * 0.235751;

            vLevel := vLevel + (0.022976 * vLevel * vLevel);
            vLevel := vLevel + (-0.000422 * vLevel * vLevel * vLevel);

            FTacticLevel := FTacticLevel + vLevel;
          end;
        end;
      end;
    end
    else if (FTactiek in [tCentrumAanval,tVleugelAanval]) then
    begin
      for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
      begin
        if FOpstellingPlayerArray[vCount] <> nil then
        begin
          if (not (vCount in [Ord(pKP)])) then
          begin
            vLevel := (0.194912 * FOpstellingPlayerArray[vCount].PAS);

            vLevel := vLevel + (0.009067 * vLevel * vLevel);
            vLevel := vLevel + (-0.000351 * vLevel * vLevel * vLevel);

            FTacticLevel := FTacticLevel + vLevel;
          end;
        end;
      end;
    end
    else if (FTactiek in [tPressie]) then
    begin
      for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
      begin
        if FOpstellingPlayerArray[vCount] <> nil then
        begin
          if (not (vCount in [Ord(pKP)])) then
          begin
            if (FOpstellingPlayerArray[vCount].Spec = 'P') then
            begin
              vLevel := 0.062717 * ((2 * FOpstellingPlayerArray[vCount].DEF) + FOpstellingPlayerArray[vCount].Conditie);
            end
            else
            begin
              vLevel := 0.062717 * (FOpstellingPlayerArray[vCount].DEF + FOpstellingPlayerArray[vCount].Conditie);
            end;

            vLevel := vLevel + (0.035617 * vLevel * vLevel);
            vLevel := vLevel + (-0.001443 * vLevel * vLevel * vLevel);

            FTacticLevel := FTacticLevel + vLevel;
          end;
        end;
      end;
    end
    else if (FTactiek in [tAfstandsSchoten]) then
    begin
      for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
      begin
        if FOpstellingPlayerArray[vCount] <> nil then
        begin
          if (not (vCount in [Ord(pKP)])) then
          begin
            vLevel := 0.001162 * ((3 * FOpstellingPlayerArray[vCount].SCO) + FOpstellingPlayerArray[vCount].SP);

            vLevel := vLevel + (-0.310785 * vLevel * vLevel);
            vLevel := vLevel + (302.472449 * vLevel * vLevel * vLevel);

            FTacticLevel := FTacticLevel + vLevel;
          end;
        end;
      end;
    end
    else
    begin
      FTacticLevel := 20;
    end;
  end;

  Result := FTacticLevel;
end;

function TOpstelling.LA: double;
var
  vCount: integer;
begin
  Result := 0;

  if (FHandmatigLA > 0) then
  begin
    Result := FHandmatigLA;
  end
  else
  begin
    for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
    begin
      if FOpstellingPlayerArray[vCount] <> nil then
      begin
        if (vCount in [Ord(pRCA), Ord(pCA), Ord(pLCA)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].AANV_L_Bijdrage(Self) * OverCrowdingAanval);
        end
        else if (vCount in [Ord(pRCM), Ord(pCM), Ord(pLCM)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].AANV_L_Bijdrage(Self) * OverCrowdingMid);
        end
        else if (vCount in [Ord(pRCV), Ord(pCV), Ord(pLCV)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].AANV_L_Bijdrage(Self) * OverCrowdingDef);
        end
        else
        begin
          Result := Result + FOpstellingPlayerArray[vCount].AANV_L_Bijdrage(Self);
        end;
      end;
    end;

    Result := Result + (0.012093 * Result * Result);

    Result := Result +  (-0.000027 * Result * Result * Result); 

    Result := Result / 4;

    Result := Result * TeamZelfvertrouwen;

    if (Tactiek = tAfstandsSchoten) then
    begin
      Result := Result * 0.972980;
    end;

    //PB toegevoegd dikke duim in samenwerking HO
    Result := Result * 0.77;

    Result := 1 + VerrekenTypeCoach(Result, FALSE);
  end;
end;

function TOpstelling.LV: double;
var
  vCount: integer;
begin
  Result := 0;

  if (FHandmatigLV > 0) then
  begin
    Result := FHandmatigLV;
  end
  else
  begin
    for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
    begin
      if FOpstellingPlayerArray[vCount] <> nil then
      begin
        if (vCount in [Ord(pRCA), Ord(pCA), Ord(pLCA)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].DEF_L_Bijdrage(Self) * OverCrowdingAanval);
        end
        else if (vCount in [Ord(pRCM), Ord(pCM), Ord(pLCM)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].DEF_L_Bijdrage(Self) * OverCrowdingMid);
        end
        else if (vCount in [Ord(pRCV), Ord(pCV), Ord(pLCV)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].DEF_L_Bijdrage(Self) * OverCrowdingDef);
        end
        else
        begin
          Result := Result + FOpstellingPlayerArray[vCount].DEF_L_Bijdrage(Self);
        end;
      end;
    end;

    Result := Result + (0.011591 * Result * Result);

    Result := Result +  (-0.000029 * Result * Result * Result);  

    Result := Result / 4;

    case Tactiek of
      tCentrumAanval:   Result := Result * 0.853911;
      tCreatiefSpel:    Result := Result * 0.930663;
    end;

    Result := 1 + VerrekenTypeCoach(Result, TRUE);
  end;
end;

function TOpstelling.MID: double;
var
  vCount: integer;
begin
  Result := 0;

  if (FHandmatigMID > 0) then
  begin
    Result := FHandmatigMID;
  end
  else
  begin
    for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
    begin
      if FOpstellingPlayerArray[vCount] <> nil then
      begin
        if (vCount in [Ord(pRCA), Ord(pCA), Ord(pLCA)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].MID_Bijdrage(Self) * OverCrowdingAanval);
        end
        else if (vCount in [Ord(pRCM), Ord(pCM), Ord(pLCM)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].MID_Bijdrage(Self) * OverCrowdingMid);
        end
        else if (vCount in [Ord(pRCV), Ord(pCV), Ord(pLCV)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].MID_Bijdrage(Self) * OverCrowdingDef);
        end
        else
        begin
          Result := Result + FOpstellingPlayerArray[vCount].MID_Bijdrage(Self);
        end;
      end;
    end;

    Result := Result + (0.008504 * Result * Result);

    Result := Result +  (-0.000027 * Result * Result * Result); 

    Result := Result / 4;

    Result := VerwerkTeamgeest(Result);

    case Selectie.WedstrijdPlaats of
      wThuis:                 Result := Result * 1.199529;    //MMM + HO: 1.199529
      wDerbyThuis, wDerbyUit: Result := Result * 1.113699;    //MMM + HO: 1.113699
      wUit:                   Result := Result * 1;
    end;

    case Motivatie of
      mPIC:     Result := Result * 0.839949;   //MMM + HO: 0.839949
      mMOTS:    Result := Result * 1.109650;   //MMM + HO: 1.109650
      mNormaal: Result := Result * 1;
    end;

    case Tactiek of
      tAfstandsSchoten: Result := Result * 0.950323;
      tCounter:         Result := Result * 0.930000;
    end;

    Result := 1 + Result;
  end;
end;

function TOpstelling.OverCrowdingAanval: double;
var
  vCentraalCount: integer;
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

  case vCentraalCount of
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
function TOpstelling.OverCrowdingDef: double;
var
  vCentraalCount: integer;
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

  case vCentraalCount of
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
function TOpstelling.OverCrowdingMid: double;
var
  vCentraalCount: integer;
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

  case vCentraalCount of
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

  if (FHandmatigRA > 0) then
  begin
    Result := FHandmatigRA;
  end
  else
  begin
    for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
    begin
      if FOpstellingPlayerArray[vCount] <> nil then
      begin
        if (vCount in [Ord(pRCA), Ord(pCA), Ord(pLCA)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].AANV_R_Bijdrage(Self) * OverCrowdingAanval);
        end
        else if (vCount in [Ord(pRCM), Ord(pCM), Ord(pLCM)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].AANV_R_Bijdrage(Self) * OverCrowdingMid);
        end
        else if (vCount in [Ord(pRCV), Ord(pCV), Ord(pLCV)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].AANV_R_Bijdrage(Self) * OverCrowdingDef);
        end
        else
        begin
          Result := Result + FOpstellingPlayerArray[vCount].AANV_R_Bijdrage(Self);
        end;
      end;
    end;

    Result := Result + (0.012093 * Result * Result);

    Result := Result +  (-0.000027 * Result * Result * Result); 

    Result := Result / 4;

    Result := Result * TeamZelfvertrouwen;

    if (Tactiek = tAfstandsSchoten) then
    begin
      Result := Result * 0.972980;
    end;
                                    
    //PB toegevoegd dikke duim in samenwerking HO
    Result := Result * 0.77;

    Result := 1 + VerrekenTypeCoach(Result, FALSE);
  end;
end;

function TOpstelling.RV: double;
var
  vCount: integer;
begin
  Result := 0;

  if (FHandmatigRV > 0) then
  begin
    Result := FHandmatigRV;
  end
  else
  begin
    for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
    begin
      if FOpstellingPlayerArray[vCount] <> nil then
      begin
        if (vCount in [Ord(pRCA), Ord(pCA), Ord(pLCA)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].DEF_R_Bijdrage(Self) * OverCrowdingAanval);
        end
        else if (vCount in [Ord(pRCM), Ord(pCM), Ord(pLCM)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].DEF_R_Bijdrage(Self) * OverCrowdingMid);
        end
        else if (vCount in [Ord(pRCV), Ord(pCV), Ord(pLCV)]) then
        begin
          Result := Result + (FOpstellingPlayerArray[vCount].DEF_R_Bijdrage(Self) * OverCrowdingDef);
        end
        else
        begin
          Result := Result + FOpstellingPlayerArray[vCount].DEF_R_Bijdrage(Self);
        end;
      end;
    end;

    Result := Result + (0.011591 * Result * Result);

    Result := Result +  (-0.000029 * Result * Result * Result); 

    Result := Result / 4;

    case Tactiek of
      tCentrumAanval:   Result := Result * 0.853911;
      tCreatiefSpel:    Result := Result * 0.930663;
    end;

    Result := 1 + VerrekenTypeCoach(Result, TRUE);
  end;
end;

procedure TOpstelling.SetAanvoerder(const Value: TPlayer);
begin
  if (FAanvoerder <> Value) then
  begin
    FAanvoerder := Value;
    if (FFrameOpstelling <> nil) then
    begin
      (FFrameOpstelling as TfrmOpstelling).UpdateAanvoerder;
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

procedure TOpstelling.SetHandmatigCA(const Value: double);
begin
  FHandmatigCA := Value;
end;

procedure TOpstelling.SetHandmatigCV(const Value: double);
begin
  FHandmatigCV := Value;
end;

procedure TOpstelling.SetHandmatigLA(const Value: double);
begin
  FHandmatigLA := Value;
end;

procedure TOpstelling.SetHandmatigLV(const Value: double);
begin
  FHandmatigLV := Value;
end;

procedure TOpstelling.SetHandmatigMID(const Value: double);
begin
  FHandmatigMID := Value;
end;

procedure TOpstelling.SetHandmatigRA(const Value: double);
begin
  FHandmatigRA := Value;
end;

procedure TOpstelling.SetHandmatigRV(const Value: double);
begin
  FHandmatigRV := Value;
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
    if (FFrameOpstelling <> nil) then
    begin
      (FFrameOpstelling as TfrmOpstelling).UpdateSpelhervatter;
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
    FTacticLevel := 0;
    UpdateRatings;
  end;
end;

function TOpstelling.TeamZelfvertrouwen: double;
begin
  Result := 1 + (Selectie.Zelfvertrouwen * 0.0525);
end;

procedure TOpstelling.UpdateRatings;
begin
  if (FFrameOpstelling <> nil) then
  begin
    TfrmOpstelling(FFrameOpstelling).UpdateRatings;
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

function TOpstelling.VerwerkTeamgeest(aRating: double): double;
begin
  //Result := aRating * Power((Selectie.Teamgeest - 0.5) * 0.2, 0.417779);     //MMM
  //Result := aRating * Power((Selectie.Teamgeest - 0.5) * 0.147832, 0.417779);  //HO
  Result := aRating * Power((Selectie.Teamgeest - 0.5) * 0.147832, 0.417779);
end;

procedure TOpstelling.ZetPlayerIDOpPositie(aPlayerID: integer; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);
var
  vPlayer,
  vOldPlayer: TPlayer;
  vRating: TRatingBijdrage;
  vPos: String;
begin
  FTacticLevel := 0;
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
    vOldPlayer.ClearBijdrages(Self);
  end;

  if (FFrameOpstelling <> nil) then
  begin
    (FFrameOpstelling as TfrmOpstelling).EnableDisableOpstellingPlayer;
  end;

  if (vPlayer <> nil) then
  begin
    vPos := uHTPredictor.PlayerPosToRatingPos(aPositie, aPlayerOrder, vPlayer.Spec);

    vRating := Selectie.RatingBijdrages.GetRatingBijdrageByPositie(vPos);
    if (vRating <> nil) then
    begin
      vPlayer.CalculateRatings(Self, vRating, aPositie, aPlayerOrder);
    end;
  end;

  UpdateRatings;
end;

end.
