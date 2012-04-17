unit FormOpstellingPlayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, uHTPredictor;

type
  TfrmOpstellingPlayer = class(TForm)
    Panel1: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ToonOpstellingPlayer(aParent: TWinControl; aPosition: TPosition): TForm;

implementation

{$R *.DFM}


function ToonOpstellingPlayer(aParent: TWinControl; aPosition: TPosition): TForm;
begin
  Result := TfrmOpstellingPlayer.Create(nil);

  Result.Parent := aParent;

  Result.Align := alNone;

  case aPosition of
    pKP:
    begin
      Result.Left := 320;
      Result.Top := 10;
    end;
    pRB:
    begin
      Result.Left := 20;
      Result.Top := 60;
    end;
    pRCV:
    begin
      Result.Left := 170;
      Result.Top := 60;
    end;               
    pCV:
    begin
      Result.Left := 320;
      Result.Top := 60;
    end;               
    pLCV:
    begin
      Result.Left := 470;
      Result.Top := 60;
    end;                
    pLB:
    begin
      Result.Left := 620;
      Result.Top := 60;
    end;
    pRW:
    begin
      Result.Left := 20;
      Result.Top := 110;
    end;
    pRCM:
    begin
      Result.Left := 170;
      Result.Top := 110;
    end;
    pCM:
    begin
      Result.Left := 320;
      Result.Top := 110;
    end;
    pLCM:
    begin
      Result.Left := 470;
      Result.Top := 110;
    end;
    pLW:
    begin
      Result.Left := 620;
      Result.Top := 110;
    end;
    pRCA:
    begin
      Result.Left := 170;
      Result.Top := 160;
    end;
    pCA:
    begin
      Result.Left := 320;
      Result.Top := 160;
    end;
    pLCA:
    begin
      Result.Left := 470;
      Result.Top := 160;
    end;
  end;


  Result.Show;

  
end;

end.
