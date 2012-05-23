unit uOpstellingPlayer;

interface

uses
  uHTPredictor, uRatingBijdrage;

type
  TOpstellingPlayer = class
  private
    FDEF_R_Bijdrage: double;
    FAANV_R_Bijdrage: double;
    FMID_Bijdrage: double;
    FAANV_C_Bijdrage: double;
    FDEF_L_Bijdrage: double;
    FAANV_L_Bijdrage: double;
    FDEF_C_Bijdrage: double;
    FRating: TRatingBijdrage;
    FPositie: TPlayerPosition;
    FPlayerOrder: TPlayerOrder;
    FPlayer: TObject;
    FOpstelling: TObject;
    procedure SetAANV_C_Bijdrage(const Value: double);
    procedure SetAANV_L_Bijdrage(const Value: double);
    procedure SetAANV_R_Bijdrage(const Value: double);
    procedure SetDEF_C_Bijdrage(const Value: double);
    procedure SetDEF_L_Bijdrage(const Value: double);
    procedure SetDEF_R_Bijdrage(const Value: double);
    procedure SetMID_Bijdrage(const Value: double);
  public
    property Player: TObject read FPlayer;
    property Opstelling: TObject read FOpstelling;
    property MID_Bijdrage: double read FMID_Bijdrage write SetMID_Bijdrage;
    property DEF_R_Bijdrage: double read FDEF_R_Bijdrage write SetDEF_R_Bijdrage;
    property DEF_C_Bijdrage: double read FDEF_C_Bijdrage write SetDEF_C_Bijdrage;
    property DEF_L_Bijdrage: double read FDEF_L_Bijdrage write SetDEF_L_Bijdrage;
    property AANV_R_Bijdrage: double read FAANV_R_Bijdrage write SetAANV_R_Bijdrage;
    property AANV_L_Bijdrage: double read FAANV_L_Bijdrage write SetAANV_L_Bijdrage;
    property AANV_C_Bijdrage: double read FAANV_C_Bijdrage write SetAANV_C_Bijdrage;
                                                             
    procedure RecalculateRatings;
    procedure CalculateRatings(aRating: TRatingBijdrage; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);
    constructor Create(aPlayer, aOpstelling: TObject);
  end;

implementation

uses
  uSelectie, Math, uPlayer;

procedure TOpstellingPlayer.RecalculateRatings;
begin
  if (FRating <> nil) then
  begin
    CalculateRatings(FRating, FPositie, FPlayerOrder);
  end;
end;


procedure TOpstellingPlayer.CalculateRatings(aRating: TRatingBijdrage; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);
var
  vPlayer: TPlayer;
begin
  FRating := aRating;
  FPositie := aPositie;
  FPlayerOrder := aPlayerOrder;
  vPlayer := TPlayer(FPlayer);

  //MID_Bijdrage
  MID_Bijdrage := (aRating.MID_PM * vPlayer.PM);

  //DEF_R_Bijdrage
  if (aPositie in [pCV, pCM]) then
  begin
    DEF_R_Bijdrage :=
        (aRating.WB_DEF * vPlayer.DEF / 2)
      + (aRating.WB_GK * vPlayer.GK);

  end
  else if (aPositie in [pLB, pLCV, pLW, pLCM]) then
  begin
    DEF_R_Bijdrage := 0;
  end
  else
  begin
    DEF_R_Bijdrage :=
        (aRating.WB_DEF * vPlayer.DEF)
      + (aRating.WB_GK * vPlayer.GK);
  end;

  //DEF_L_Bijdrage
  if (aPositie in [pCV, pCM]) then
  begin
    DEF_L_Bijdrage :=
        (aRating.WB_DEF * vPlayer.DEF / 2)
      + (aRating.WB_GK * vPlayer.GK);
  end
  else if (aPositie in [pRB, pRCV, pRW, pRCM]) then
  begin
    DEF_L_Bijdrage := 0;
  end
  else
  begin
    DEF_L_Bijdrage :=
        (aRating.WB_DEF * vPlayer.DEF)
      + (aRating.WB_GK * vPlayer.GK);
  end;

  //DEF_C_Bijdrage
  DEF_C_Bijdrage :=
      (aRating.CD_DEF * vPlayer.DEF)
    + (aRating.CD_GK * vPlayer.GK);

  //AANV_R_Bijdrage
  if (aPositie in [pCM]) then
  begin
    AANV_R_Bijdrage :=
        (aRating.WA_PASS * vPlayer.PAS / 2)
      + (aRating.WA_WING * vPlayer.WNG)
      + (aRating.WA_SC * vPlayer.SCO);
  end
  else if (aPositie in [pLW, pLCM, pLB, pLCV]) then
  begin
    AANV_R_Bijdrage := 0;
  end
  else if (aPositie = pLCA) and (aPlayerOrder = oNaarVleugel) then
  begin
    AANV_R_Bijdrage :=
        (aRating.WA_SC_OTHER * vPlayer.SCO);
  end
  else
  begin
    AANV_R_Bijdrage :=
        (aRating.WA_PASS * vPlayer.PAS)
      + (aRating.WA_WING * vPlayer.WNG)
      + (aRating.WA_SC * vPlayer.SCO);
  end;

  //AANV_L_Bijdrage
  if (aPositie in [pCM]) then
  begin
    AANV_L_Bijdrage :=
        (aRating.WA_PASS * vPlayer.PAS / 2)
      + (aRating.WA_WING * vPlayer.WNG)
      + (aRating.WA_SC * vPlayer.SCO);
  end
  else if (aPositie in [pRW, pRCM, pRB, pRCV]) then
  begin
    AANV_L_Bijdrage := 0;
  end
  else if (aPositie = pRCA) and (aPlayerOrder = oNaarVleugel) then
  begin
    AANV_L_Bijdrage :=
        (aRating.WA_SC_OTHER * vPlayer.SCO);
  end
  else
  begin
    AANV_L_Bijdrage :=
        (aRating.WA_PASS * vPlayer.PAS)
      + (aRating.WA_WING * vPlayer.WNG)
      + (aRating.WA_SC * vPlayer.SCO);
  end;

  //AANV_C_Bijdrage
  AANV_C_Bijdrage :=
      (aRating.CA_PASS * vPlayer.PAS)
    + (aRating.CA_SC * vPlayer.SCO);
end;

procedure TOpstellingPlayer.SetAANV_C_Bijdrage(const Value: double);
var
  vPlayer: TPlayer;
begin                         
  vPlayer := TPlayer(FPlayer);

  FAANV_C_Bijdrage := Value * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
end;

procedure TOpstellingPlayer.SetAANV_L_Bijdrage(const Value: double);
var
  vPlayer: TPlayer;
begin
  vPlayer := TPlayer(FPlayer);

  FAANV_L_Bijdrage := Value * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
end;

procedure TOpstellingPlayer.SetAANV_R_Bijdrage(const Value: double);
var
  vPlayer: TPlayer;
begin
  vPlayer := TPlayer(FPlayer);

  FAANV_R_Bijdrage := Value * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
end;

procedure TOpstellingPlayer.SetDEF_C_Bijdrage(const Value: double);
var
  vPlayer: TPlayer;
begin
  vPlayer := TPlayer(FPlayer);

  FDEF_C_Bijdrage := Value * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
end;

procedure TOpstellingPlayer.SetDEF_L_Bijdrage(const Value: double);
var
  vPlayer: TPlayer;
begin
  vPlayer := TPlayer(FPlayer);

  FDEF_L_Bijdrage := Value * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
end;

procedure TOpstellingPlayer.SetDEF_R_Bijdrage(const Value: double);
var
  vPlayer: TPlayer;
begin
  vPlayer := TPlayer(FPlayer);

  FDEF_R_Bijdrage := Value * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
end;

procedure TOpstellingPlayer.SetMID_Bijdrage(const Value: double);
var
  vPlayer: TPlayer;
begin  
  vPlayer := TPlayer(FPlayer);

  FMID_Bijdrage := Value * vPlayer.GetConditieFactor * vPlayer.GetFormFactor * vPlayer.GetXPFactor;
end;


constructor TOpstellingPlayer.Create(aPlayer, aOpstelling: TObject);
begin
  FPlayer := aPlayer;
  FOpstelling := aOpstelling;
end;
end.
