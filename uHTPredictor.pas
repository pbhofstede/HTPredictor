unit uHTPredictor;

interface

uses
  dxmdaset;

type
  TPlayerPosition = (pOnbekend, pKP, pRB, pRCV, pCV, pLCV, pLB, pRW, pRCM, pCM, pLCM, pLW, pRCA, pCA, pLCA);
  TPlayerOrder = (oNormaal, oVerdedigend, oAanvallend, oNaarVleugel, oNaarMidden);
  TTeamZelfvertrouwen = (zNietBestaand, zRampzalig, zWaardeloos, zSlecht, zBehoorlijk, zSterk, zWonderbaarlijk, zLichtelijkOverdreven, zOverdreven, zCompleetOverdreven);
  TTeamSpirit = (sKoudeOorlog, sMoorddadig, sWoedend, sGeirriteerd, sBedaard, sKalm, sContent, sTevreden, sDolgelukkig, sInDeWolken, sParadijsOpAarde);
  TOpstellingMotivatie = (mNormaal, mPIC, mMOTS);
  TOpstellingTactiek = (tNormaal, tPressie, tCounter, tCentrumAanval, tVleugelAanval, tCreatiefSpel, tAfstandsSchoten);
  TOpstellingCoach = (cNeutraal, cVerdedigend, cAanvallend);
  TWedstrijdPlaats = (wThuis, wDerby, wUit);

function ImportSpelers(aXLSFile:String; aPlayerDataSet:TdxMemData):String;
function AllPlayerFieldsMapped(aPlayerDataSet: TdxMemData):boolean;
function OrderToString(aOrder: TPlayerOrder): String;
function WedstrijdPlaatsToString(aWedstrijdPlaats: TWedstrijdPlaats): String;
function TeamZelfvertrouwenToString(aTeamZelfvertrouwen: TTeamZelfvertrouwen): String;    
function TeamSpiritToString(aTeamSpirit: TTeamSpirit): String;
function PlayerPosToRatingPos(aPosition:TPlayerPosition; aOrder: TPlayerOrder; aSpec: String):String;
function FormatRating(aRating, aPrevRating: double): String;

implementation

uses
  SysUtils, IniFiles, Forms, uBibExcel, uBibConv, Dialogs, Windows, FormKiesTabSheet, Math;

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
  vValue: Variant;
begin
  result := 0;
  aExcelSheet.ExcelApp.ActiveSheet.Range['A1'].Select;

  //fix nav. niet importeren van de onderste 2 spelers.
  vCount := aExcelSheet.ExcelApp.ActiveSheet.UsedRange.Rows.Count + 1;

  if (vCount > 0) then
  begin
    vIni := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
    try
      vStaminaColumn := vIni.ReadString('PLAYER_MAPPING','CONDITIE','');
      if (vStaminaColumn <> '') then
      begin
        for i:=1 to vCount do
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
                  vValue := aExcelSheet.GetCellRange(Format('%s%d', [vIni.ReadString('PLAYER_MAPPING',aPlayerDataSet.Fields[j].FieldName,''), i])).Value;

                  if (aPlayerDataSet.Fields[j].FieldName = 'LOYALITEIT') then
                  begin
                    if uBibConv.StringIsInteger(vValue) then
                    begin
                      vValue := uBibConv.AnyStrToInt(vValue);
                    end
                    else
                    begin
                      vValue := 0;
                    end;
                  end;

                  if (aPlayerDataSet.Fields[j].FieldName = 'VORM') or
                     (aPlayerDataSet.Fields[j].FieldName = 'CONDITIE') or
                     (aPlayerDataSet.Fields[j].FieldName = 'KEEPEN') or
                     (aPlayerDataSet.Fields[j].FieldName = 'VERDEDIGEN') or
                     (aPlayerDataSet.Fields[j].FieldName = 'POSITIESPEL') or
                     (aPlayerDataSet.Fields[j].FieldName = 'VLEUGELSPEL') or
                     (aPlayerDataSet.Fields[j].FieldName = 'PASSEN') or
                     (aPlayerDataSet.Fields[j].FieldName = 'SCOREN') or
                     (aPlayerDataSet.Fields[j].FieldName = 'SPELHERVATTEN') or
                     (aPlayerDataSet.Fields[j].FieldName = 'ERVARING') or
                     (aPlayerDataSet.Fields[j].FieldName = 'LOYALITEIT') then
                  begin
                    if uBibConv.AnyStrToInt(vValue) > 0 then
                    begin
                      if (Floor(vValue) = vValue) and
                         ((vValue < 8) or
                          (((aPlayerDataSet.Fields[j].FieldName = 'ERVARING') or
                            (aPlayerDataSet.Fields[j].FieldName = 'LOYALITEIT')) and
                           (vValue < 20))) then
                      begin
                        vValue := vValue + 0.5;
                      end;
                    end;
                  end;
                  aPlayerDataSet.Fields[j].Value := vValue;
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


function WedstrijdPlaatsToString(aWedstrijdPlaats: TWedstrijdPlaats): String;
begin
  case aWedstrijdPlaats of
    wThuis:     Result := 'Thuis';
    wDerby:     Result := 'Derby';
    wUit:       Result := 'Uit';
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     20-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TeamZelfvertrouwenToString(aTeamZelfvertrouwen: TTeamZelfvertrouwen): String;
begin
  case aTeamZelfvertrouwen of
    zNietBestaand:          Result := 'niet bestaand';
    zRampzalig:             Result := 'rampzalig';
    zWaardeloos:            Result := 'waardeloos';
    zSlecht:                Result := 'slecht';
    zBehoorlijk:            Result := 'behoorlijk';
    zSterk:                 Result := 'sterk';
    zWonderbaarlijk:        Result := 'wonderbaarlijk';
    zLichtelijkOverdreven:  Result := 'lichtelijk overdreven';
    zOverdreven:            Result := 'overdreven';
    zCompleetOverdreven:    Result := 'compleet overdreven';
  end;
end;

function TeamSpiritToString(aTeamSpirit: TTeamSpirit): String;
begin
  case aTeamSpirit of
    sKoudeOorlog:       Result := 'als in de Koude Oorlog';
    sMoorddadig:        Result := 'moorddadig';
    sWoedend:           Result := 'woedend';
    sGeirriteerd:       Result := 'geïrriteerd';
    sBedaard:           Result := 'bedaard';
    sKalm:              Result := 'kalm';
    sContent:           Result := 'content';
    sTevreden:          Result := 'tevreden';
    sDolgelukkig:       Result := 'dolgelukkig';
    sInDeWolken:        Result := 'in de wolken';
    sParadijsOpAarde:   Result := 'paradijs op aarde!';
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

  if (Result = '') then
  begin
    ShowMessage('geen result bij PlayerPosToRatingPos!');
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     20-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function FormatRating(aRating, aPrevRating: double): String;
var
  vIntRating: integer;
  vResultStr: String;
begin
  //Ceil, dus naar boven afronden.
  //0 -> 0 -> niet-bestaand
  //24,4 -> 6,1 -> 7 -> goed
  vIntRating := Ceil(aRating / 4);

  case vIntRating of
    0: vResultStr := 'niet-bestaand';
    1: vResultStr := 'rampzalig';
    2: vResultStr := 'waardeloos';
    3: vResultStr := 'slecht';
    4: vResultStr := 'zwak';
    5: vResultStr := 'matig';
    6: vResultStr := 'redelijk';
    7: vResultStr := 'goed';
    8: vResultStr := 'uitstekend';  
    9: vResultStr := 'formidabel';
    10: vResultStr := 'uitmuntend';
    11: vResultStr := 'briljant';
    12: vResultStr := 'wonderbaarlijk';
    13: vResultStr := 'wereldklasse';
    14: vResultStr := 'bovennatuurlijk';
    15: vResultStr := 'reusachtig';
    16: vResultStr := 'buitenaards';
    17: vResultStr := 'mythisch';
    18: vResultStr := 'magisch';
    19: vResultStr := 'utopisch';
    20: vResultStr := 'goddelijk';
    21: vResultStr := 'goddelijk+';
    22: vResultStr := 'goddelijk++';
    23: vResultStr := 'goddelijk+++';
    24: vResultStr := 'goddelijk++++';
    else
      vResultStr := vResultStr + 'huh??';
  end;

  vIntRating := Floor(aRating);
  case vIntRating mod 4 of
    0: vResultStr := vResultStr + ' (zeer laag)';
    1: vResultStr := vResultStr + ' (laag)';
    2: vResultStr := vResultStr + ' (hoog)';
    3: vResultStr := vResultStr + ' (zeer hoog)';
    else
      vResultStr := vResultStr + ' (huh??)';
  end;

  Result := Format('%.2f', [aRating]);
  if (aRating < 10) then
  begin
    Result := '0' + Result;
  end;

  if (aRating <> aPrevRating) then
  begin
    if (aRating > aPrevRating) then
    begin
      Result := Format('%s (+%.2f)', [Result, aRating - aPrevRating]) + #9;
    end
    else
    begin
      Result := Format('%s (%.2f)', [Result, aRating - aPrevRating]) + #9;
    end;
  end
  else
  begin
    Result := Result + #9#9;
  end;

  Result := Result + vResultStr;
end;
end.
