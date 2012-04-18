unit FormOpstelling;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, uSelectie, uOpstelling, FormOpstellingPlayer;

type
  TfrmOpstelling = class(TForm)
    pnlRatings: TPanel;
    pnlOpstelling: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FSelectie: TSelectie;
    FOpstelling: TOpstelling;
    FOpstellingPlayerArray: array[1..14] of TfrmOpstellingPlayer;    
    FOpstellingAanvoerder: TfrmOpstellingPlayer;                     
    FOpstellingSpelhervatter: TfrmOpstellingPlayer;
    procedure SetSelectie(const Value: TSelectie);
    procedure FreeObjecten;
    { Private declarations }
  public
    { Public declarations }
    property Selectie: TSelectie read FSelectie write SetSelectie;

    procedure EnableDisableOpstellingPlayer;    
    procedure UpdateAanvoerder;
    procedure UpdateSpelhervatter;
  end;


function ToonOpstelling(aParent: TWinControl; aSelectie: TSelectie): TfrmOpstelling;

implementation
uses
  uHTPredictor;

{$R *.DFM}


function ToonOpstelling(aParent: TWinControl; aSelectie: TSelectie): TfrmOpstelling;
begin
  
  Result := TfrmOpstelling.Create(nil);

  Result.Parent := aParent;
  Result.Selectie := aSelectie;

  Result.Align := alClient;

  Result.Show;
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
  
  for vCount := Low(FOpstellingPlayerArray) to High(FOpstellingPlayerArray) do
  begin
    if (FOpstellingPlayerArray[vCount].cbPlayer.EditValue = Null) or
       (FOpstellingPlayerArray[vCount].cbPlayer.EditValue = -1) then
    begin
      FOpstellingPlayerArray[vCount].cbPlayer.Enabled := not vDisable;
      FOpstellingPlayerArray[vCount].cbOrder.Enabled := not vDisable;
    end;
  end;
end;

procedure TfrmOpstelling.FormCreate(Sender: TObject);
begin
//
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

  FOpstelling := TOpstelling.Create(Self);
  FOpstelling.Selectie := Selectie;

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
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstelling.FormDestroy(Sender: TObject);
begin
  FreeObjecten;
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
      if (FOpstellingAanvoerder.cbPlayer.ItemIndex <> FOpstelling.Aanvoerder.ID) then
      begin
        FOpstellingAanvoerder.cbPlayer.ItemIndex := FOpstelling.Aanvoerder.ID;
      end;
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
      if FOpstellingSpelhervatter.cbPlayer.ItemIndex <> FOpstelling.Spelhervatter.ID then
      begin
        FOpstellingSpelhervatter.cbPlayer.ItemIndex := FOpstelling.Spelhervatter.ID;
      end;
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
var
  vCount: integer;
begin
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

  if (FOpstelling <> nil) then
  begin
    FOpstelling.Free;
    FOpstelling := nil;
  end;
end;

end.
