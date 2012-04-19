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
  public
    property ID: integer read FID write FID;
    property Naam: String read FNaam write FNaam;
    property Spec: String read FSpec write FSpec;
    property Vorm: double read FVorm write FVorm;
    property Conditie: double read FConditie write FConditie;
    property GK: double read FGK write FGK;
    property DEF: double read FDef write FDef;
    property PM: double read FPM write FPM;
    property WNG: double read FWNG write FWNG;
    property PAS: double read FPAS write FPAS;
    property SCO: double read FSCO write FSCO;
    property SP: double read FSP write FSP;
    property XP: double read FXP write FXP;
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
  //Result := Power((FConditie - 1 + 6 ) / 14, 0.6);
  Result := Power(Min(FConditie + 6.5, 15.25) / 14, 0.6);
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     19-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TPlayer.GetXPFactor: double;
begin
  Result := (0.0716 * Power(FXP - 0.5, 0.5)) + 1;
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

end.
