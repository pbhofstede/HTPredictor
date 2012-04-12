program HTPredictor;

uses
  Forms,
  formHTPredictor in 'formHTPredictor.pas' {frmHTPredictor},
  uHTPredictor in 'uHTPredictor.pas',
  FormFieldMapping in 'FormFieldMapping.pas' {frmFieldMapping},
  FormSpelerGrid in 'FormSpelerGrid.pas' {frmSpelerGrid},
  FormKiesTabSheet in 'FormKiesTabSheet.pas' {frmKiesTabsheet};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHTPredictor, frmHTPredictor);
  Application.Run;
end.
