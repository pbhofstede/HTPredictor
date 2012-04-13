unit uSelectie;

interface

uses
  dxmdaset, Contnrs, uPlayer;

type
  TSelectie = class
  private
    FNaam: String;
    FPlayers: TObjectList;
    function GetPlayer(aID:integer):TPlayer;
  public
    procedure LoadFromMemDataSet(aDataSet: TdxMemData; aRefresh: boolean);
    property Players:TObjectList read FPlayers write FPlayers;
    property Naam:String read FNaam write FNaam;
    constructor Create;
    destructor Destroy;override;
  end;

implementation

uses
  db;

{ TSelectie }
{-----------------------------------------------------------------------------
  Procedure: Create
  Author:    Harry
  Date:      13-apr-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
constructor TSelectie.Create;
begin
  FPlayers := TObjectList.Create(TRUE);
end;

{-----------------------------------------------------------------------------
  Procedure: Destroy
  Author:    Harry
  Date:      13-apr-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
destructor TSelectie.Destroy;
begin
  FPlayers.Free;
  inherited;
end;

{-----------------------------------------------------------------------------
  Procedure: GetPlayer
  Author:    Harry
  Date:      13-apr-2012
  Arguments: aID: integer
  Result:    TPlayer
-----------------------------------------------------------------------------}
function TSelectie.GetPlayer(aID: integer): TPlayer;
var
  I: integer;
begin
  result := nil;

  if (Players.Count > 0) then
  begin
    i := 0;
    while ((result = nil) and (i < Players.Count)) do
    begin
      if TPlayer(Players[i]).ID = aID then
      begin
        result := TPlayer(Players[i]);
      end;
      inc(i);
    end;
  end;

  if (result = nil) then
  begin
    result := TPlayer.Create;
    Result.ID := aID;

    Players.Add(result);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: LoadFromMemDataSet
  Author:    Harry
  Date:      13-apr-2012
  Arguments: aDataSet: TdxMemData
  Result:    None
-----------------------------------------------------------------------------}
procedure TSelectie.LoadFromMemDataSet(aDataSet: TdxMemData; aRefresh: boolean);
var
  vBookMark : TBookMark;
  vPlayer: TPlayer;
begin
  if not(aRefresh) then
  begin
    Players.Clear;
  end;

  with aDataSet do
  begin
    vBookMark := GetBookmark;
    DisableControls;
    try
      First;
      while not EOF do
      begin
        vPlayer := GetPlayer(FieldByName('RecID').asInteger);

        vPlayer.Naam := FieldByName('NAAM').asString;
        vPlayer.Spec := FieldByName('SPECIALITEIT').asString;
        vPlayer.Vorm := FieldByName('VORM').asFloat;
        vPlayer.Conditie := FieldByName('CONDITIE').asFloat;
        vPlayer.GK := FieldByName('KEEPEN').asFloat;
        vPlayer.DEF := FieldByName('VERDEDIGEN').asFloat;
        vPlayer.PM := FieldByName('POSITIESPEL').asFloat;
        vPlayer.WNG := FieldByName('VLEUGELSPEL').asFloat;
        vPlayer.PAS := FieldByName('PASSEN').asFloat;
        vPlayer.SCO := FieldByName('SCOREN').asFloat;
        vPlayer.SP := FieldByname('SPELHERVATTEN').asFloat;
        vPlayer.XP := FieldByName('ERVARING').asFloat;

        Next;
      end;
    finally
      GotoBookmark(vBookMark);
      FreeBookmark(vBookMark);
      EnableControls;
    end;
  end;
end;

end.
