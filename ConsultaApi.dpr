program ConsultaApi;

uses
  Vcl.Forms,
  MainForm in 'ui\MainForm.pas' {TMainForm},
  CepModel in 'model\CepModel.pas',
  CepService in 'service\CepService.pas',
  CepDAO in 'db\CepDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, VMainForm);
  Application.Run;
end.

