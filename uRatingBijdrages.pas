unit uRatingBijdrages;

interface

uses
  uRatingBijdrage, ContNrs, uPlayer, uHTPredictor;

type
  TRatingBijdrages = class
  private
    FRatingBijdrages: TObjectList;
    function GetRatingBijdrage(aIndex: integer): TRatingBijdrage;
    function GetCount: integer;
    function AddRatingBijdrage(aPositie: String): TRatingBijdrage;
  public
    function CalcBijdrage(aPlayer: TPlayer; aPosition: TPlayerPosition;
      aOrder: TPlayerOrder):double;
    procedure LoadFlatterManRatings;
    function GetRatingBijdrageByPositie(aPositie:String):TRatingBijdrage;
    property Count: integer read GetCount;
    property RatingBijdrage[aIndex:integer]:TRatingBijdrage read GetRatingBijdrage;
    constructor Create;
    destructor Destroy;override;
  end;

implementation

uses
  SysUtils;

{ TRatingBijdrages }

{-----------------------------------------------------------------------------
  Procedure: Create
  Author:    Harry
  Date:      18-apr-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
constructor TRatingBijdrages.Create;
begin
  FRatingBijdrages := TObjectList.Create(TRUE);
  LoadFlatterManRatings;
end;

{-----------------------------------------------------------------------------
  Procedure: Destroy
  Author:    Harry
  Date:      18-apr-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
destructor TRatingBijdrages.Destroy;
begin
  FRatingBijdrages.Free;
  inherited;
end;

{-----------------------------------------------------------------------------
  Procedure: GetCount
  Author:    Harry
  Date:      18-apr-2012
  Arguments: None
  Result:    integer
-----------------------------------------------------------------------------}
function TRatingBijdrages.GetCount: integer;
begin
  result := FRatingBijdrages.Count;
end;

{-----------------------------------------------------------------------------
  Procedure: GetRatingBijdrage
  Author:    Harry
  Date:      18-apr-2012
  Arguments: aIndex: integer
  Result:    TRatingBijdrage
-----------------------------------------------------------------------------}
function TRatingBijdrages.GetRatingBijdrage(
  aIndex: integer): TRatingBijdrage;
begin
  result := TRatingBijdrage(FRatingBijdrages[aIndex]);
end;

{-----------------------------------------------------------------------------
  Procedure: GetRatingBijdrageByPositie
  Author:    Harry
  Date:      18-apr-2012
  Arguments: aPositie: String
  Result:    TRatingBijdrage
-----------------------------------------------------------------------------}
function TRatingBijdrages.GetRatingBijdrageByPositie(
  aPositie: String): TRatingBijdrage;
var
  i:integer;
begin
  result := nil;
  if (FRatingBijdrages.Count > 0) then
  begin
    i := 0;
    while (result = nil) and (i < Count) do
    begin
      if (TRatingBijdrage(FRatingBijdrages[i]).Positie = UpperCase(aPositie)) then
      begin
        result := TRatingBijdrage(FRatingBijdrages[i]);
      end;
      inc(i);
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: AddRatingBijdrage
  Author:    Harry
  Date:      18-apr-2012
  Arguments: aPositie: String
  Result:    TRatingBijdrage
-----------------------------------------------------------------------------}
function TRatingBijdrages.AddRatingBijdrage(
  aPositie: String): TRatingBijdrage;
begin
  result := GetRatingBijdrageByPositie(aPositie);
  if (result = nil) then
  begin
    result := TRatingBijdrage.Create;
    result.Positie := aPositie;

    FRatingBijdrages.Add(result);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: LoadFlatterManRatings
  Author:    Harry
  Date:      18-apr-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TRatingBijdrages.LoadFlatterManRatings;
var
  vRating: TRatingBijdrage;
begin
  // Keeper
  vRating := AddRatingBijdrage('K');
  vRating.CD_GK := 0.568918;
  vRating.CD_DEF := 0.264934;
  vRating.WB_GK := 0.629629;
  vRating.WB_DEF := 0.276579;

  // Centrale verdediger
  vRating := AddRatingBijdrage('CD');
  vRating.MID_PM := 0.12596;
  vRating.CD_DEF := 0.602083;
  vRating.WB_DEF := 0.499476;

  // Aanvallende centrale verdediger
  vRating := AddRatingBijdrage('OCD');
  vRating.MID_PM := 0.169827;
  vRating.CD_DEF := 0.43655;
  vRating.WB_DEF := 0.365733;

  // Defensieve vleugelverdediger
  vRating := AddRatingBijdrage('DWB');
  vRating.MID_PM := 0.030981;
  vRating.CD_DEF := 0.314461;
  vRating.WB_DEF := 1.002422;
  vRating.WING_WING := 0.255317;

  // Vleugelverdediger 'Naar het Midden'
  vRating := AddRatingBijdrage('WBTM');
  vRating.MID_PM := 0.078229;
  vRating.CD_DEF := 0.426132;
  vRating.WB_DEF := 0.688952;
  vRating.WING_WING := 0.255317;

  // Centrale middenvelder
  vRating := AddRatingBijdrage('IM');
  vRating.MID_PM := 0.468248;
  vRating.CD_DEF := 0.24966;
  vRating.WB_DEF := 0.189319;
  vRating.CA_PASS := 0.193137;
  vRating.WING_PASS := 0.189444;

  // Aanvallende centrale middenvelder
  vRating := AddRatingBijdrage('OIM');
  vRating.MID_PM := 0.442128;
  vRating.CD_DEF := 0.134608;
  vRating.WB_DEF := 0.102543;
  vRating.CA_PASS := 0.287063;
  vRating.WING_PASS := 0.187746;

  // Verdedigende centrale middenvelder
  vRating := AddRatingBijdrage('DIM');
  vRating.MID_PM := 0.442128;
  vRating.CD_DEF := 0.3705;
  vRating.WB_DEF := 0.27115;
  vRating.CA_PASS := 0.130214;
  vRating.WING_PASS := 0.121811;

  // Centrale middenvelder 'Naar de Vleugel'
  vRating := AddRatingBijdrage('IMTW');
  vRating.MID_PM := 0.412406;
  vRating.CD_DEF := 0.217029;
  vRating.WB_DEF := 0.249179;
  vRating.CA_PASS := 0.134745;
  vRating.WING_PASS := 0.235698;
  vRating.WING_WING := 0.428863;

  // Vleugelspeler
  vRating := AddRatingBijdrage('NW');
  vRating.MID_PM := 0.242848;
  vRating.CD_DEF := 0.125486;
  vRating.WB_DEF := 0.349951;
  vRating.CA_PASS := 0.061538;
  vRating.WING_PASS := 0.182107;
  vRating.WING_WING := 0.674398;

  // Aanvallende vleugelspeler
  vRating := AddRatingBijdrage('OW');
  vRating.MID_PM := 0.203662;
  vRating.CD_DEF := 0.050401;
  vRating.WB_DEF := 0.172133;
  vRating.CA_PASS := 0.080314;
  vRating.WING_PASS := 0.213452;
  vRating.WING_WING := 0.789342;

  // Verdedigende vleugelspeler
  vRating := AddRatingBijdrage('DW');
  vRating.MID_PM := 0.203662;
  vRating.CD_DEF := 0.156868;
  vRating.WB_DEF := 0.463477;
  vRating.CA_PASS := 0.031035;
  vRating.WING_PASS := 0.15016;
  vRating.WING_WING := 0.571036;

  // Vleugelspeler 'Naar het Midden'
  vRating := AddRatingBijdrage('WTM');
  vRating.MID_PM := 0.306594;
  vRating.CD_DEF := 0.152469;
  vRating.WB_DEF := 0.284824;
  vRating.CA_PASS := 0.08768;
  vRating.WING_PASS := 0.115254;
  vRating.WING_WING := 0.445048;

  // Aanvaller
  vRating := AddRatingBijdrage('FW');
  vRating.CA_PASS := 0.207589;
  vRating.CA_SC := 0.563149;
  vRating.WING_PASS := 0.10029;
  vRating.WING_WING := 0.142456;
  vRating.WING_SC := 0.184292;

  // Verdedigende aanvaller
  vRating := AddRatingBijdrage('DFW');
  vRating.MID_PM := 0.217011;
  vRating.CA_PASS := 0.322422;
  vRating.CA_SC := 0.346607;
  vRating.WING_PASS := 0.186512;
  vRating.WING_WING := 0.097975;
  vRating.WING_SC := 0.095023;

  // Technische verdedigende aanvaller
  vRating := AddRatingBijdrage('TDFW');
  vRating.MID_PM := 0.21701;
  vRating.CA_PASS := 0.470666;
  vRating.CA_SC := 0.346607;
  vRating.WING_PASS := 0.220424;
  vRating.WING_WING := 0.097975;
  vRating.WING_SC := 0.095023;

  // Aanvaller 'Naar de vleugel'
  vRating := AddRatingBijdrage('FTW');
  vRating.CA_PASS := 0.146863;
  vRating.CA_SC := 0.342343;
  vRating.WING_PASS := 0.148148;
  vRating.WING_WING := 0.392185;
  vRating.WING_SC := 0.371022;
  vRating.WING_SC_OTHER := 0.151325;
end;

{-----------------------------------------------------------------------------
  Procedure: CalcBijdrage
  Author:    Harry
  Date:      18-apr-2012
  Arguments: aPlayer: TPlayer; aPosition: TPlayerPosition;
    aOrder: TPlayerOrder
  Result:    None
-----------------------------------------------------------------------------}
function TRatingBijdrages.CalcBijdrage(aPlayer: TPlayer; aPosition: TPlayerPosition;
  aOrder: TPlayerOrder):double;
var
  vRating: TRatingBijdrage;
  vPos : String;
begin
  result := 0;
  
  vPos := uHTPredictor.PlayerPosToRatingPos(aPosition, aOrder, aPlayer.Spec);

  vRating := GetRatingBijdrageByPositie(vPos);
  if (vRating <> nil) then
  begin
    // Rating berekenen
    result := Random(50) / vRating.Count;
  end;
end;

end.
