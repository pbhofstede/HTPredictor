unit uPlayer;

interface

uses
  uHTPredictor;

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

    property DEF_R_Bijdrage: double read FDEF_R_Bijdrage write FDEF_R_Bijdrage;
    property DEF_C_Bijdrage: double read FDEF_C_Bijdrage write FDEF_C_Bijdrage;
    property DEF_L_Bijdrage: double read FDEF_L_Bijdrage write FDEF_L_Bijdrage;
    property AANV_R_Bijdrage: double read FAANV_R_Bijdrage write FAANV_R_Bijdrage;
    property AANV_L_Bijdrage: double read FAANV_L_Bijdrage write FAANV_L_Bijdrage;
    property MID_Bijdrage: double read FMID_Bijdrage write FMID_Bijdrage;
    property AANV_C_Bijdrage: double read FAANV_C_Bijdrage write FAANV_C_Bijdrage;

    function GetPositionRating(aPosition: TPlayerPosition; aOrder: TPlayerOrder): double;
    function GetFormFactor: double;
    function GetConditieFactor: double;
    function GetXPFactor: double;

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
//formule MMM / HAG  Result := (0.0716 * Power(FXP - 0.5, 0.5)) + 1;
//formule Schumi     Result := (Max(Power(FXP - 0.5, 0.43), 0) + 14) / 14;
    Result := (Max(Power(FXP - 0.5, 0.43), 0) + 14) / 14;
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
  Result := FDef - 1 + GetLoyaliteitFactor;
end;

function TPlayer.GetGK: double;
begin
  Result := FGK - 1 + GetLoyaliteitFactor;
end;

function TPlayer.GetPAS: double;
begin
  Result := FPAS - 1 + GetLoyaliteitFactor;
end;

function TPlayer.GetPM: double;
begin
  Result := FPM - 1 + GetLoyaliteitFactor;
end;

function TPlayer.GetSCO: double;
begin
  Result := FSCO - 1 + GetLoyaliteitFactor;
end;

function TPlayer.GetSP: double;
begin
  Result := FSP - 1 + GetLoyaliteitFactor;
end;

function TPlayer.GetWNG: double;
begin
  Result := FWNG - 1 + GetLoyaliteitFactor;
end;

end.
