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
  vRating.CD_GK := 0.568918;  //0.541809523809524
  vRating.CD_DEF := 0.264934; //0.2649
  vRating.WB_GK := 0.629629;  //0.599619047619048
  vRating.WB_DEF := 0.276579; //0.2765

  // Centrale verdediger
  vRating := AddRatingBijdrage('CD');
  vRating.MID_PM := 0.12596;  //0.114332444120847
  vRating.CD_DEF := 0.602083; //0.623608017817372
  vRating.WB_DEF := 0.499476; //0.51732532242192   //0.25866266121096

  // Aanvallende centrale verdediger
  vRating := AddRatingBijdrage('OCD');
  vRating.MID_PM := 0.169827; //0.154198959584748
  vRating.CD_DEF := 0.43655;  //0.45216760760346
  vRating.WB_DEF := 0.365733; //0.378826332418294 //0.189361371523282

  // Centrale verdediger naar de vleugel
  vRating := AddRatingBijdrage('CDTW');
  vRating.MID_PM := 0.088027; //0.0799146551440389
  vRating.CD_DEF := 0.468513; //0.485316206557207
  vRating.WB_DEF := 0.656592; //0.715857079379445
  vRating.WA_WING := 0.213672;//0.221266898016264

  // Normale vleugelverdediger
  vRating := AddRatingBijdrage('NWB');
  vRating.MID_PM := 0.078229; //0.0782
  vRating.CD_DEF := 0.280401; //0.2804
  vRating.WB_DEF := 0.921337; //0.9213
  vRating.WA_WING := 0.399755;//0.444111111111111

  // Offensieve vleugelverdediger
  vRating := AddRatingBijdrage('OWB');
  vRating.MID_PM := 0.107886; //0.1078
  vRating.CD_DEF := 0.238437; //0.2384
  vRating.WB_DEF := 0.69943;  //0.6994
  vRating.WA_WING := 0.487884;//0.542

  // Defensieve vleugelverdediger
  vRating := AddRatingBijdrage('DWB');
  vRating.MID_PM := 0.030981;  //0.0309
  vRating.CD_DEF := 0.314461;  //0.29868
  vRating.WB_DEF := 1.002422;  //1.0024
  vRating.WA_WING := 0.255317; //0.283666666666667

  // Vleugelverdediger 'Naar het Midden'
  vRating := AddRatingBijdrage('WBTM');
  vRating.MID_PM := 0.078229; //0.0782
  vRating.CD_DEF := 0.426132; //0.4261
  vRating.WB_DEF := 0.688952; //0.6889
  vRating.WA_WING := 0.255317;//0.242535

  // Centrale middenvelder
  vRating := AddRatingBijdrage('IM');
  vRating.MID_PM := 0.468248; //0.4682
  vRating.CD_DEF := 0.24966; //0.2496
  vRating.WB_DEF := 0.189319;  //0.1893  //0.0946
  vRating.CA_PASS := 0.193137; //0.1931
  vRating.WA_PASS := 0.189444; //0.1894  //0.0947

  // Aanvallende centrale middenvelder
  vRating := AddRatingBijdrage('OIM');
  vRating.MID_PM := 0.442128; //0.4421
  vRating.CD_DEF := 0.134608; //0.1346
  vRating.WB_DEF := 0.102543; //0.1025 //0.0512
  vRating.CA_PASS := 0.287063; //0.287
  vRating.WA_PASS := 0.187746; //0.1877  //0.0938

  // Verdedigende centrale middenvelder
  vRating := AddRatingBijdrage('DIM');
  vRating.MID_PM := 0.442128;//0.4421
  vRating.CD_DEF := 0.3705;  //0.3705
  vRating.WB_DEF := 0.27115; //0.2711 //0.1355
  vRating.CA_PASS := 0.130214; //0.1302
  vRating.WA_PASS := 0.121811; //0.1218 //0.0609

  // Centrale middenvelder 'Naar de Vleugel'
  vRating := AddRatingBijdrage('IMTW');
  vRating.MID_PM := 0.412406; //0.4124
  vRating.CD_DEF := 0.217029; //0.217
  vRating.WB_DEF := 0.249179; //0.2491
  vRating.CA_PASS := 0.134745;  //0.1347
  vRating.WA_PASS := 0.235698;  //0.2356
  vRating.WA_WING := 0.428863;  //0.4288

  // Vleugelspeler
  vRating := AddRatingBijdrage('NW');
  vRating.MID_PM := 0.242848;  //0.212851757692645
  vRating.CD_DEF := 0.125486;  //0.1254
  vRating.WB_DEF := 0.349951;  //0.3499
  vRating.CA_PASS := 0.061538; //0.0615
  vRating.WA_PASS := 0.182107; //0.1821
  vRating.WA_WING := 0.674398; //0.749222222222222

  // Aanvallende vleugelspeler
  vRating := AddRatingBijdrage('OW');
  vRating.MID_PM := 0.203662;  //0.178486894012448
  vRating.CD_DEF := 0.050401;  //0.0504
  vRating.WB_DEF := 0.172133;  //0.181157894736842
  vRating.CA_PASS := 0.080314; //0.0803
  vRating.WA_PASS := 0.213452; //0.2134
  vRating.WA_WING := 0.789342; //0.877

  // Verdedigende vleugelspeler
  vRating := AddRatingBijdrage('DW');
  vRating.MID_PM := 0.203662; //0.178486894012448
  vRating.CD_DEF := 0.156868; //0.1568
  vRating.WB_DEF := 0.463477; //0.487789473684211
  vRating.CA_PASS := 0.031035; //0.031
  vRating.WA_PASS := 0.15016;  //0.1501
  vRating.WA_WING := 0.571036; //0.634444444444444

  // Vleugelspeler 'Naar het Midden'
  vRating := AddRatingBijdrage('WTM');
  vRating.MID_PM := 0.306594; //0.268694661172964
  vRating.CD_DEF := 0.152469; //0.1524
  vRating.WB_DEF := 0.284824; //0.2848
  vRating.CA_PASS := 0.08768; //0.0876
  vRating.WA_PASS := 0.115254;//0.1152
  vRating.WA_WING := 0.445048;//0.494444444444444

  // Aanvaller
  vRating := AddRatingBijdrage('FW');
  vRating.CA_PASS := 0.207589;  //0.218876084491443
  vRating.CA_SC := 0.563149;    //0.593971677962079
  vRating.WA_PASS := 0.10029;   //0.105693415258036
  vRating.WA_WING := 0.142456;  //0.158112641377712
  vRating.WA_SC := 0.184292;    //0.194298673558187

  // Verdedigende aanvaller
  vRating := AddRatingBijdrage('DFW');
  vRating.MID_PM := 0.217011;   //0.200663555076171
  vRating.CA_PASS := 0.322422;  //0.350593216445366
  vRating.CA_SC := 0.346607;    //0.365602172938477
  vRating.WA_PASS := 0.186512;  //0.196724769916405
  vRating.WA_WING := 0.097975;  //0.108702440947177
  vRating.WA_SC := 0.095023;    //0.100208327839456

  // Technische verdedigende aanvaller
  vRating := AddRatingBijdrage('TDFW');
  vRating.MID_PM := 0.21701;   //0.200663555076171
  vRating.CA_PASS := 0.470666; //0.350593216445366
  vRating.CA_SC := 0.346607;   //0.365602172938477
  vRating.WA_PASS := 0.220424; //0.258314800652819
  vRating.WA_WING := 0.097975; //0.108702440947177
  vRating.WA_SC := 0.095023;   //0.100208327839456

  // Aanvaller 'Naar de vleugel'
  vRating := AddRatingBijdrage('FTW');
  vRating.CA_PASS := 0.146863;    //0.154848237124548
  vRating.CA_SC := 0.342343;      //0.361066427573112
  vRating.WA_PASS := 0.148148;    //0.156219508979194
  vRating.WA_WING := 0.392185;    //0.459551875390065
  vRating.WA_SC := 0.371022;      //0.391339890825664
  vRating.WA_SC_OTHER := 0.151325;//0.159594947390628
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
