unit FormOpstelling;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, uHTPredictor,
  ExtCtrls, uSelectie, uOpstelling, FormOpstellingPlayer, StdCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxImageComboBox, cxCurrencyEdit, cxPC, OleCtrls, ComCtrls, JvComponent,
  JvUrlListGrabber, JvUrlGrabbers, Buttons, JvSimpleXml, dxmdaset,
  IdBaseComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdComponent;

type
  TfrmOpstelling = class(TFrame)
    pnlRatings: TPanel;
    pnlOpstelling: TPanel;
    cxpgctrlRatings: TcxPageControl;
    tbshtRatings: TcxTabSheet;
    tbshtVoorspelling: TcxTabSheet;
    pnlRatingsMain: TPanel;
    lblRV: TLabel;
    lblLinkerVerdediging: TLabel;
    lblLV: TLabel;
    lblRechterVerdediging: TLabel;
    Label1: TLabel;
    lblCV: TLabel;
    lblRA: TLabel;
    lblLinkerAanval: TLabel;
    lblLA: TLabel;
    lblRechterAanval: TLabel;
    lblCentraleAanval: TLabel;
    lblCA: TLabel;
    lblMiddenveld: TLabel;
    lblIM: TLabel;
    lblHatStatsCaption: TLabel;
    lblHatStats: TLabel;
    lblMotivatie: TLabel;
    lblTactiek: TLabel;
    lblCoach: TLabel;
    cbMotivatie: TcxImageComboBox;
    cbTactiek: TcxImageComboBox;
    cbCoach: TcxImageComboBox;
    pnlHandmatig: TPanel;
    edMID: TcxCurrencyEdit;
    edRV: TcxCurrencyEdit;
    edCV: TcxCurrencyEdit;
    edLV: TcxCurrencyEdit;
    edRA: TcxCurrencyEdit;
    edCA: TcxCurrencyEdit;
    edLA: TcxCurrencyEdit;
    lblTacticLevel: TLabel;
    pnlVoorspelling: TPanel;
    spdbtnGetVoorspelling: TSpeedButton;
    lblWinst: TLabel;
    lblGelijk: TLabel;
    lblVerlies: TLabel;
    JvPrediction: TJvHttpUrlGrabber;
    jvXML: TJvSimpleXML;
    lblWinstPerc: TLabel;
    lblGelijkPerc: TLabel;
    lblVerliesPerc: TLabel;
    lblUitslag: TLabel;
    lblTeam1: TLabel;
    lblTeam2: TLabel;
    Label2: TLabel;
    lblBBZ1: TLabel;
    lblBBZ2: TLabel;
    Label3: TLabel;
    lblKansen1: TLabel;
    lblKansen2: TLabel;
    Label4: TLabel;
    lblLinks1: TLabel;
    lblLinks2: TLabel;
    Label5: TLabel;
    lblCentrum1: TLabel;
    lblCentrum2: TLabel;
    Label6: TLabel;
    lblRechts1: TLabel;
    lblRechts2: TLabel;
    Label7: TLabel;
    lblSH1: TLabel;
    lblSH2: TLabel;
    Label8: TLabel;
    lblGoals1: TLabel;
    lblGoals2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label9: TLabel;
    lblWinst1: TLabel;
    lblWinst2: TLabel;
    lblTeamsGelijk: TLabel;
    lblWinstDiff: TLabel;
    lblGelijkDiff: TLabel;
    lblVerliesDiff: TLabel;
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Memo1: TMemo;
    procedure cbMotivatiePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbTactiekPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbCoachPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure edPropertiesChange(Sender: TObject);
    procedure spdbtnGetVoorspellingClick(Sender: TObject);
    procedure JvPredictionDoneStream(Sender: TObject; Stream: TStream;
      StreamSize: Integer; Url: String);
    procedure Button1Click(Sender: TObject);
  private
    FLaatsteWinst, FLaatsteVerlies, FLaatsteGelijk: double;
    FBusy: boolean;
    FSelectie: TSelectie;
    FOpstelling: TOpstelling;
    FMID: double;
    FRV: double;
    FCV: double;
    FLV: double;
    FRA: double;
    FCA: double;
    FLA: double;
    FMemData: TdxMemData;
    procedure SetSelectie(const Value: TSelectie);
    procedure FreeObjecten;
    procedure ShowResults;
    procedure ShowDetailedResults;
    procedure ClearVoorspelling;
    function GetVerschil(aNewWaarde, aOldWaarde: double): String;
    function Team1: TOpstelling;
    function Team2: TOpstelling;
    { Private declarations }
  public
    { Public declarations }  
    FOpstellingPlayerArray: array[1..14] of TfrmOpstellingPlayer; 
    FOpstellingAanvoerder: TfrmOpstellingPlayer;                     
    FOpstellingSpelhervatter: TfrmOpstellingPlayer;
    property MemData: TdxMemData read FMemData write FMemData;
    property Selectie: TSelectie read FSelectie write SetSelectie;
    property Opstelling: TOpstelling read FOpstelling;
    procedure EnableDisableOpstellingPlayer;
    procedure UpdateAanvoerder;
    procedure UpdateSpelhervatter;
                             
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateRatings;
    procedure NeemGegevensOver(aOpstellingForm: TfrmOpstelling);
  end;


function ToonOpstelling(aParent: TWinControl; aSelectie: TSelectie; aResultSet: TdxMemData): TfrmOpstelling;

implementation
uses
  Math, uPlayer, IdMultipartFormData, uBibString;

{$R *.DFM}


function ToonOpstelling(aParent: TWinControl; aSelectie: TSelectie; aResultSet: TdxMemData): TfrmOpstelling;
begin

  Result := TfrmOpstelling.Create(nil);

  Result.Parent := aParent;

  Result.Selectie := aSelectie;
  Result.MemData := aResultSet;

  Result.Align := alClient;
end;
                                   
{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.EnableDisableOpstellingPlayer;
var
  vDisable: Boolean;
  vCount: integer;
begin
  vDisable := FOpstelling.AantalPositiesBezet = 11;

  if (FOpstelling.AantalPositiesBezet = 10) and
     (FOpstelling.GetPlayerOnPosition(pKP) = nil) then
  begin
    vDisable := TRUE;
  end;
  
  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    //een keeper moet altijd opgesteld kunnen worden
    if TPlayerPosition(vCount) <> pKP then
    begin
      if (FOpstellingPlayerArray[vCount].cbPlayer.EditValue = Null) or
         (FOpstellingPlayerArray[vCount].cbPlayer.EditValue = -1) then
      begin
        FOpstellingPlayerArray[vCount].cbPlayer.Enabled := not vDisable;
        FOpstellingPlayerArray[vCount].cbOrder.Enabled := not vDisable;
      end;
    end;
  end;
end;


{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.SetSelectie(const Value: TSelectie);
begin
  FreeObjecten;

  FSelectie := Value;

  pnlHandmatig.Visible := not FSelectie.EigenSelectie;
  tbshtVoorspelling.TabVisible := FSelectie.EigenSelectie;
  pnlVoorspelling.Visible := FSelectie.EigenSelectie;

  FOpstelling := TOpstelling.Create(Self);
  FOpstelling.Selectie := Selectie;

  cbMotivatie.ItemIndex := Ord(mNormaal);
  cbTactiek.ItemIndex := Ord(tNormaal);
  cbCoach.ItemIndex := Ord(cNeutraal);

  FOpstellingPlayerArray[1] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pKP);
  FOpstellingPlayerArray[2] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pRB);
  FOpstellingPlayerArray[3] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pRCV);
  FOpstellingPlayerArray[4] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pCV);
  FOpstellingPlayerArray[5] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pLCV);
  FOpstellingPlayerArray[6] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pLB);
  FOpstellingPlayerArray[7] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pRW);
  FOpstellingPlayerArray[8] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pRCM);
  FOpstellingPlayerArray[9] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pCM);
  FOpstellingPlayerArray[10] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pLCM);
  FOpstellingPlayerArray[11] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pLW);
  FOpstellingPlayerArray[12] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pRCA);
  FOpstellingPlayerArray[13] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pCA);
  FOpstellingPlayerArray[14] := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, pLCA);


  FOpstellingAanvoerder := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, TRUE);
  FOpstellingSpelhervatter := FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, FOpstelling, FALSE);

  pnlVoorspelling.Top := FOpstellingAanvoerder.Top;
  pnlVoorspelling.Left := FOpstellingPlayerArray[5].Left;
  pnlVoorspelling.Height := FOpstellingAanvoerder.Height;
  pnlVoorspelling.Width := (FOpstellingPlayerArray[6].Left + FOpstellingPlayerArray[6].Width) -
             FOpstellingPlayerArray[5].Left;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.UpdateAanvoerder;
begin
  if (FOpstellingAanvoerder <> nil) then
  begin
    if (FOpstelling.Aanvoerder = nil) then
    begin
      FOpstellingAanvoerder.cbPlayer.ItemIndex := -1;
    end
    else
    begin
      //if (FOpstellingAanvoerder.cbPlayer.ItemIndex <> FOpstelling.Aanvoerder.ID) then
      //begin
      //  FOpstellingAanvoerder.cbPlayer.ItemIndex := FOpstelling.Aanvoerder.ID;
      //end;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.UpdateSpelhervatter;
begin
  if (FOpstellingSpelhervatter <> nil) then
  begin
    if (FOpstelling.Spelhervatter = nil) then
    begin
      FOpstellingSpelhervatter.cbPlayer.ItemIndex := -1;
    end
    else
    begin
      //if FOpstellingSpelhervatter.cbPlayer.ItemIndex <> FOpstelling.Spelhervatter.ID then
      //begin
      //  FOpstellingSpelhervatter.cbPlayer.ItemIndex := FOpstelling.Spelhervatter.ID;
      //end;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.FreeObjecten;
//var
//  vCount: integer;
begin
{
  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if (FOpstellingPlayerArray[vCount] <> nil) then
    begin
      FOpstellingPlayerArray[vCount].Close;
      FOpstellingPlayerArray[vCount].Release;
      FOpstellingPlayerArray[vCount] := nil;
    end;
  end;

  if (FOpstellingAanvoerder <> nil) then
  begin
    FOpstellingAanvoerder.Close;
    FOpstellingAanvoerder.Release;
    FOpstellingAanvoerder := nil;
  end;

  if (FOpstellingSpelhervatter <> nil) then
  begin
    FOpstellingSpelhervatter.Close;
    FOpstellingSpelhervatter.Release;
    FOpstellingSpelhervatter := nil;
  end;
 }
  if (FOpstelling <> nil) then
  begin
    FOpstelling.Free;
    FOpstelling := nil;
  end;
end;

procedure TfrmOpstelling.UpdateRatings;
var
  vTacticLevel,
  vMID,
  vRV,
  vCV,
  vLV,
  vRA,
  vCA,
  vLA,
  vTotRating: double;
begin
  ClearVoorspelling;

  vMID := FOpstelling.MID;
  vRV := FOpstelling.RV;
  vCV := FOpstelling.CV;
  vLV := FOpstelling.LV;
  vRA := FOpstelling.RA;
  vCA := FOpstelling.CA;
  vLA := FOpstelling.LA;

  lblIM.Caption := uHTPredictor.FormatRating(vMID, FMid);
  lblRV.Caption := uHTPredictor.FormatRating(vRV, FRV);
  lblCV.Caption := uHTPredictor.FormatRating(vCV, FCV);
  lblLV.Caption := uHTPredictor.FormatRating(vLV, FLV);
  lblRA.Caption := uHTPredictor.FormatRating(vRA, FRA);
  lblCA.Caption := uHTPredictor.FormatRating(vCA, FCA);
  lblLA.Caption := uHTPredictor.FormatRating(vLA, FLA);

  vTacticLevel := FOpstelling.TacticLevel;
  lblTacticLevel.Caption := uHTPredictor.FormatRating(vTacticLevel, vTacticLevel, TRUE);

  vTotRating := (vMID * 3)
                  + vRV
                  + vCV
                  + vLV
                  + vRA
                  + vCA
                  + vLA;

  vTotRating := 9 + (4 * (vTotRating - 9));
  lblHatStats.Caption := Format('%d', [Ceil(vTotRating)]);
  FMid := vMID;
  FRV := vRV;
  FCV := vCV;
  FLV := vLV;
  FRA := vRA;
  FCA := vCA;
  FLA := vLA;
end;

procedure TfrmOpstelling.cbMotivatiePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if (FOpstelling <> nil) then
  begin
    FOpstelling.Motivatie := TOpstellingMotivatie(cbMotivatie.EditValue);
  end;
end;

procedure TfrmOpstelling.cbTactiekPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if (FOpstelling <> nil) then
  begin
    FOpstelling.Tactiek := TOpstellingTactiek(cbTactiek.EditValue);
  end;
end;

procedure TfrmOpstelling.cbCoachPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  if (FOpstelling <> nil) then
  begin
    FOpstelling.Coach := TOpstellingCoach(cbCoach.EditValue);
  end;
end;

procedure TfrmOpstelling.edPropertiesChange(Sender: TObject);
begin
  FOpstelling.HandmatigMID := edMID.Value;
  FOpstelling.HandmatigRV := edRV.Value;
  FOpstelling.HandmatigCV := edCV.Value;
  FOpstelling.HandmatigLV := edLV.Value;
  FOpstelling.HandmatigRA := edRA.Value;
  FOpstelling.HandmatigCA := edCA.Value;
  FOpstelling.HandmatigLA := edLA.Value;
  
  UpdateRatings;
end;

{-----------------------------------------------------------------------------
  Procedure: spdbtnGetVoorspellingClick
  Author:    Harry
  Date:      08-mei-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.spdbtnGetVoorspellingClick(Sender: TObject);
var
  vURL, vTaktiek: String;
  vSeperator: Char;
begin
  if (JvPrediction.Status = gsStopped) and not(FBusy) then
  begin
    FBusy := TRUE;

    vSeperator := DecimalSeparator;
    DecimalSeparator := '.';
    try
      vURL := 'http://www.fantamondi.it/HTMS/dorequest.php?action=predict&'+
        Format('TAM=%.2f&',[Team1.MID * 4])+
        Format('TBM=%.2f&',[Team2.MID * 4])+
        Format('TARD=%.2f&',[Team1.RV * 4])+
        Format('TBRD=%.2f&',[Team2.RV * 4])+
        Format('TACD=%.2f&',[Team1.CV * 4])+
        Format('TBCD=%.2f&',[Team2.CV * 4])+
        Format('TALD=%.2f&',[Team1.LV * 4])+
        Format('TBLD=%.2f&',[Team2.LV * 4])+
        Format('TARA=%.2f&',[Team1.RA * 4])+
        Format('TBRA=%.2f&',[Team2.RA * 4])+
        Format('TACA=%.2f&',[Team1.CA * 4])+
        Format('TBCA=%.2f&',[Team2.CA * 4])+
        Format('TALA=%.2f&',[Team1.LA * 4])+
        Format('TBLA=%.2f',[Team2.LA * 4]);

      case Team1.Tactiek of
        tPressie: vTaktiek := Format('&TATAC=PRES&TATACLEV=%.0f',[Team1.TacticLevel]);
        tCounter: vTaktiek := Format('&TATAC=CA&TATACLEV=%.0f',[Team1.TacticLevel]);
        tCentrumAanval: vTaktiek := Format('&TATAC=AIM&TATACLEV=%.0f',[Team1.TacticLevel]);
        tVleugelAanval: vTaktiek := Format('&TATAC=AOW&TATACLEV=%.0f',[Team1.TacticLevel]);
        tCreatiefSpel, tAfstandsSchoten: vTaktiek := '';
      end;
      if (vTaktiek <> '') then
      begin
        vURL := Format('%s%s',[vUrl, vTaktiek]);
      end;

      case Team2.Tactiek of
        tPressie: vTaktiek := Format('&TBTAC=PRES&TBTACLEV=%.0f',[Team2.TacticLevel]);
        tCounter: vTaktiek := Format('&TBTAC=CA&TBTACLEV=%.0f',[Team2.TacticLevel]);
        tCentrumAanval: vTaktiek := Format('&TBTAC=AIM&TBTACLEV=%.0f',[Team2.TacticLevel]);
        tVleugelAanval: vTaktiek := Format('&TBTAC=AOW&TBTACLEV=%.0f',[Team2.TacticLevel]);
        tCreatiefSpel, tAfstandsSchoten: vTaktiek := '';
      end;
      if (vTaktiek <> '') then
      begin
        vURL := Format('%s%s',[vUrl, vTaktiek]);
      end;
    finally
      DecimalSeparator := vSeperator;
    end;
    JvPrediction.Url := vURL;
    Screen.Cursor := crHourGlass;
    JvPrediction.Start;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: JvPredictionDoneStream
  Author:    Harry
  Date:      08-mei-2012
  Arguments: Sender: TObject; Stream: TStream; StreamSize: Integer; Url: String
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.JvPredictionDoneStream(Sender: TObject;
  Stream: TStream; StreamSize: Integer; Url: String);
begin
  Screen.Cursor := crDefault;
  jvXML.LoadFromStream(Stream);
  ShowResults;
  ShowDetailedResults;
  FBusy := FALSE;
end;

{-----------------------------------------------------------------------------
  Procedure: ClearVoorspelling
  Author:    Harry
  Date:      09-mei-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.ClearVoorspelling;
begin
  lblGelijkPerc.Caption := '?';
  lblWinstPerc.Caption := '?';
  lblVerliesPerc.Caption := '?';
  lblUitslag.Caption := '';
  lblBBZ1.Caption := '?';
  lblBBZ2.Caption := '?';
  lblKansen1.Caption := '?';
  lblKansen2.Caption := '?';
  lblLinks1.Caption := '?';
  lblLinks2.Caption := '?';
  lblCentrum1.Caption := '?';
  lblCentrum2.Caption := '?';
  lblRechts1.Caption := '?';
  lblRechts2.Caption := '?';
  lblSH1.Caption := '?';
  lblSH2.Caption := '?';
  lblGoals1.Caption := '?';
  lblGoals2.Caption := '?';
  lblTeamsGelijk.Caption := '?';
  lblWinst1.Caption := '?';
  lblWinst2.Caption := '?';
  lblWinstDiff.Caption := '';
  lblVerliesDiff.Caption := '';
  lblGelijkDiff.Caption := '';
end;

function TfrmOpstelling.GetVerschil(aNewWaarde, aOldWaarde: double):String;
begin
  result := '';
  if (aOldWaarde > 0) then
  begin
    if (aNewWaarde >= aOldWaarde) then
    begin
      result := Format(' (+%.2f%%)',[aNewWaarde - aOldWaarde]);
    end
    else
    begin
      result := Format(' (%.2f%%)',[aNewWaarde - aOldWaarde]);
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: ShowResults
  Author:    Harry
  Date:      08-mei-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.ShowResults;
var
  vSeperator: Char;
begin
  vSeperator := DecimalSeparator;
  DecimalSeparator := '.';
  try
    case FSelectie.WedstrijdPlaats of
      wThuis, wDerbyThuis:
      begin
        lblWinstPerc.Caption := Format('%s %%',[jvXML.Root.Items.Value('S1P')]);
        lblWinstDiff.Caption := GetVerschil(StrToFloat(jvXML.Root.Items.Value('S1P')), FLaatsteWinst);

        lblVerliesPerc.Caption := Format('%s %%',[jvXML.Root.Items.Value('S2P')]);
        lblVerliesDiff.Caption := GetVerschil(StrToFloat(jvXML.Root.Items.Value('S2P')), FLaatsteVerlies);

        FLaatsteWinst := StrToFloat(jvXML.Root.Items.Value('S1P'));
        FLaatsteVerlies := StrToFloat(jvXML.Root.Items.Value('S2P'));
      end
      else
      begin
        lblWinstPerc.Caption := Format('%s %%',[jvXML.Root.Items.Value('S2P')]);
        lblWinstDiff.Caption := GetVerschil(StrToFloat(jvXML.Root.Items.Value('S2P')), FLaatsteWinst);
        lblVerliesPerc.Caption := Format('%s %%',[jvXML.Root.Items.Value('S1P')]);
        lblVerliesDiff.Caption := GetVerschil(StrToFloat(jvXML.Root.Items.Value('S1P')), FLaatsteVerlies);

        FLaatsteWinst := StrToFloat(jvXML.Root.Items.Value('S2P'));
        FLaatsteVerlies := StrToFloat(jvXML.Root.Items.Value('S1P'));
      end;
    end;
    lblGelijkPerc.Caption := Format('%s %%',[jvXML.Root.Items.Value('SXP')]);
    lblGelijkDiff.Caption := GetVerschil(StrToFloat(jvXML.Root.Items.Value('SXP')), FLaatsteGelijk);

    FLaatsteGelijk := StrToFloat(jvXML.Root.Items.Value('SXP'));
      
    lblUitslag.Caption := Format('%s - %s',[jvXML.Root.Items.Value('T1'), jvXML.Root.Items.Value('T2')]);
  finally
    DecimalSeparator := vSeperator;
  end;
end;

procedure TfrmOpstelling.ShowDetailedResults;
var
  vGoals1, vGoals2: double;
  vSeperator: Char;
begin
  vSeperator := DecimalSeparator;
  DecimalSeparator := '.';
  try
    if (Team1.Selectie <> nil) then
    begin
      lblTeam1.Caption := Team1.Selectie.Naam;
    end
    else
    begin
      lblTeam1.Caption := '?';
    end;
      
    if (Team2.Selectie <> nil) then
    begin
      lblTeam2.Caption := Team2.Selectie.Naam;
    end
    else
    begin
      lblTeam2.Caption := '?';
    end;

    vGoals1 := StrToFloat(jvXML.Root.Items.Value('T1'));
    vGoals2 := StrToFloat(jvXML.Root.Items.Value('T2'));
    lblUitslag.Caption := Format('%.0f - %.0f',[vGoals1, vGoals2]);
    lblBBZ1.Caption := Format('%s',[jvXML.Root.Items.Value('P1')]);
    lblBBZ2.Caption := Format('%s',[jvXML.Root.Items.Value('P2')]);
    lblKansen1.Caption := Format('%s',[jvXML.Root.Items.Value('A1')]);
    lblKansen2.Caption := Format('%s',[jvXML.Root.Items.Value('A2')]);
    lblLinks1.Caption := Format('%s',[jvXML.Root.Items.Value('C1L')]);
    lblLinks2.Caption := Format('%s',[jvXML.Root.Items.Value('C2L')]);
    lblCentrum1.Caption := Format('%s',[jvXML.Root.Items.Value('C1C')]);
    lblCentrum2.Caption := Format('%s',[jvXML.Root.Items.Value('C2C')]);
    lblRechts1.Caption := Format('%s',[jvXML.Root.Items.Value('C1R')]);
    lblRechts2.Caption := Format('%s',[jvXML.Root.Items.Value('C2R')]);
    lblSH1.Caption := Format('%s',[jvXML.Root.Items.Value('CP1')]);
    lblSH2.Caption := Format('%s',[jvXML.Root.Items.Value('CP2')]);
    lblGoals1.Caption := Format('%s',[jvXML.Root.Items.Value('T1')]);
    lblGoals2.Caption := Format('%s',[jvXML.Root.Items.Value('T2')]);
    lblTeamsGelijk.Caption := Format('%s%%',[jvXML.Root.Items.Value('SXP')]);
    lblWinst1.Caption := Format('%s%%',[jvXML.Root.Items.Value('S1P')]);
    lblWinst2.Caption := Format('%s%%',[jvXML.Root.Items.Value('S2P')]);

    if (MemData <> nil) and (MemData.Active) then
    begin
      MemData.DisableControls;
      try
        MemData.First;
        if MemData.Locate('ID',TcxTabSheet(Parent).TabIndex,[]) then
        begin
          MemData.Edit;
        end
        else
        begin
          MemData.Insert;
          MemData.FieldByName('ID').asInteger := TcxTabSheet(Parent).TabIndex;
        end;
        MemData.FieldByName('OPSTELLING').asString := FOpstelling.Formatie;
        MemData.FieldByName('TAKTIEK').asString := uHTPredictor.OpstellingTactiekToString(FOpstelling.Tactiek);
        MemData.FieldByName('LV').asFloat := FOpstelling.LV;
        MemData.FieldByName('CV').asFloat := FOpstelling.CV;
        MemData.FieldByName('RV').asFloat := FOpstelling.RV;
        MemData.FieldByName('MID').asFloat := FOpstelling.MID;
        MemData.FieldByName('RA').asFloat := FOpstelling.RA;
        MemData.FieldByName('CA').asFloat := FOpstelling.CA;
        MemData.FieldByName('LA').asFloat := FOpstelling.LA;
        MemData.FieldByName('WINST_THUIS').asFloat := StrToFloat(jvXML.Root.Items.Value('S1P'));
        MemData.FieldByName('VERLIES_THUIS').asFloat := StrToFloat(jvXML.Root.Items.Value('S2P'));
        MemData.FieldByName('GELIJK').asFloat := StrToFloat(jvXML.Root.Items.Value('SXP'));
        MemData.FieldByName('GOALS_THUIS').asFloat := StrToFloat(jvXML.Root.Items.Value('T1'));
        MemData.FieldByName('GOALS_UIT').asFloat := StrToFloat(jvXML.Root.Items.Value('T2'));


        MemData.Post;
      finally
        MemData.EnableControls;
      end;
    end;
  finally
    DecimalSeparator := vSeperator;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     22-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TfrmOpstelling.Team1: TOpstelling;
begin
  Result := nil;

  case FSelectie.WedstrijdPlaats of
    wThuis, wDerbyThuis:  Result := FOpstelling;
    wUit, wDerbyUit:      Result := TOpstelling(Selectie.Tegenstander);
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     22-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function TfrmOpstelling.Team2: TOpstelling;
begin
  Result := nil;

  case FSelectie.WedstrijdPlaats of
    wThuis, wDerbyThuis:  Result := TOpstelling(Selectie.Tegenstander);
    wUit, wDerbyUit:      Result := FOpstelling;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     23-05-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.NeemGegevensOver(aOpstellingForm: TfrmOpstelling);
var
  vCount,
  vPlayerCount: integer;
  vDisplayValue: Variant;
  vErrorText: TCaption;
  vError: Boolean;
  vPlayer: TPlayer;
begin
  for vCount := Low(aOpstellingForm.FOpstellingPlayerArray) to High(aOpstellingForm.FOpstellingPlayerArray) do
  begin                                            
    FOpstellingPlayerArray[vCount].cbOrder.ItemIndex := aOpstellingForm.FOpstellingPlayerArray[vCount].cbOrder.ItemIndex;
    FOpstellingPlayerArray[vCount].cbPlayerPropertiesPopup(nil);
    if (aOpstellingForm.FOpstellingPlayerArray[vCount].cbPlayer.EditValue <> Null) then
    begin
      vPlayer := FOpstelling.Selectie.GetPlayer(aOpstellingForm.FOpstellingPlayerArray[vCount].cbPlayer.EditValue);

      if (vPlayer <> nil) then
      begin
        for vPlayerCount := 0 to FOpstellingPlayerArray[vCount].cbPlayer.Properties.Items.Count - 1 do
        begin
          if (FOpstellingPlayerArray[vCount].cbPlayer.Properties.Items.Items[vPlayerCount].Value = vPlayer.ID) then
          begin
            FOpstellingPlayerArray[vCount].cbPlayer.ItemIndex := vPlayerCount;
          end;
        end;
      end;
    end;
    //FOpstellingPlayerArray[vCount].cbPlayer.ItemIndex := aOpstellingForm.FOpstellingPlayerArray[vCount].cbPlayer.ItemIndex;

    FOpstellingPlayerArray[vCount].ChangeOpstelling(FOpstellingPlayerArray[vCount].cbPlayer, vDisplayValue, vErrorText, vError);
  end;

  FOpstellingAanvoerder.cbPlayerPropertiesPopup(nil);
  FOpstellingAanvoerder.cbPlayer.ItemIndex := aOpstellingForm.FOpstellingAanvoerder.cbPlayer.ItemIndex;
  FOpstellingAanvoerder.ChangeOpstelling(FOpstellingAanvoerder.cbPlayer, vDisplayValue, vErrorText, vError);

  FOpstellingSpelhervatter.cbPlayerPropertiesPopup(nil);
  FOpstellingSpelhervatter.cbPlayer.ItemIndex := aOpstellingForm.FOpstellingSpelhervatter.cbPlayer.ItemIndex; 
  FOpstellingSpelhervatter.ChangeOpstelling(FOpstellingSpelhervatter.cbPlayer, vDisplayValue, vErrorText, vError);

  UpdateRatings;
end;

procedure TfrmOpstelling.Button1Click(Sender: TObject);
var
  vData : TIdMultiPartFormDataStream;
begin
  try
    vData := TIdMultiPartFormDataStream.Create;

    try
      vData.AddFormField('hmid', uBibString.VervangenDoorWaarde(Format('%.2f', [Team1.MID]), ',', '.'));
      vData.AddFormField('hrd', uBibString.VervangenDoorWaarde(Format('%.2f', [Team1.RV]), ',', '.'));
      vData.AddFormField('hcd', uBibString.VervangenDoorWaarde(Format('%.2f', [Team1.CV]), ',', '.'));
      vData.AddFormField('hld', uBibString.VervangenDoorWaarde(Format('%.2f', [Team1.LV]), ',', '.'));
      vData.AddFormField('hra', uBibString.VervangenDoorWaarde(Format('%.2f', [Team1.RA]), ',', '.'));
      vData.AddFormField('hca', uBibString.VervangenDoorWaarde(Format('%.2f', [Team1.CA]), ',', '.'));
      vData.AddFormField('hla', uBibString.VervangenDoorWaarde(Format('%.2f', [Team1.LA]), ',', '.'));

      vData.AddFormField('home_head', Format('%d', [2]));
      vData.AddFormField('home_quick_wing', Format('%d', [1]));
      vData.AddFormField('home_quick_forw', Format('%d', [1]));
      vData.AddFormField('home_unpred_wing', Format('%d', [0]));
      vData.AddFormField('home_unpred_forw', Format('%d', [0]));
      vData.AddFormField('hask', Format('%d', [10])); //AIM/AOW skill
      vData.AddFormField('hcsk', Format('%d', [10])); //ca skill
      vData.AddFormField('hidspa', Format('%d', [5]));   //SetPieces aanvallend
      vData.AddFormField('hidspd', Format('%d', [6]));   //SetPieces verd
      vData.AddFormField('hspec', Format('%d', [0])); //hidden
      vData.AddFormField('hdspz', uBibString.VervangenDoorWaarde(Format('%.2f', [0.42]), ',', '.'));  //vaste waarde

      vData.AddFormField('huse_ca', 'FALSE');
      vData.AddFormField('huse_aim', 'FALSE');
      vData.AddFormField('huse_aow', 'FALSE');

      vData.AddFormField('amid', uBibString.VervangenDoorWaarde(Format('%.2f', [Team2.MID]), ',', '.'));
      vData.AddFormField('ard', uBibString.VervangenDoorWaarde(Format('%.2f', [Team2.RV]), ',', '.'));
      vData.AddFormField('acd', uBibString.VervangenDoorWaarde(Format('%.2f', [Team2.CV]), ',', '.'));
      vData.AddFormField('ald', uBibString.VervangenDoorWaarde(Format('%.2f', [Team2.LV]), ',', '.'));
      vData.AddFormField('ara', uBibString.VervangenDoorWaarde(Format('%.2f', [Team2.RA]), ',', '.'));
      vData.AddFormField('aca', uBibString.VervangenDoorWaarde(Format('%.2f', [Team2.CA]), ',', '.'));
      vData.AddFormField('ala', uBibString.VervangenDoorWaarde(Format('%.2f', [Team2.LA]), ',', '.'));

      vData.AddFormField('away_head', Format('%d', [2]));
      vData.AddFormField('away_quick_wing', Format('%d', [1]));
      vData.AddFormField('away_quick_forw', Format('%d', [1]));
      vData.AddFormField('away_unpred_wing', Format('%d', [0]));
      vData.AddFormField('away_unpred_forw', Format('%d', [0]));
      vData.AddFormField('aask', Format('%d', [10]));
      vData.AddFormField('acsk', Format('%d', [10]));
      vData.AddFormField('aidspa', Format('%d', [5]));
      vData.AddFormField('aidspd', Format('%d', [6]));
      vData.AddFormField('aspec', Format('%d', [0]));
      vData.AddFormField('adspz', uBibString.VervangenDoorWaarde(Format('%.2f', [0.42]), ',', '.'));
      
      vData.AddFormField('huse_ca', 'FALSE');
      vData.AddFormField('huse_aim', 'FALSE');
      vData.AddFormField('huse_aow', 'FALSE');

      Memo1.Lines.Text := IdHTTP1.Post('http://htev.org/furminator/', vData);
    finally
      vData.Free;
    end;
  except
  //bla
  end
end;

constructor TfrmOpstelling.Create(AOwner: TComponent);
var
  vCount: integer;
  vItem: TcxImageComboBoxItem;
begin               
  inherited;

  Name := '';
  lblGelijkPerc.Caption := '';
  lblWinstPerc.Caption := '';
  lblVerliesPerc.Caption := '';
  lblUitslag.Caption := '';

  for vCount := Ord(Low(TOpstellingMotivatie)) to Ord(High(TOpstellingMotivatie)) do
  begin
    vItem := cbMotivatie.Properties.Items.Add;
    vItem.Value := vCount;
    vItem.Description := uHTPredictor.OpstellingMotivatieToString(TOpstellingMotivatie(vCount));
  end;

  for vCount := Ord(Low(TOpstellingTactiek)) to Ord(High(TOpstellingTactiek)) do
  begin
    vItem := cbTactiek.Properties.Items.Add;
    vItem.Value := vCount;
    vItem.Description := uHTPredictor.OpstellingTactiekToString(TOpstellingTactiek(vCount));
  end;


  for vCount := Ord(Low(TOpstellingCoach)) to Ord(High(TOpstellingCoach)) do
  begin
    vItem := cbCoach.Properties.Items.Add;
    vItem.Value := vCount;
    vItem.Description := uHTPredictor.OpstellingCoachToString(TOpstellingCoach(vCount));
  end;

  cxpgctrlRatings.ActivePage := tbshtRatings;
end;

destructor TfrmOpstelling.Destroy;
begin
  FreeObjecten;

  inherited;
end;

end.
