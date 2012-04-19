unit uSelectie;

interface

uses
  dxmdaset, Contnrs, uPlayer, uRatingBijdrages;

type
  TSelectie = class
  private
    FNaam: String;
    FPlayers: TObjectList;
    FRatingBijdrages: TRatingBijdrages;
  public
    procedure UpdateOpstellingen;                           
    function GetPlayer(aID:integer):TPlayer;
    procedure LoadFromMemDataSet(aDataSet: TdxMemData; aRefresh: boolean);
    property Players:TObjectList read FPlayers write FPlayers;
    property Naam:String read FNaam write FNaam;
    property RatingBijdrages: TRatingBijdrages read FRatingBijdrages write FRatingBijdrages;
    constructor Create;
    destructor Destroy;override;
  end;

implementation

uses
  db, Dialogs;

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

        if (vPlayer = nil) then
        begin
          vPlayer := TPlayer.Create;
          vPlayer.ID := FieldByName('RecID').asInteger;
          vPlayer.Selectie := Self;

          Players.Add(vPlayer);
        end;

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

{-----------------------------------------------------------------------------
  Procedure: UpdateOpstellingen
  Author:    Harry
  Date:      19-apr-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TSelectie.UpdateOpstellingen;
begin
  // Todo!!!!
  ShowMessage('Opstellingen doorrekenen!!');
end;

end.
