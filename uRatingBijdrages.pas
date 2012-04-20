unit uRatingBijdrages;

interface

uses
  uRatingBijdrage, ContNrs, uPlayer, uHTPredictor, dxmdaset;

type
  TRatingBijdrages = class
  private
    FRatingBijdrages: TObjectList;
    function GetRatingBijdrage(aIndex: integer): TRatingBijdrage;
    function GetCount: integer;
    function AddRatingBijdrage(aPositie: String): TRatingBijdrage;
  public
    procedure LoadFromMemData(aMemDataSet: TdxMemData);
    procedure SaveToMemData(aMemDataSet:TdxMemData);
    function CalcBijdrage(aPlayer: TPlayer; aPosition: TPlayerPosition;
      aOrder: TPlayerOrder):double;
    procedure LoadFlatterManRatings;
    function GetRatingBijdrageByPositie(aPositie: String; aGiveWarning: Boolean = TRUE):TRatingBijdrage;
    property Count: integer read GetCount;
    property RatingBijdrage[aIndex:integer]:TRatingBijdrage read GetRatingBijdrage;
    constructor Create;
    destructor Destroy;override;
  end;

implementation

uses
  SysUtils, Dialogs, db;

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
function TRatingBijdrages.GetRatingBijdrageByPositie(aPositie: String; aGiveWarning: Boolean = TRUE): TRatingBijdrage;
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

  if (Result = nil) and
     (aGiveWarning) then
  begin
    ShowMessage('Geen result bij GetRatingBijdrageByPositie!');
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: AddRatingBijdrage
  Author:    Harry
  Date:      18-apr-2012
  Arguments: aPositie: String
  Result:    TRatingBijdrage
-----------------------------------------------------------------------------}
function TRatingBijdrages.AddRatingBijdrage(aPositie: String): TRatingBijdrage;
begin
  result := GetRatingBijdrageByPositie(aPositie, FALSE);
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

  // Centrale verdediger naar de vleugel
  vRating := AddRatingBijdrage('CDTW');
  vRating.MID_PM := 0.088027;
  vRating.CD_DEF := 0.468513;
  vRating.WB_DEF := 0.656592;
  vRating.WA_WING := 0.213672;

  // Normale vleugelverdediger
  vRating := AddRatingBijdrage('NWB');
  vRating.MID_PM := 0.078229;
  vRating.CD_DEF := 0.280401;
  vRating.WB_DEF := 0.921337;
  vRating.WA_WING := 0.399755;

  // Offensieve vleugelverdediger
  vRating := AddRatingBijdrage('OWB');
  vRating.MID_PM := 0.107886;
  vRating.CD_DEF := 0.238437;
  vRating.WB_DEF := 0.69943;
  vRating.WA_WING := 0.487884;

  // Defensieve vleugelverdediger
  vRating := AddRatingBijdrage('DWB');
  vRating.MID_PM := 0.030981;
  vRating.CD_DEF := 0.314461;
  vRating.WB_DEF := 1.002422;
  vRating.WA_WING := 0.255317;

  // Vleugelverdediger 'Naar het Midden'
  vRating := AddRatingBijdrage('WBTM');
  vRating.MID_PM := 0.078229;
  vRating.CD_DEF := 0.426132;
  vRating.WB_DEF := 0.688952;
  vRating.WA_WING := 0.255317;

  // Centrale middenvelder
  vRating := AddRatingBijdrage('IM');
  vRating.MID_PM := 0.468248;
  vRating.CD_DEF := 0.24966;
  vRating.WB_DEF := 0.189319;
  vRating.CA_PASS := 0.193137;
  vRating.WA_PASS := 0.189444;

  // Aanvallende centrale middenvelder
  vRating := AddRatingBijdrage('OIM');
  vRating.MID_PM := 0.442128;
  vRating.CD_DEF := 0.134608;
  vRating.WB_DEF := 0.102543;
  vRating.CA_PASS := 0.287063;
  vRating.WA_PASS := 0.187746;

  // Verdedigende centrale middenvelder
  vRating := AddRatingBijdrage('DIM');
  vRating.MID_PM := 0.442128;
  vRating.CD_DEF := 0.3705;
  vRating.WB_DEF := 0.27115;
  vRating.CA_PASS := 0.130214;
  vRating.WA_PASS := 0.121811;

  // Centrale middenvelder 'Naar de Vleugel'
  vRating := AddRatingBijdrage('IMTW');
  vRating.MID_PM := 0.412406;
  vRating.CD_DEF := 0.217029;
  vRating.WB_DEF := 0.249179;
  vRating.CA_PASS := 0.134745;
  vRating.WA_PASS := 0.235698;
  vRating.WA_WING := 0.428863;

  // Vleugelspeler
  vRating := AddRatingBijdrage('NW');
  vRating.MID_PM := 0.242848;
  vRating.CD_DEF := 0.125486;
  vRating.WB_DEF := 0.349951;
  vRating.CA_PASS := 0.061538;
  vRating.WA_PASS := 0.182107;
  vRating.WA_WING := 0.674398;

  // Aanvallende vleugelspeler
  vRating := AddRatingBijdrage('OW');
  vRating.MID_PM := 0.203662;
  vRating.CD_DEF := 0.050401;
  vRating.WB_DEF := 0.172133;
  vRating.CA_PASS := 0.080314;
  vRating.WA_PASS := 0.213452;
  vRating.WA_WING := 0.789342;

  // Verdedigende vleugelspeler
  vRating := AddRatingBijdrage('DW');
  vRating.MID_PM := 0.203662;
  vRating.CD_DEF := 0.156868;
  vRating.WB_DEF := 0.463477;
  vRating.CA_PASS := 0.031035;
  vRating.WA_PASS := 0.15016;
  vRating.WA_WING := 0.571036;

  // Vleugelspeler 'Naar het Midden'
  vRating := AddRatingBijdrage('WTM');
  vRating.MID_PM := 0.306594;
  vRating.CD_DEF := 0.152469;
  vRating.WB_DEF := 0.284824;
  vRating.CA_PASS := 0.08768;
  vRating.WA_PASS := 0.115254;
  vRating.WA_WING := 0.445048;

  // Aanvaller
  vRating := AddRatingBijdrage('FW');
  vRating.CA_PASS := 0.207589;
  vRating.CA_SC := 0.563149;
  vRating.WA_PASS := 0.10029;
  vRating.WA_WING := 0.142456;
  vRating.WA_SC := 0.184292;

  // Verdedigende aanvaller
  vRating := AddRatingBijdrage('DFW');
  vRating.MID_PM := 0.217011;
  vRating.CA_PASS := 0.322422;
  vRating.CA_SC := 0.346607;
  vRating.WA_PASS := 0.186512;
  vRating.WA_WING := 0.097975;
  vRating.WA_SC := 0.095023;

  // Technische verdedigende aanvaller
  vRating := AddRatingBijdrage('TDFW');
  vRating.MID_PM := 0.21701;
  vRating.CA_PASS := 0.470666;
  vRating.CA_SC := 0.346607;
  vRating.WA_PASS := 0.220424;
  vRating.WA_WING := 0.097975;
  vRating.WA_SC := 0.095023;

  // Aanvaller 'Naar de vleugel'
  vRating := AddRatingBijdrage('FTW');
  vRating.CA_PASS := 0.146863;
  vRating.CA_SC := 0.342343;
  vRating.WA_PASS := 0.148148;
  vRating.WA_WING := 0.392185;
  vRating.WA_SC := 0.371022;
  vRating.WA_SC_OTHER := 0.151325;
  {TODO: vRating.WING_WG_OTHER ook implementeren??} 
end;

{-----------------------------------------------------------------------------
  Procedure: CalcBijdrage
  Author:    Harry
  Date:      18-apr-2012
  Arguments: aPlayer: TPlayer; aPosition: TPlayerPosition;
    aOrder: TPlayerOrder
  Result:    None
-----------------------------------------------------------------------------}
function TRatingBijdrages.CalcBijdrage(aPlayer: TPlayer; aPosition: TPlayerPosition; aOrder: TPlayerOrder): double;
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
    result :=
      //middenveldrating iets opwaarderen zodat de getoonde comboboxlijstjes representabeler zijn
      (vRating.MID_PM * aPlayer.PM * 1.4) +
      (vRating.CD_GK * aPlayer.GK) +
      (vRating.CD_DEF * aPlayer.DEF) +
      (vRating.WB_GK * aPlayer.GK) +
      (vRating.WB_DEF * aPlayer.DEF) +
      (vRating.CA_PASS * aPlayer.PAS) +
      (vRating.CA_SC * aPlayer.SCO) +
      (vRating.WA_PASS * aPlayer.PAS) +
      (vRating.WA_WING * aPlayer.WNG) +
      (vRating.WA_SC * aPlayer.SCO) +
      (vRating.WA_SC_OTHER * aPlayer.SCO);

    Result := Result * aPlayer.GetConditieFactor * aPlayer.GetFormFactor * aPlayer.GetXPFactor;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: LoadFromMemData
  Author:    Harry
  Date:      19-apr-2012
  Arguments: aMemDataSet: TdxMemData
  Result:    None
-----------------------------------------------------------------------------}
procedure TRatingBijdrages.LoadFromMemData(aMemDataSet: TdxMemData);
var
  vRating: TRatingBijdrage;
  vBookMark: TBookMark;
begin
  vBookMark := aMemDataSet.GetBookmark;
  
  aMemDataSet.DisableControls;
  try
    aMemDataSet.First;
    while not aMemDataSet.Eof do
    begin
      vRating := GetRatingBijdrageByPositie(aMemDataSet.FieldByName('POSITIE').asString);
      if (vRating <> nil) then
      begin
        vRating.MID_PM := aMemDataSet.FieldByName('MID_PM').asFloat;
        vRating.CD_GK := aMemDataSet.FieldByName('CD_GK').asFloat;
        vRating.CD_DEF := aMemDataSet.FieldByName('CD_DEF').asFloat;
        vRating.WB_GK := aMemDataSet.FieldByName('WB_GK').asFloat;
        vRating.CA_PASS := aMemDataSet.FieldByName('CA_PASS').asFloat;
        vRating.CA_SC := aMemDataSet.FieldByName('CA_SC').asFloat;
        vRating.WA_PASS := aMemDataSet.FieldByName('WA_PASS').asFloat;
        vRating.WA_WING := aMemDataSet.FieldByName('WA_WING').asFloat;
        vRating.WA_SC := aMemDataSet.FieldByName('WA_SC').asFloat;
        vRating.WA_SC_OTHER := aMemDataSet.FieldByName('WA_SC_OTHER').asFloat;
      end;

      aMemDataSet.Next;
    end;
  finally
    aMemDataSet.GotoBookmark(vBookMark);
    aMemDataSet.EnableControls;
    aMemDataSet.FreeBookmark(vBookMark);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: SaveToMemData
  Author:    Harry
  Date:      19-apr-2012
  Arguments: aMemDataSet: TdxMemData
  Result:    None
-----------------------------------------------------------------------------}
procedure TRatingBijdrages.SaveToMemData(aMemDataSet: TdxMemData);
var
  i: integer;
  vRating: TRatingBijdrage;
begin
  if aMemDataSet.Active then
    aMemDataSet.Close;

  aMemDataSet.Open;

  for i:=0 to Count - 1 do
  begin
    vRating := GetRatingBijdrage(i);

    aMemDataSet.Append;
    aMemDataSet.FieldByName('POSITIE').asString := vRating.Positie;
    if (vRating.MID_PM > 0) then
      aMemDataSet.FieldByName('MID_PM').asFloat := vRating.MID_PM;

    if (vRating.CD_GK > 0) then
      aMemDataSet.FieldByName('CD_GK').asFloat := vRating.CD_GK;

    if (vRating.CD_DEF > 0) then
      aMemDataSet.FieldByName('CD_DEF').asFloat := vRating.CD_DEF;

    if (vRating.WB_GK > 0) then
      aMemDataSet.FieldByName('WB_GK').asFloat := vRating.WB_GK;

    if (vRating.CA_PASS > 0) then
      aMemDataSet.FieldByName('CA_PASS').asFloat := vRating.CA_PASS;

    if (vRating.CA_SC > 0) then
      aMemDataSet.FieldByName('CA_SC').asFloat := vRating.CA_SC;

    if (vRating.WA_PASS > 0) then
      aMemDataSet.FieldByName('WA_PASS').asFloat := vRating.WA_PASS;

    if (vRating.WA_WING > 0) then
      aMemDataSet.FieldByName('WA_WING').asFloat := vRating.WA_WING;

    if (vRating.WA_SC > 0) then
      aMemDataSet.FieldByName('WA_SC').asFloat := vRating.WA_SC;

    if (vRating.WA_SC_OTHER > 0) then
      aMemDataSet.FieldByName('WA_SC_OTHER').asFloat := vRating.WA_SC_OTHER;

    aMemDataSet.Post;
  end;
end;

end.
