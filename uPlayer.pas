unit uPlayer;

interface

uses
  uHTPredictor, uRatingBijdrage;

type
  TPlayer = class
  private
    FSP: double;
    FGK: double;
    FPAS: double;
    FPM: double;
    FVorm: double;
    FConditie: double;
    FSCO: double;
    FDef: double;
    FXP: double;
    FWNG: double;
    FID: integer;
    FNaam: String;
    FSpec: String;
    FDEF_R_Bijdrage: double;
    FAANV_R_Bijdrage: double;
    FMID_Bijdrage: double;
    FAANV_C_Bijdrage: double;
    FDEF_L_Bijdrage: double;
    FAANV_L_Bijdrage: double;
    FDEF_C_Bijdrage: double;
    FSelectie: TObject;
    FLoyaliteit: double;
    function GetDef: double;
    function GetGK: double;
    function GetPAS: double;
    function GetPM: double;
    function GetSCO: double;
    function GetSP: double;
    function GetWNG: double;
    function GetLoyaliteitFactor: double;
    procedure SetAANV_C_Bijdrage(const Value: double);
    procedure SetAANV_L_Bijdrage(const Value: double);
    procedure SetAANV_R_Bijdrage(const Value: double);
    procedure SetDEF_C_Bijdrage(const Value: double);
    procedure SetDEF_L_Bijdrage(const Value: double);
    procedure SetDEF_R_Bijdrage(const Value: double);
    procedure SetMID_Bijdrage(const Value: double);
  public
    property ID: integer read FID write FID;
    property Naam: String read FNaam write FNaam;
    property Spec: String read FSpec write FSpec;
    property Vorm: double read FVorm write FVorm;
    property Conditie: double read FConditie write FConditie;
    property GK: double read GetGK write FGK;
    property DEF: double read GetDef write FDef;
    property PM: double read GetPM write FPM;
    property WNG: double read GetWNG write FWNG;
    property PAS: double read GetPAS write FPAS;
    property SCO: double read GetSCO write FSCO;
    property SP: double read GetSP write FSP;
    property XP: double read FXP write FXP;
    property Loyaliteit: double read FLoyaliteit write FLoyaliteit;
    property Selectie: TObject read FSelectie write FSelectie;

    property MID_Bijdrage: double read FMID_Bijdrage write SetMID_Bijdrage;
    property DEF_R_Bijdrage: double read FDEF_R_Bijdrage write SetDEF_R_Bijdrage;
    property DEF_C_Bijdrage: double read FDEF_C_Bijdrage write SetDEF_C_Bijdrage;
    property DEF_L_Bijdrage: double read FDEF_L_Bijdrage write SetDEF_L_Bijdrage;
    property AANV_R_Bijdrage: double read FAANV_R_Bijdrage write SetAANV_R_Bijdrage;
    property AANV_L_Bijdrage: double read FAANV_L_Bijdrage write SetAANV_L_Bijdrage;
    property AANV_C_Bijdrage: double read FAANV_C_Bijdrage write SetAANV_C_Bijdrage;

    function GetPositionRating(aPosition: TPlayerPosition; aOrder: TPlayerOrder): double;
    function GetFormFactor: double;
    function GetConditieFactor: double;
    function GetXPFactor: double;

    procedure CalculateRatings(aRating: TRatingBijdrage; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);

    procedure ClearBijdrages;
  end;

implementation

uses
  uSelectie, Math;

{ TPlayer }

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TPlayer.GetConditieFactor: double;
begin
  Result := Power(Min(FConditie + 5, 14) / 14, 0.6);
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     19-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TPlayer.GetXPFactor: double;
begin
//formule MMM / HAG / HO Result := (0.0716 * Power(FXP - 1, 0.5)) + 1;
//formule Schumi     Result := (Max(Power(FXP - 0.5, 0.43), 0) + 14) / 14;
    Result := (0.0716 * Power(FXP - 1, 0.5)) + 1;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     19-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TPlayer.GetFormFactor: double;
begin
  Result := Power(Max(FVorm - 1, 0) / 7, 0.45); 
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     19-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TPlayer.GetPositionRating(aPosition: TPlayerPosition; aOrder: TPlayerOrder): double;
begin
  result := TSelectie(FSelectie).RatingBijdrages.CalcBijdrage(Self, aPosition, aOrder);
end;

procedure TPlayer.ClearBijdrages;
begin
  DEF_R_Bijdrage := 0;
  DEF_C_Bijdrage := 0;
  DEF_L_Bijdrage := 0;
  AANV_R_Bijdrage := 0;
  AANV_C_Bijdrage := 0;
  AANV_L_Bijdrage := 0;
  MID_Bijdrage := 0;
end;

function TPlayer.GetLoyaliteitFactor: double;
begin
  Result := Loyaliteit / 20;
end;

function TPlayer.GetDef: double;
begin
  Result := FDef + GetLoyaliteitFactor;
end;

function TPlayer.GetGK: double;
begin
  Result := FGK + GetLoyaliteitFactor;
end;

function TPlayer.GetPAS: double;
begin
  Result := FPAS + GetLoyaliteitFactor;
end;

function TPlayer.GetPM: double;
begin
  Result := FPM + GetLoyaliteitFactor;
end;

function TPlayer.GetSCO: double;
begin
  Result := FSCO + GetLoyaliteitFactor;
end;

function TPlayer.GetSP: double;
begin
  Result := FSP + GetLoyaliteitFactor;
end;

function TPlayer.GetWNG: double;
begin
  Result := FWNG + GetLoyaliteitFactor;
end;

procedure TPlayer.CalculateRatings(aRating: TRatingBijdrage; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);
begin
  //MID_Bijdrage
  MID_Bijdrage := (aRating.MID_PM * PM);

  //DEF_R_Bijdrage
  if (aPositie in [pCV, pCM]) then
  begin
    DEF_R_Bijdrage :=
        (aRating.WB_DEF * DEF / 2)
      + (aRating.WB_GK * GK);
       
  end
  else if (aPositie in [pLB, pLCV, pLW, pLCM]) then
  begin
    DEF_R_Bijdrage := 0;
  end
  else
  begin
    DEF_R_Bijdrage :=
        (aRating.WB_DEF * DEF)
      + (aRating.WB_GK * GK);
  end;

  //DEF_L_Bijdrage
  if (aPositie in [pCV, pCM]) then
  begin
    DEF_L_Bijdrage :=
        (aRating.WB_DEF * DEF / 2)
      + (aRating.WB_GK * GK);
  end
  else if (aPositie in [pRB, pRCV, pRW, pRCM]) then
  begin
    DEF_L_Bijdrage := 0;
  end
  else
  begin
    DEF_L_Bijdrage :=
        (aRating.WB_DEF * DEF)
      + (aRating.WB_GK * GK);
  end;

  //DEF_C_Bijdrage
  DEF_C_Bijdrage :=
      (aRating.CD_DEF * DEF)
    + (aRating.CD_GK * GK);

  //AANV_R_Bijdrage
  if (aPositie in [pCM]) then
  begin
    AANV_R_Bijdrage :=
        (aRating.WA_PASS * PAS / 2)
      + (aRating.WA_WING * WNG)
      + (aRating.WA_SC * SCO);
  end
  else if (aPositie in [pLW, pLCM, pLB, pLCV]) then
  begin
    AANV_R_Bijdrage := 0;
  end
  else if (aPositie = pLCA) and (aPlayerOrder = oNaarVleugel) then
  begin
    AANV_R_Bijdrage :=
        (aRating.WA_SC_OTHER * SCO);
  end
  else
  begin
    AANV_R_Bijdrage :=
        (aRating.WA_PASS * PAS)
      + (aRating.WA_WING * WNG)
      + (aRating.WA_SC * SCO);
  end;

  //AANV_L_Bijdrage
  if (aPositie in [pCM]) then
  begin
    AANV_L_Bijdrage :=
        (aRating.WA_PASS * PAS / 2)
      + (aRating.WA_WING * WNG)
      + (aRating.WA_SC * SCO);
  end
  else if (aPositie in [pRW, pRCM, pRB, pRCV]) then
  begin
    AANV_L_Bijdrage := 0;
  end
  else if (aPositie = pRCA) and (aPlayerOrder = oNaarVleugel) then
  begin
    AANV_L_Bijdrage :=
        (aRating.WA_SC_OTHER * SCO);
  end
  else
  begin
    AANV_L_Bijdrage :=
        (aRating.WA_PASS * PAS)
      + (aRating.WA_WING * WNG)
      + (aRating.WA_SC * SCO);
  end;

  //AANV_C_Bijdrage
  AANV_C_Bijdrage :=
      (aRating.CA_PASS * PAS)
    + (aRating.CA_SC * SCO);
end;

procedure TPlayer.SetAANV_C_Bijdrage(const Value: double);
begin
  FAANV_C_Bijdrage := Value / 4;

  FAANV_C_Bijdrage := FAANV_C_Bijdrage + (0.011339 * FAANV_C_Bijdrage * FAANV_C_Bijdrage);

  FAANV_C_Bijdrage := FAANV_C_Bijdrage +  (-0.000029 * FAANV_C_Bijdrage * FAANV_C_Bijdrage * FAANV_C_Bijdrage);

  FAANV_C_Bijdrage := FAANV_C_Bijdrage * GetConditieFactor * GetFormFactor * GetXPFactor;
end;

procedure TPlayer.SetAANV_L_Bijdrage(const Value: double);
begin
  FAANV_L_Bijdrage := Value / 4;

  FAANV_L_Bijdrage := FAANV_L_Bijdrage + (0.012093 * FAANV_L_Bijdrage * FAANV_L_Bijdrage);

  FAANV_L_Bijdrage := FAANV_L_Bijdrage +  (-0.000027 * FAANV_L_Bijdrage * FAANV_L_Bijdrage * FAANV_L_Bijdrage);

  FAANV_L_Bijdrage := FAANV_L_Bijdrage * GetConditieFactor * GetFormFactor * GetXPFactor;
end;

procedure TPlayer.SetAANV_R_Bijdrage(const Value: double);
begin
  FAANV_R_Bijdrage := Value / 4;

  FAANV_R_Bijdrage := FAANV_R_Bijdrage + (0.012093 * FAANV_R_Bijdrage * FAANV_R_Bijdrage);

  FAANV_R_Bijdrage := FAANV_R_Bijdrage +  (-0.000027 * FAANV_R_Bijdrage * FAANV_R_Bijdrage * FAANV_R_Bijdrage);

  FAANV_R_Bijdrage := FAANV_R_Bijdrage * GetConditieFactor * GetFormFactor * GetXPFactor;
end;

procedure TPlayer.SetDEF_C_Bijdrage(const Value: double);
begin
  FDEF_C_Bijdrage := Value / 4;

  FDEF_C_Bijdrage := FDEF_C_Bijdrage + (0.008462 * FDEF_C_Bijdrage * FDEF_C_Bijdrage);

  FDEF_C_Bijdrage := FDEF_C_Bijdrage +  (-0.000017 * FDEF_C_Bijdrage * FDEF_C_Bijdrage * FDEF_C_Bijdrage);

  FDEF_C_Bijdrage := FDEF_C_Bijdrage * GetConditieFactor * GetFormFactor * GetXPFactor;
end;

procedure TPlayer.SetDEF_L_Bijdrage(const Value: double);
begin
  FDEF_L_Bijdrage := Value / 4;

  FDEF_L_Bijdrage := FDEF_L_Bijdrage + (0.011591 * FDEF_L_Bijdrage * FDEF_L_Bijdrage);

  FDEF_L_Bijdrage := FDEF_L_Bijdrage +  (-0.000029 * FDEF_L_Bijdrage * FDEF_L_Bijdrage * FDEF_L_Bijdrage);

  FDEF_L_Bijdrage := FDEF_L_Bijdrage * GetConditieFactor * GetFormFactor * GetXPFactor;
end;

procedure TPlayer.SetDEF_R_Bijdrage(const Value: double);
begin
  FDEF_R_Bijdrage := Value / 4;

  FDEF_R_Bijdrage := FDEF_R_Bijdrage + (0.011591 * FDEF_R_Bijdrage * FDEF_R_Bijdrage);

  FDEF_R_Bijdrage := FDEF_R_Bijdrage +  (-0.000029 * FDEF_R_Bijdrage * FDEF_R_Bijdrage * FDEF_R_Bijdrage);

  FDEF_R_Bijdrage := FDEF_R_Bijdrage * GetConditieFactor * GetFormFactor * GetXPFactor;
end;

procedure TPlayer.SetMID_Bijdrage(const Value: double);
begin
  FMID_Bijdrage := Value / 4;

  FMID_Bijdrage := FMID_Bijdrage + (0.008504 * FMID_Bijdrage * FMID_Bijdrage);

  FMID_Bijdrage := FMID_Bijdrage +  (-0.000027 * FMID_Bijdrage * FMID_Bijdrage * FMID_Bijdrage);

  FMID_Bijdrage := FMID_Bijdrage * GetConditieFactor * GetFormFactor * GetXPFactor;
end;

end.
