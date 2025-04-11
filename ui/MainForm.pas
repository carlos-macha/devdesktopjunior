unit MainForm;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.StdCtrls, Vcl.Dialogs, Vcl.DBGrids,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.PG, FireDAC.Stan.Def,
  CepService, CepModel, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,  FireDAC.DApt,
  Vcl.Controls, Vcl.Grids;

type
  TMainForm = class(TForm)
    EditCep: TEdit;
    BtnBuscar: TButton;
    FDConnection1: TFDConnection;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    StaticText1: TStaticText;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnBuscarClick(Sender: TObject);
    procedure BtnListarPRClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VMainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FDConnection1.Connected := False;
  FDConnection1.Params.Clear;
  FDConnection1.DriverName := 'PG';
  FDConnection1.Params.Add('Server=localhost');
  FDConnection1.Params.Add('Port=5432');
  FDConnection1.Params.Add('Database=db_consulta_cep');
  FDConnection1.Params.Add('User_Name=cep');
  FDConnection1.Params.Add('Password=cep123');
  FDConnection1.LoginPrompt := False;

  try
    FDConnection1.Connected := True;

    FDConnection1.ExecSQL(
      'CREATE TABLE IF NOT EXISTS tspdcep (' +
      'cep VARCHAR(20) PRIMARY KEY, ' +
      'logradouro VARCHAR(255), ' +
      'complemento VARCHAR(255), ' +
      'bairro VARCHAR(255), ' +
      'localidade VARCHAR(255), ' +
      'uf VARCHAR(2), ' +
      'ibge VARCHAR(20), ' +
      'gia VARCHAR(20), ' +
      'ddd VARCHAR(10), ' +
      'siafi VARCHAR(10))'
    );
  except
    on E: Exception do
      ShowMessage('Erro ao conectar ao banco: ' + E.Message);
  end;
end;

procedure TMainForm.BtnBuscarClick(Sender: TObject);
var
  Service: TCepService;
begin
  if Trim(EditCep.Text) = '' then
  begin
    ShowMessage('Digite um CEP válido.');
    Exit;
  end;

  Service := TCepService.Create(FDConnection1);
  try
    Service.ConsultAndSaveCep(EditCep.Text);
    ShowMessage('CEP consultado e salvo com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;
  EditCep.Clear;
end;

procedure TMainForm.BtnListarPRClick(Sender: TObject);
var
  Service: TCepService;
  Query: TFDQuery;
begin
  Service := TCepService.Create(FDConnection1);
  try
    Query := Service.GetCepsUF('PR');
    DataSource1.DataSet := Query;
    DBGrid1.DataSource := DataSource1;
  except
    on E: Exception do
      ShowMessage('Erro ao listar CEPs: ' + E.Message);
  end;
end;

end.
