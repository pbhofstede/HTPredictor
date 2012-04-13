unit uPlayer;

interface

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
  end;

implementation

end.
