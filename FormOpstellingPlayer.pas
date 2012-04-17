unit FormOpstellingPlayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, uHTPredictor, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxImageComboBox, uOpstelling;

type
  TfrmOpstellingPlayer = class(TForm)
    pnlPlayer: TPanel;
    cbPlayer: TcxImageComboBox;
    cbOrder: TcxImageComboBox;
    procedure cbPlayerPropertiesPopup(Sender: TObject);
    procedure cbPlayerPropertiesChange(Sender: TObject);
    procedure cbPlayerPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbOrderPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    FPosition: TPlayerPosition;
    FOpstelling: TOpstelling;
    procedure SetPosition(const Value: TPlayerPosition);
    procedure VulCBOrder;
    procedure ChangeOpstelling(aSender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    { Private declarations }
  public
    { Public declarations }
    property Opstelling: TOpstelling read FOpstelling write FOpstelling;
    property Position: TPlayerPosition read FPosition write SetPosition;
  end;

function ToonOpstellingPlayer(aParent: TWinControl; aOpstelling: TOpstelling; aPosition: TPlayerPosition): TfrmOpstellingPlayer;

implementation
uses
  uPlayer, formHTPredictor;

{$R *.DFM}


function ToonOpstellingPlayer(aParent: TWinControl; aOpstelling: TOpstelling; aPosition: TPlayerPosition): TfrmOpstellingPlayer;
begin
  Result := TfrmOpstellingPlayer.Create(nil);

  Result.Parent := aParent;
  Result.Opstelling := aOpstelling;
  Result.Position := aPosition;

  Result.Align := alNone;

  Result.Show;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstellingPlayer.cbPlayerPropertiesPopup(Sender: TObject);
var
  vItem: TcxImageComboBoxItem;
  vCount: integer;
  vPlayerPosition: TPlayerPosition;
  vPlayer: TPlayer;
begin
  if (FOpstelling <> nil) and
     (FOpstelling.Selectie <> nil) then
  begin
    cbPlayer.Properties.Items.Clear;

    //leeg item toevoegen
    vItem := cbPlayer.Properties.Items.Add;
    vItem.Value := -1;
    vItem.Description := '';
    vItem.ImageIndex := -1;

    for vCount := 0 to FOpstelling.Selectie.Players.Count - 1 do
    begin
      vPlayer := TPlayer(FOpstelling.Selectie.Players[vCount]);

      vItem := cbPlayer.Properties.Items.Add;
      vItem.Value := vPlayer.ID;
      vItem.Description := Format('%s %.2f', [vPlayer.Naam, vPlayer.GetPositionRating(Position, TPlayerOrder(cbOrder.EditValue))]);

      vPlayerPosition := FOpstelling.GetPositionOfPlayer(vPlayer);

      if (vPlayerPosition = pOnbekend) or
         (vPlayerPosition = Position) then
      begin
        vItem.ImageIndex := -1;
      end
      else
      begin
        vItem.ImageIndex := 202;
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
procedure TfrmOpstellingPlayer.SetPosition(const Value: TPlayerPosition);
begin
  FPosition := Value;
  
  case FPosition of
    pKP:
    begin
      Left := 320;
      Top := 10;
    end;
    pRB:
    begin
      Left := 20;
      Top := 60;
    end;
    pRCV:
    begin
      Left := 170;
      Top := 60;
    end;               
    pCV:
    begin
      Left := 320;
      Top := 60;
    end;               
    pLCV:
    begin
      Left := 470;
      Top := 60;
    end;                
    pLB:
    begin
      Left := 620;
      Top := 60;
    end;
    pRW:
    begin
      Left := 20;
      Top := 110;
    end;
    pRCM:
    begin
      Left := 170;
      Top := 110;
    end;
    pCM:
    begin
      Left := 320;
      Top := 110;
    end;
    pLCM:
    begin
      Left := 470;
      Top := 110;
    end;
    pLW:
    begin
      Left := 620;
      Top := 110;
    end;
    pRCA:
    begin
      Left := 170;
      Top := 160;
    end;
    pCA:
    begin
      Left := 320;
      Top := 160;
    end;
    pLCA:
    begin
      Left := 470;
      Top := 160;
    end;
  end;

  VulCBOrder;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstellingPlayer.VulCBOrder;
var
  vItem: TcxImageComboBoxItem;
begin
  cbOrder.Properties.BeginUpdate;
  try
    cbOrder.Properties.Items.Clear;

    vItem := cbOrder.Properties.Items.Add;
    vItem.Value := Ord(oNormaal);
    vItem.Description := uHTPredictor.OrderToString(oNormaal);

    if (Position in [pRB, pLB, pRW, pRCM, pCM, pLCM, pLW, pRCA, pCA, pLCA]) then
    begin
      vItem := cbOrder.Properties.Items.Add;
      vItem.Value := Ord(oVerdedigend);
      vItem.Description := uHTPredictor.OrderToString(oVerdedigend);
    end;

    if (Position in [pRB, pRCV, pCV, pLCV, pLB, pRW, pRCM, pCM, pLCM, pLW]) then
    begin
      vItem := cbOrder.Properties.Items.Add;
      vItem.Value := Ord(oAanvallend);
      vItem.Description := uHTPredictor.OrderToString(oAanvallend);
    end;

    if (Position in [pRCV, pLCV, pRCM, pLCM, pRCA, pLCA]) then
    begin
      vItem := cbOrder.Properties.Items.Add;
      vItem.Value := Ord(oNaarVleugel);
      vItem.Description := uHTPredictor.OrderToString(oNaarVleugel);
    end;

    if (Position in [pRB, pLB, pRW, pLW]) then
    begin
      vItem := cbOrder.Properties.Items.Add;
      vItem.Value := Ord(oNaarMidden);
      vItem.Description := uHTPredictor.OrderToString(oNaarMidden);
    end;

    cbOrder.ItemIndex := Ord(oNormaal);
  finally
    cbOrder.Properties.EndUpdate;
  end;
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstellingPlayer.cbPlayerPropertiesChange(Sender: TObject);
begin
//niets doen. de speler wordt in de cbPlayerPropertiesValidate gecontroleerd en gekoppeld
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstellingPlayer.cbPlayerPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  ChangeOpstelling(Sender, DisplayValue, ErrorText, Error);
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstellingPlayer.cbOrderPropertiesValidate(Sender: TObject; var DisplayValue: Variant;
  var ErrorText: TCaption; var Error: Boolean);
begin
  ChangeOpstelling(Sender, DisplayValue, ErrorText, Error);
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     17-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstellingPlayer.ChangeOpstelling(aSender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  vPlayer: TPlayer;
  vPlayerOrder: TPlayerOrder;
  vText: String;
begin
  if (FOpstelling <> nil) then
  begin
    if (cbPlayer.EditValue <> Null) then
    begin
      vPlayer := FOpstelling.Selectie.GetPlayer(cbPlayer.EditValue);
    end
    else
    begin
      vPlayer := nil;
    end;

    if (vPlayer = nil) or
       (FOpstelling.GetPositionOfPlayer(vPlayer) in [pOnbekend, Position]) then
    begin
      vPlayerOrder := TPlayerOrder(cbOrder.EditValue);
      Error := FALSE;

      FOpstelling.ZetPlayerIDOpPositie(cbPlayer.EditValue, Position, vPlayerOrder);

      vText := Format('%s %.2f', [vPlayer.Naam, vPlayer.GetPositionRating(Position, vPlayerOrder)]);

      if aSender = cbPlayer then
      begin
        DisplayValue := vText;
      end
      else
      begin
        cbPlayer.Properties.Items[cbPlayer.SelectedItem].Description := vText;
      end;
    end
    else
    begin
      Error := TRUE;
      ErrorText := 'Deze speler is reeds op een andere positie geselecteerd. Kies een andere speler.';
    end;
  end;
end;

end.
