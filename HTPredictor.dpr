program HTPredictor;

uses
  Forms,
  formHTPredictor in 'formHTPredictor.pas' {frmHTPredictor};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHTPredictor, frmHTPredictor);
  Application.Run;
end.
