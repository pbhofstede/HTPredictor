unit uOpstelling;

interface

uses
  Contnrs, uSelectie, uPlayer, uHTPredictor, Forms;

type
  TOpstelling = class
  private
    FFormOpstelling: TForm;
    FSelectie: TSelectie;
    FOpstellingPlayerArray: array[1..14] of TPlayer;
    FOpstellingOrderArray: array[1..14] of TPlayerOrder;
    procedure SetSelectie(const Value: TSelectie);
  public
    property Selectie: TSelectie read FSelectie write SetSelectie;
    constructor Create(aFormOpstelling: TForm);
    destructor Destroy; override;

    function GetPositionOfPlayer(aPlayer: TPlayer): TPlayerPosition;
    procedure ZetPlayerIDOpPositie(aPlayerID: integer; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);
    function AantalPositiesBezet: integer;
  end;


implementation
uses
  FormOpstelling;


{ TOpstelling }
{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.AantalPositiesBezet: integer;
var
  vCount: integer;
begin
  Result := 0;

  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if FOpstellingPlayerArray[vCount] <> nil then
    begin
      Inc(Result);
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
constructor TOpstelling.Create(aFormOpstelling: TForm);
begin
  FFormOpstelling := aFormOpstelling;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
destructor TOpstelling.Destroy;
begin
  inherited;

end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TOpstelling.GetPositionOfPlayer(aPlayer: TPlayer): TPlayerPosition;
var
  vCount: integer;
begin
  Result := pOnbekend;
  vCount := Low(FOpstellingPlayerArray);

  while (Result = pOnbekend) and
        (vCount <= High(FOpstellingPlayerArray)) do
  begin
    if (FOpstellingPlayerArray[vCount] = aPlayer) then
    begin
      Result := TPlayerPosition(vCount);
    end;

    Inc(vCount);
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TOpstelling.SetSelectie(const Value: TSelectie);
begin
  FSelectie := Value;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TOpstelling.ZetPlayerIDOpPositie(aPlayerID: integer; aPositie: TPlayerPosition; aPlayerOrder: TPlayerOrder);
var
  vPlayer: TPlayer;
begin
  vPlayer := Selectie.GetPlayer(aPlayerID);
  
  FOpstellingPlayerArray[Ord(aPositie)] := vPlayer;  
  FOpstellingOrderArray[Ord(aPositie)] := aPlayerOrder;

  (FFormOpstelling as TfrmOpstelling).EnableDisableOpstellingPlayer;
end;

end.
