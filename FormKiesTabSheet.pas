unit FormKiesTabSheet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxControls, cxInplaceContainer, cxTL, uBibExcel;

type
  TfrmKiesTabsheet = class(TForm)
    cxtrlTabsheets: TcxTreeList;
    cxtrlTabsheetscxTreeListColumn1: TcxTreeListColumn;
    procedure cxtrlTabsheetsDblClick(Sender: TObject);
  private
    FExcelSheet: TExcelFunctions;
    FChosenSheet: String;
    procedure SetExcelSheet(const Value: TExcelFunctions);
    { Private declarations }
  public
    { Public declarations }
    property ExcelSheet: TExcelFunctions read FExcelSheet write SetExcelSheet;
    property ChosenSheet: String read FChosenSheet write FChosenSheet;
  end;


  function KiesTabsheet(aExcelSheet:TExcelFunctions):String;

implementation


{$R *.DFM}

{-----------------------------------------------------------------------------
  Procedure: KiesTabsheet
  Author:    Harry
  Date:      12-apr-2012
  Arguments: aExcelSheet:TExcelFunctions
  Result:    None
-----------------------------------------------------------------------------}
function KiesTabsheet(aExcelSheet:TExcelFunctions):String;
begin
  result := '';
  with TfrmKiesTabsheet.Create(nil) do
  begin
    try
      ExcelSheet := aExcelSheet;
      if ShowModal = mrOk then
      begin
        result := ChosenSheet;
      end;
    finally
      Free;
    end;
  end;
end;

{ TfrmKiesTabsheet }

{-----------------------------------------------------------------------------
  Procedure: SetExcelSheet
  Author:    Harry
  Date:      12-apr-2012
  Arguments: const Value: TExcelFunctions
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmKiesTabsheet.SetExcelSheet(const Value: TExcelFunctions);
var
  i:integer;
begin
  FExcelSheet := Value;
  for i:=1 to FExcelSheet.ExcelApp.ActiveWorkbook.Worksheets.Count do
  begin
    with cxtrlTabsheets.Add do
    begin
      Values[0] := FExcelSheet.ExcelApp.ActiveWorkbook.Worksheets[i].Name;
    end;
  end;
end;

procedure TfrmKiesTabsheet.cxtrlTabsheetsDblClick(Sender: TObject);
begin
  ChosenSheet := cxtrlTabsheets.FocusedNode.Texts[0];
  ModalResult := mrOk;
end;

end.
