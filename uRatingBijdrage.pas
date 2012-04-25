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
    procedure LoadFromXLS(aWorkSheet: Variant; aRow: integer);
    procedure ExportToXLS(aWorkSheet: Variant; var aRow: integer);

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

{-----------------------------------------------------------------------------
  Procedure: ExportToXLS
  Author:    Harry
  Date:      24-apr-2012
  Arguments: aWorkSheet: Varian; aRow: integer
  Result:    None
-----------------------------------------------------------------------------}
procedure TRatingBijdrage.ExportToXLS(aWorkSheet: Variant; var aRow: integer);
begin
  aWorksheet.Activate;
  if (aRow = 0) then
  begin
    aWorksheet.Range['A1'].Value := 'POSITIE';

    aWorksheet.Range['B1'].Value := 'Mid-PM';
    aWorksheet.Range['C1'].Value := 'CD-GK';
    aWorksheet.Range['D1'].Value := 'CD-Def';
    aWorksheet.Range['E1'].Value := 'WB-GK';
    aWorksheet.Range['F1'].Value := 'WB-Def';
    aWorksheet.Range['G1'].Value := 'CA-Pass';
    aWorksheet.Range['H1'].Value := 'CA-Scor';
    aWorksheet.Range['I1'].Value := 'WI-Pass';
    aWorksheet.Range['J1'].Value := 'WI-Wing';
    aWorksheet.Range['K1'].Value := 'WI-Scor';
    aWorksheet.Range['L1'].Value := 'WI-Scor(other)';
    inc(aRow);
  end;

  inc(aRow);
  aWorksheet.Range[Format('A%d',[aRow])].Value := Positie;
  if (MID_PM > 0) then
    aWorksheet.Range[Format('B%d',[aRow])].Value := MID_PM;
  if (CD_GK > 0) then
    aWorksheet.Range[Format('C%d',[aRow])].Value := CD_GK;
  if (CD_DEF > 0) then
    aWorksheet.Range[Format('D%d',[aRow])].Value := CD_DEF;
  if (WB_GK > 0) then
    aWorksheet.Range[Format('E%d',[aRow])].Value := WB_GK;
  if (WB_DEF > 0) then
    aWorksheet.Range[Format('F%d',[aRow])].Value := WB_DEF;
  if (CA_PASS > 0) then
    aWorksheet.Range[Format('G%d',[aRow])].Value := CA_PASS;
  if (CA_SC > 0) then
    aWorksheet.Range[Format('H%d',[aRow])].Value := CA_SC;
  if (WA_PASS > 0) then
    aWorksheet.Range[Format('I%d',[aRow])].Value := WA_PASS;
  if (WA_WING > 0) then
    aWorksheet.Range[Format('J%d',[aRow])].Value := WA_WING;
  if (WA_SC > 0) then
    aWorksheet.Range[Format('K%d',[aRow])].Value := WA_SC;
  if (WA_SC_OTHER > 0) then
    aWorksheet.Range[Format('L%d',[aRow])].Value := WA_SC_OTHER;
end;

{-----------------------------------------------------------------------------
  Procedure: LoadFromXLS
  Author:    Harry
  Date:      25-apr-2012
  Arguments: aWorkSheet: Variant; var aRow: integer
  Result:    None
-----------------------------------------------------------------------------}
procedure TRatingBijdrage.LoadFromXLS(aWorkSheet: Variant;
  aRow: integer);
begin
  MID_PM := aWorksheet.Range[Format('B%d',[aRow])];
  CD_GK := aWorksheet.Range[Format('C%d',[aRow])];
  CD_DEF := aWorksheet.Range[Format('D%d',[aRow])];
  WB_GK := aWorksheet.Range[Format('E%d',[aRow])];
  WB_DEF := aWorksheet.Range[Format('F%d',[aRow])];
  CA_PASS := aWorksheet.Range[Format('G%d',[aRow])];
  CA_SC := aWorksheet.Range[Format('H%d',[aRow])];
  WA_PASS := aWorksheet.Range[Format('I%d',[aRow])];
  WA_WING := aWorksheet.Range[Format('J%d',[aRow])];
  WA_SC := aWorksheet.Range[Format('K%d',[aRow])];
  WA_SC_OTHER := aWorksheet.Range[Format('L%d',[aRow])];
end;

end.
