unit FormOpstellingPlayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, uHTPredictor, cxControls, cxContainer, cxEdit, cxTextEdit, formHTPredictor,
  cxMaskEdit, cxDropDownEdit, cxImageComboBox, uOpstelling, StdCtrls;

type
  TfrmOpstellingPlayer = class(TForm)
    pnlPlayer: TPanel;
    cbPlayer: TcxImageComboBox;
    cbOrder: TcxImageComboBox;
    lblCaption: TLabel;
    vTempCB: TcxImageComboBox;
    tiHint: TTimer;
    procedure cbPlayerPropertiesPopup(Sender: TObject);
    procedure cbPlayerPropertiesChange(Sender: TObject);
    procedure cbPlayerPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbOrderPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    
     procedure CMMouseEnter(var Msg: TMessage); message CM_MouseEnter;
     procedure CMMouseLeave(var Msg: TMessage); message CM_MouseLeave;
    procedure tiHintTimer(Sender: TObject);
  private
    FPosition: TPlayerPosition;
    FOpstelling: TOpstelling;
    FAanvoerder: Boolean;
    FHintWindow: THintWindow;
    FMyHint: String;
    procedure SetPosition(const Value: TPlayerPosition);
    procedure VulCBOrder;
    procedure ChangeOpstelling(aSender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure SetAanvoerder(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
    property Opstelling: TOpstelling read FOpstelling write FOpstelling;
    property Position: TPlayerPosition read FPosition write SetPosition;
    property Aanvoerder: Boolean read FAanvoerder write SetAanvoerder;
  end;

function ToonOpstellingPlayer(aParent: TWinControl; aOpstelling: TOpstelling; aPosition: TPlayerPosition): TfrmOpstellingPlayer; overload;
function ToonOpstellingPlayer(aParent: TWinControl; aOpstelling: TOpstelling; aAanvoerder: Boolean): TfrmOpstellingPlayer; overload;

implementation
uses
  uPlayer;

{$R *.DFM}

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
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
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
function ToonOpstellingPlayer(aParent: TWinControl; aOpstelling: TOpstelling; aAanvoerder: Boolean): TfrmOpstellingPlayer;
begin
  Result := TfrmOpstellingPlayer.Create(nil);

  Result.Parent := aParent;
  Result.Opstelling := aOpstelling;
  Result.Position := pOnbekend;

  Result.Align := alNone;

  Result.Aanvoerder := aAanvoerder;

  Result.cbOrder.Visible := FALSE;
  Result.cbPlayer.Top := Result.cbOrder.Top;

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
  vToevoegen: Boolean;
  vRating: double;
  vSortSL: TStringList;
  vString: String;
begin
  if (FOpstelling <> nil) and
     (FOpstelling.Selectie <> nil) then
  begin
    cbPlayer.Properties.Items.Clear;
    vTempCB.Properties.Items.Clear;
    
    vSortSL := TStringList.Create;
    try
      //leeg item toevoegen
      vItem := cbPlayer.Properties.Items.Add;
      vItem.Value := -1;
      vItem.Description := '';
      vItem.ImageIndex := -1;

      for vCount := 0 to FOpstelling.Selectie.Players.Count - 1 do
      begin
        vPlayer := TPlayer(FOpstelling.Selectie.Players[vCount]);
        vPlayerPosition := FOpstelling.GetPositionOfPlayer(vPlayer);

        if (Position = pOnbekend) then
        begin
          if Aanvoerder then
          begin
            vToevoegen := (Ord(vPlayerPosition) >= Ord(pKP));
          end
          else
          begin
            //let op: groter dan KP omdat keeper geen SH-er mag zijn
            vToevoegen := (Ord(vPlayerPosition) > Ord(pKP));
          end;
        end
        else
        begin
          vToevoegen := TRUE;
        end;

        if (vToevoegen) then
        begin
          vItem := vTempCB.Properties.Items.Add;
          vItem.Value := vPlayer.ID;

          if (Position = pOnbekend) then
          begin
            if Aanvoerder then
            begin
              vRating := vPlayer.XP;
            end
            else
            begin
              vRating := vPlayer.SP;
            end;
          end
          else
          begin
            vRating := vPlayer.GetPositionRating(Position, TPlayerOrder(cbOrder.EditValue));
          end;

          vItem.Description := Format('%s %.2f', [vPlayer.Naam, vRating]);

          if (Position = pOnbekend) or
             (vPlayerPosition = pOnbekend) or
             (vPlayerPosition = Position) then
          begin
            vItem.ImageIndex := -1;
          end
          else
          begin
            vItem.ImageIndex := 202;
          end;

          if (vRating < 10) then
          begin
            vString := '0';
          end
          else
          begin
            vString := '';
          end;

          vString := vString + Format('%.2f', [vRating]);
          vSortSL.AddObject(vString, vItem);
        end;
      end;

      vSortSL.Sort;

      for vCount := vSortSL.Count - 1 downto 0 do
      begin
        vItem := cbPlayer.Properties.Items.Add;
        vItem.Value := TcxImageComboBoxItem(vSortSL.Objects[vCount]).Value;
        vItem.Description := TcxImageComboBoxItem(vSortSL.Objects[vCount]).Description;
        vItem.ImageIndex := TcxImageComboBoxItem(vSortSL.Objects[vCount]).ImageIndex;
      end;

      vTempCB.Properties.Items.Clear;
    finally
      vSortSL.Free;
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
  if (cbPlayer.EditValue <> Null) then
  begin
    ChangeOpstelling(Sender, DisplayValue, ErrorText, Error);
  end;
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
  vPlayerID: integer;
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
    
    if (Position = pOnbekend) then
    begin
      if (Aanvoerder) then
      begin
        FOpstelling.Aanvoerder := vPlayer;
      end
      else
      begin
        FOpstelling.Spelhervatter := vPlayer;
      end;
    end
    else
    begin
      if (vPlayer = nil) or
         (FOpstelling.GetPositionOfPlayer(vPlayer) in [pOnbekend, Position]) then
      begin
        vPlayerOrder := TPlayerOrder(cbOrder.EditValue);
        Error := FALSE;

        if (cbPlayer.EditValue <> Null) then
        begin
          vPlayerID := cbPlayer.EditValue;
        end
        else
        begin
          vPlayerID := 0;
        end;
        FOpstelling.ZetPlayerIDOpPositie(vPlayerID, Position, vPlayerOrder);

        if (vPlayer = nil) then
        begin
          vText := '';
          FMyHint := '';
        end
        else
        begin
          vText := Format('%s %.2f', [vPlayer.Naam, vPlayer.GetPositionRating(Position, vPlayerOrder)]);
          FMyHint := Format('IM: %.2f'+#13#10+
                            'LV: %.2f CV: %.2f LV: %.2f'+#13#10+
                            'LA: %.2f CA: %.2f LA: %.2f',
                            [vPlayer.MID_Bijdrage,
                             vPlayer.DEF_R_Bijdrage, vPlayer.DEF_C_Bijdrage, vPlayer.DEF_L_Bijdrage,
                             vPlayer.AANV_R_Bijdrage, vPlayer.AANV_C_Bijdrage, vPlayer.AANV_L_Bijdrage]);
        end;

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
end;

{-----------------------------------------------------------------------------
  Author:    Pieter Bas
  Datum:     18-04-2012
  Doel:
  
  <eventuele fixes>
-----------------------------------------------------------------------------}
procedure TfrmOpstellingPlayer.SetAanvoerder(const Value: Boolean);
begin
  FAanvoerder := Value;
  
  if (FAanvoerder) then
  begin
    Left := 20;
    Top := 210;
    lblCaption.Caption := 'Aanvoerder';
  end
  else
  begin
    Left := 170;
    Top := 210;
    lblCaption.Caption := 'Spelhervatter';
  end;
end;

procedure TfrmOpstellingPlayer.CMMouseEnter(var Msg: TMessage);
begin
  if TControl(Msg.LParam) = pnlPlayer then
  begin
    if (FMyHint <> '') then
    begin
      tiHint.Enabled := TRUE;
    end;
  end;
end;

procedure TfrmOpstellingPlayer.CMMouseLeave(var Msg: TMessage);
begin
  if TControl(Msg.LParam) = pnlPlayer then
  begin
    if Assigned(FHintWindow) then
    begin
      FHintWindow.ReleaseHandle;
      FHintWindow := nil;
    end
    else
    begin
      tiHint.Enabled := FALSE;
    end;
  end;
end;

procedure TfrmOpstellingPlayer.tiHintTimer(Sender: TObject);
var
  aRect: TRect;
begin
  tiHint.Enabled := FALSE;
  
  if (FMyHint <> '') then
  begin
    FHintWindow := THintWindow.Create(Self);
    with FHintWindow do
    begin
      try
        Font.Name := 'Tahoma';
        Font.Style := Font.Style + [fsBold];
        Color := clInfoBk;
        aRect.TopLeft := Self.ClientToScreen(Point(cbPlayer.Left,cbPlayer.Top + 40));
        aRect.BottomRight := Self.ClientToScreen(Point(cbPlayer.Left + 170,cbPlayer.Top + 90));
      finally
        ActivateHint(aRect, FMyHint);
      end;
    end;
  end;
end;

end.
