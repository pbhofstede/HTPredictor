unit FormOpstelling;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TfrmOpstelling = class(TForm)
    pnlRatings: TPanel;
    pnlOpstelling: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


function ToonOpstelling(aParent: TWinControl): TForm;

implementation
uses
  FormOpstellingPlayer, uHTPredictor;

{$R *.DFM}


function ToonOpstelling(aParent: TWinControl): TForm;
begin
  
  Result := TfrmOpstelling.Create(nil);

  Result.Parent := aParent;

  Result.Align := alClient;

  Result.Show;
end;

procedure TfrmOpstelling.FormCreate(Sender: TObject);
begin
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pKP);
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pRB);  
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pRCV);
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pCV);
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pLCV);
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pLB);  
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pRW);
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pRCM);
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pCM);
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pLCM);
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pLW);   
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pRCA);
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pCA);
  FormOpstellingPlayer.ToonOpstellingPlayer(pnlOpstelling, pLCA);
end;

end.
