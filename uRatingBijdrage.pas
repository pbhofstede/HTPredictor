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
    FWA_PASS: double;
    FWA_SC_OTHER: double;
    FWA_WING: double;
    FWA_SC: double;
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
    property WA_PASS: double read FWA_PASS write FWA_PASS;
    property WA_WING: double read FWA_WING write FWA_WING;
    property WA_SC: double read FWA_SC write FWA_SC;
    property WA_SC_OTHER: double read FWA_SC_OTHER write FWA_SC_OTHER;
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

  if (WA_PASS > 0) then
    inc(result);

  if (WA_WING > 0) then
    inc(result);

  if (WA_SC > 0) then
    inc(result);

  if (WA_SC_OTHER > 0) then
    inc(result);
end;

end.
