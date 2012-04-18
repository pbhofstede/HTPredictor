unit uRatingBijdrage;

interface

type
  TRatingBijdrage = class
  private
    FPositie: String;
    FMid_PM: double;
    FCD_GK: double;
    FCD_DEF: double;
    FWB_GK: double;
    FWB_DEF: double;
    FCA_PASS: double;
    FCA_SC: double;
    FWING_PASS: double;
    FWING_SC_OTHER: double;
    FWING_WING: double;
    FWING_SC: double;
    procedure SetPositie(const Value: String);
    function GetCount: integer;
  public
    property Count:integer read GetCount;
    property MID_PM: double read FMid_PM write FMid_PM;
    property CD_GK: double read FCD_GK write FCD_GK;
    property CD_DEF: double read FCD_DEF write FCD_DEF;
    property WB_GK: double read FWB_GK write FWB_GK;
    property WB_DEF: double read FWB_DEF write FWB_DEF;
    property CA_PASS: double read FCA_PASS write FCA_PASS;
    property CA_SC: double read FCA_SC write FCA_SC;
    property WING_PASS: double read FWING_PASS write FWING_PASS;
    property WING_WING: double read FWING_WING write FWING_WING;
    property WING_SC: double read FWING_SC write FWING_SC;
    property WING_SC_OTHER: double read FWING_SC_OTHER write FWING_SC_OTHER;
    property Positie:String read FPositie write SetPositie;
  end;

implementation

uses
  SysUtils;

{ TRatingBijdrage }

{-----------------------------------------------------------------------------
  Procedure: SetPositie
  Author:    Harry
  Date:      18-apr-2012
  Arguments: const Value: String
  Result:    None
-----------------------------------------------------------------------------}
procedure TRatingBijdrage.SetPositie(const Value: String);
begin
  FPositie := UpperCase(Value);
end;

{-----------------------------------------------------------------------------
  Procedure: GetCount
  Author:    Harry
  Date:      18-apr-2012
  Arguments: None
  Result:    integer
-----------------------------------------------------------------------------}
function TRatingBijdrage.GetCount: integer;
begin
  result := 0;
  if (MID_PM > 0) then
    inc(result);

  if (CD_GK > 0) then
    inc(result);

  if (CD_DEF > 0) then
    inc(result);

  if (WB_GK > 0) then
    inc(result);

  if (WB_DEF > 0) then
    inc(result);

  if (CA_PASS > 0) then
    inc(result);

  if (CA_SC > 0) then
    inc(result);

  if (WING_PASS > 0) then
    inc(result);

  if (WING_WING > 0) then
    inc(result);

  if (WING_SC > 0) then
    inc(result);

  if (WING_SC_OTHER > 0) then
    inc(result);
end;

end.
