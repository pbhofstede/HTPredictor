unit uPlayer;

interface

uses
  uHTPredictor, uRatingBijdrage, uOpstellingPlayer;

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
    FSelectie: TObject;
    FLoyaliteit: double;
    FOpstellingPlayerArray: array of TOpstellingPlayer;
    function GetDef: double;
    function GetGK: double;
    function GetPAS: double;
    function GetPM: double;
    function GetSCO: double;
    function GetSP: double;
    function GetWNG: double;
    function GetLoyaliteitFactor: double;
    function GetOpstellingPlayer(aOpstelling: TObject): TOpstellingPlayer;
  public      
    property Selectie: TObject read FSelectie write FSelectie;
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

    function GetFormFactor: double;
    function GetConditieFactor: double;
    function GetXPFactor: double;

    function Mid_Bijdrage(aOpstelling: TObject): double;
    function DEF_R_Bijdrage(aOpstelling: TObject): double;
    function DEF_C_Bijdrage(aOpstelling: TObject): double;
    function DEF_L_Bijdrage(aOpstelling: TObject): double;
    function AANV_R_Bijdrage(aOpstelling: TObject): double;
    function AANV_C_Bijdrage(aOpstelling: TObject): double;
    function AANV_L_Bijdrage(aOpstelling: TObject): double;
                                                   
    function GetPositionRating(aPosition: TPlayerPosition; aOrder: TPlayerOrder): double;
    procedure CalculateRatings(aOpstelling: TObject; aRating: TRatingBijdrage; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);

    procedure ClearBijdrages(aOpstelling: TObject);

    destructor Destroy; override;
  end;

implementation

uses
  uSelectie, Math, uOpstelling;

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

procedure TPlayer.ClearBijdrages(aOpstelling: TObject);
var
  vPlayerOpstelling: TOpstellingPlayer;
begin
  vPlayerOpstelling := GetOpstellingPlayer(aOpstelling);
  
  vPlayerOpstelling.DEF_R_Bijdrage := 0;
  vPlayerOpstelling.DEF_C_Bijdrage := 0;
  vPlayerOpstelling.DEF_L_Bijdrage := 0;
  vPlayerOpstelling.AANV_R_Bijdrage := 0;
  vPlayerOpstelling.AANV_C_Bijdrage := 0;
  vPlayerOpstelling.AANV_L_Bijdrage := 0;
  vPlayerOpstelling.MID_Bijdrage := 0;
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

procedure TPlayer.CalculateRatings(aOpstelling: TObject; aRating: TRatingBijdrage; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);
var
  vPlayerOpstelling: TOpstellingPlayer;
begin
  vPlayerOpstelling := GetOpstellingPlayer(aOpstelling);

  vPlayerOpstelling.CalculateRatings(aRating, aPositie, aPlayerOrder);
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     13-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TPlayer.GetOpstellingPlayer(aOpstelling: TObject): TOpstellingPlayer;
var
  vCount: integer;
begin
  Result := nil;
  vCount := 0;

  while (Result = nil) and
        (vCount < Length(FOpstellingPlayerArray)) do
  begin
    if (FOpstellingPlayerArray[vCount].Opstelling = TOpstelling(aOpstelling)) then
    begin
      Result := FOpstellingPlayerArray[vCount];
    end
    else
    begin
      Inc(vCount);
    end;
  end;

  if (Result = nil) then
  begin
    Result := TOpstellingPlayer.Create(Self, TOpstelling(aOpstelling));

    SetLength(FOpstellingPlayerArray, Length(FOpstellingPlayerArray) + 1);
    FOpstellingPlayerArray[Length(FOpstellingPlayerArray) - 1] := Result;
  end;
end;

function TPlayer.Mid_Bijdrage(aOpstelling: TObject): double;
var
  vPlayerOpstelling: TOpstellingPlayer;
begin
  vPlayerOpstelling := GetOpstellingPlayer(aOpstelling);

  Result := vPlayerOpstelling.Mid_Bijdrage;
end;


function TPlayer.AANV_C_Bijdrage(aOpstelling: TObject): double;
var
  vPlayerOpstelling: TOpstellingPlayer;
begin
  vPlayerOpstelling := GetOpstellingPlayer(aOpstelling);

  Result := vPlayerOpstelling.AANV_C_Bijdrage;
end;

function TPlayer.AANV_L_Bijdrage(aOpstelling: TObject): double;
var
  vPlayerOpstelling: TOpstellingPlayer;
begin
  vPlayerOpstelling := GetOpstellingPlayer(aOpstelling);

  Result := vPlayerOpstelling.AANV_L_Bijdrage;
end;

function TPlayer.AANV_R_Bijdrage(aOpstelling: TObject): double;
var
  vPlayerOpstelling: TOpstellingPlayer;
begin
  vPlayerOpstelling := GetOpstellingPlayer(aOpstelling);

  Result := vPlayerOpstelling.AANV_R_Bijdrage;
end;

function TPlayer.DEF_C_Bijdrage(aOpstelling: TObject): double;
var
  vPlayerOpstelling: TOpstellingPlayer;
begin
  vPlayerOpstelling := GetOpstellingPlayer(aOpstelling);

  Result := vPlayerOpstelling.DEF_C_Bijdrage;
end;

function TPlayer.DEF_L_Bijdrage(aOpstelling: TObject): double;
var
  vPlayerOpstelling: TOpstellingPlayer;
begin
  vPlayerOpstelling := GetOpstellingPlayer(aOpstelling);

  Result := vPlayerOpstelling.DEF_L_Bijdrage;
end;

function TPlayer.DEF_R_Bijdrage(aOpstelling: TObject): double;
var
  vPlayerOpstelling: TOpstellingPlayer;
begin
  vPlayerOpstelling := GetOpstellingPlayer(aOpstelling);

  Result := vPlayerOpstelling.DEF_R_Bijdrage;
end;

destructor TPlayer.Destroy;
var
  vCount: integer;
begin
  for vCount := 0 to Length(FOpstellingPlayerArray) - 1 do
  begin
    FOpstellingPlayerArray[vCount].Free;
  end;

  SetLength(FOpstellingPlayerArray, 0);
  inherited;
end;

end.
