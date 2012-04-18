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
    FWING_R_Bijdrage: double;
    FPOS_Bijdrage: double;
    FSC_Bijdrage: double;
    FDEF_L_Bijdrage: double;
    FWING_L_Bijdrage: double;
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
    property WING_R_Bijdrage: double read FWING_R_Bijdrage write FWING_R_Bijdrage;
    property WING_L_Bijdrage: double read FWING_L_Bijdrage write FWING_L_Bijdrage;
    property POS_Bijdrage: double read FPOS_Bijdrage write FPOS_Bijdrage;
    property SC_Bijdrage: double read FSC_Bijdrage write FSC_Bijdrage;

    function GetPositionRating(aPosition: TPlayerPosition; aOrder: TPlayerOrder): double;
  end;

implementation

uses
  uSelectie;

{ TPlayer }

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TPlayer.GetPositionRating(
  aPosition: TPlayerPosition; aOrder: TPlayerOrder): double;
begin
  result := TSelectie(FSelectie).RatingBijdrages.CalcBijdrage(Self,
    aPosition, aOrder);
end;

end.
