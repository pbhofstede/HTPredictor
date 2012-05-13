program HTPredictor;

uses
  FastMM4,
  Forms,
  formHTPredictor in 'formHTPredictor.pas' {frmHTPredictor},
  uHTPredictor in 'uHTPredictor.pas',
  FormFieldMapping in 'FormFieldMapping.pas' {frmFieldMapping},
  FormSpelerGrid in 'FormSpelerGrid.pas' {frmSpelerGrid},
  FormKiesTabSheet in 'FormKiesTabSheet.pas' {frmKiesTabsheet},
  uSelectie in 'uSelectie.pas',
  uPlayer in 'uPlayer.pas',
  FormOpstelling in 'FormOpstelling.pas' {frmOpstelling},
  FormOpstellingPlayer in 'FormOpstellingPlayer.pas' {frmOpstellingPlayer},
  uOpstelling in 'uOpstelling.pas',
  uRatingBijdrages in 'uRatingBijdrages.pas',
  uRatingBijdrage in 'uRatingBijdrage.pas',
  FormRatingbijdrages in 'FormRatingbijdrages.pas' {frmRatingBijdrages},
  uOpstellingPlayer in 'uOpstellingPlayer.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHTPredictor, frmHTPredictor);
  Application.Run;
end.
