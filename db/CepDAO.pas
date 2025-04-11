unit CepDAO;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, CepModel, Data.DB;

type
  TCepDAO = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    procedure SaveOrUpdate(ACep: TCep);
    function GetCepsUF(const AUF: string): TFDQuery;
  end;

implementation

constructor TCepDAO.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

procedure TCepDAO.SaveOrUpdate(ACep: TCep);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'INSERT INTO tspdcep (cep, logradouro, complemento, bairro, localidade, uf, ibge, gia, ddd, siafi) ' +
      'VALUES (:cep, :logradouro, :complemento, :bairro, :localidade, :uf, :ibge, :gia, :ddd, :siafi) ' +
      'ON CONFLICT (cep) DO UPDATE SET ' +
      'logradouro = EXCLUDED.logradouro, ' +
      'complemento = EXCLUDED.complemento, ' +
      'bairro = EXCLUDED.bairro, ' +
      'localidade = EXCLUDED.localidade, ' +
      'uf = EXCLUDED.uf, ' +
      'ibge = EXCLUDED.ibge, ' +
      'gia = EXCLUDED.gia, ' +
      'ddd = EXCLUDED.ddd, ' +
      'siafi = EXCLUDED.siafi';

    Qry.ParamByName('cep').AsString := ACep.Cep;
    Qry.ParamByName('logradouro').AsString := ACep.Logradouro;
    Qry.ParamByName('complemento').AsString := ACep.Complemento;
    Qry.ParamByName('bairro').AsString := ACep.Bairro;
    Qry.ParamByName('localidade').AsString := ACep.Localidade;
    Qry.ParamByName('uf').AsString := ACep.Uf;
    Qry.ParamByName('ibge').AsString := ACep.Ibge;
    Qry.ParamByName('gia').AsString := ACep.Gia;
    Qry.ParamByName('ddd').AsString := ACep.Ddd;
    Qry.ParamByName('siafi').AsString := ACep.Siafi;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TCepDAO.GetCepsUF(const AUF: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  try
    Result.Connection := FConnection;
    Result.SQL.Text := 'SELECT * FROM tspdcep WHERE uf = :uf ORDER BY localidade, logradouro';
    Result.ParamByName('uf').AsString := AUF;
    Result.Open;
  except
    Result.Free;
    raise;
  end;
end;

end.
