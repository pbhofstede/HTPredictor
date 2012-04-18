unit uHTPredictor;

interface

uses
  dxmdaset;

type
  TPlayerPosition = (pOnbekend, pKP, pRB, pRCV, pCV, pLCV, pLB, pRW, pRCM, pCM, pLCM, pLW, pRCA, pCA, pLCA);
  TPlayerOrder = (oNormaal, oVerdedigend, oAanvallend, oNaarVleugel, oNaarMidden);

function ImportSpelers(aXLSFile:String; aPlayerDataSet:TdxMemData):String;
function AllPlayerFieldsMapped(aPlayerDataSet: TdxMemData):boolean;
function OrderToString(aOrder: TPlayerOrder): String;
function PlayerPosToRatingPos(aPosition:TPlayerPosition; aOrder: TPlayerOrder; aSpec: String):String;

implementation

uses
  SysUtils, IniFiles, Forms, uBibExcel, uBibConv, Dialogs, Windows, FormKiesTabSheet;

{-----------------------------------------------------------------------------
  Procedure: AllPlayerFieldsMapped
  Author:    Harry
  Date:      11-apr-2012
  Arguments: aPlayerDataSet: TdxMemData
  Result:    boolean
-----------------------------------------------------------------------------}
function AllPlayerFieldsMapped(aPlayerDataSet: TdxMemData):boolean;
var
  i:integer;
begin
  result := TRUE;

  with TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) do
  begin
    try
      for i:=0 to aPlayerDataSet.Fields.Count - 1 do
      begin
        if (aPlayerDataSet.Fields[i].Required) and (UpperCase(aPlayerDataSet.Fields[i].FieldName) <> 'RECID') then
        begin
          result := result and
            (ReadString('PLAYER_MAPPING',aPlayerDataSet.Fields[i].FieldName,'') <> '');
        end;
      end;
    finally
      Free;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: SavePlayersToMemDataSet
  Author:    Harry
  Date:      11-apr-2012
  Arguments: aPlayerDataSet: TdxMemData
  Result:    integer
-----------------------------------------------------------------------------}
function SavePlayersToMemDataSet(aExcelSheet: TExcelFunctions; aPlayerDataSet: TdxMemData):integer;
var
  i, j, vCount: integer;
  vStaminaColumn, vStamina: String;
  vIni: TIniFile;
begin
  result := 0;
  aExcelSheet.ExcelApp.ActiveSheet.Range['A1'].Select;
  vCount := aExcelSheet.ExcelApp.ActiveSheet.UsedRange.Rows.Count;

  if (vCount > 0) then
  begin
    vIni := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
    try
      vStaminaColumn := vIni.ReadString('PLAYER_MAPPING','CONDITIE','');
      if (vStaminaColumn <> '') then
      begin
        for i:=1 to vCount - 1 do
        begin
          try
            vStamina := aExcelSheet.GetCellRange(Format('%s%d', [vStaminaColumn, i]));

            if (uBibConv.AnyStrToFloat(vStamina) > 0) then
            begin
              aPlayerDataSet.Append;
              aPlayerDataSet.FieldByName('LAND').asString := aExcelSheet.ExcelApp.ActiveSheet.Name;

              for j:=0 to aPlayerDataSet.Fields.Count - 1 do
              begin
                if (aPlayerDataSet.Fields[j].Required) then
                begin
                  aPlayerDataSet.Fields[j].Value :=
                    aExcelSheet.GetCellRange(Format('%s%d', [vIni.ReadString('PLAYER_MAPPING',aPlayerDataSet.Fields[j].FieldName,''), i]));
                end;
              end;

              aPlayerDataSet.Post;
            end;
          except
            ShowMessage('Fout bij toevoegen regel '+IntToStr(i) + ' van '+aExcelSheet.ExcelApp.ActiveSheet.Name);
            raise;
          end;
        end;
      end;
    finally
      vIni.Free;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: ImportSpelers
  Author:    Harry
  Date:      11-apr-2012
  Arguments: aXLSFile:String
  Result:    integer
-----------------------------------------------------------------------------}
function ImportSpelers(aXLSFile:String; aPlayerDataSet:TdxMemData):String;
var
  vExcel: TExcelFunctions;
  vSheets, i: integer;
begin
  result := '';
  
  if not(aPlayerDataSet.Active) then
  begin
    aPlayerDataSet.Open;
  end;

  aPlayerDataSet.DisableControls;
  try
    vExcel := uBibExcel.TExcelFunctions.Create(FALSE);
    with vExcel do
    begin
      try
        Open(aXLSFile);
        try
          vSheets := ExcelApp.ActiveWorkbook.Worksheets.Count;

          result := FormKiesTabSheet.KiesTabsheet(vExcel);

          if (result <> '') then
          begin
            for i := 1 to vSheets do
            begin
              ExcelApp.ActiveWorkbook.Worksheets[i].Activate;
              if vExcel.ExcelApp.ActiveSheet.Name = result then
              begin
                SavePlayersToMemDataSet(vExcel, aPlayerDataSet);
              end;
            end;
          end;
        finally
          CloseActiveWorkbook(FALSE);
        end;
      finally
        Free;
      end;
    end;
  finally
    aPlayerDataSet.EnableControls;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function OrderToString(aOrder: TPlayerOrder): String;
begin
  case aOrder of
    oNormaal:     Result := 'Normaal';
    oVerdedigend: Result := 'Verdedigend';
    oAanvallend:  Result := 'Aanvallend';
    oNaarVleugel: Result := 'Naar de vleugel';
    oNaarMidden:  Result := 'Naar het midden';
    else
      Result := 'Order onbekend';
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: PlayerPosToRatingPos
  Author:    Harry
  Date:      18-apr-2012
  Arguments: aPosition:TPlayerPosition; aOrder: TPlayerOrder
  Result:    String
-----------------------------------------------------------------------------}
function PlayerPosToRatingPos(aPosition:TPlayerPosition; aOrder: TPlayerOrder; aSpec: String):String;
begin
  //  TPlayerPosition = (pOnbekend, pKP, pRB, pRCV, pCV, pLCV, pLB, pRW, pRCM, pCM, pLCM, pLW, pRCA, pCA, pLCA);
  //TPlayerOrder = (oNormaal, oVerdedigend, oAanvallend, oNaarVleugel, oNaarMidden);
  result := '';

  case aPosition of
    pKP: result := 'K';
    pRB, pLB:
    begin
      case aOrder of
        oNormaal : result := 'NWB';
        oVerdedigend : result := 'DWB';
        oAanvallend : result := 'OWB';
        oNaarMidden : result := 'WBTM';
      end;
    end;
    pRCV, pCV, pLCV:
    begin
      case aOrder of
        oNormaal: result := 'CD';
        oAanvallend : result := 'OCD';
        oNaarVleugel : result := 'CDTW';
      end;
    end;
    pRCM, pCM, pLCM:
    begin
      case aOrder of
        oNormaal: result := 'IM';
        oAanvallend : result := 'OIM';
        oVerdedigend: result := 'DIM';
        oNaarVleugel : result := 'IMTW';
      end;
    end;
    pRW, pLW:
    begin
      case aOrder of
        oNormaal : result := 'NW';
        oAanvallend: result := 'OW';
        oVerdedigend: result := 'DW';
        oNaarMidden : result := 'WTM';
      end;
    end;
    pRCA, pLCA, pCA:
    begin
      case aOrder of
        oNormaal: result := 'FW';
        oVerdedigend:
        begin
          if (aSpec = 'T') then
          begin
            result := 'TDFW';
          end
          else
          begin
            result := 'DFW';
          end;
        end;
        oNaarVleugel: result := 'FTW';
      end;
    end;
  end;
end;


end.
