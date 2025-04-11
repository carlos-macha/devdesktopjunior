unit CepService;

interface

uses
  System.SysUtils, System.JSON, REST.Client, REST.Types,
  CepModel, CepDAO, FireDAC.Comp.Client;

type
  TCepService = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function ConsultCep(const ACep: string): TCep;
    procedure ConsultAndSaveCep(const ACep: string);
    function GetCepsUF(const AUF: string): TFDQuery;
  end;

implementation

constructor TCepService.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TCepService.ConsultCep(const ACep: string): TCep;
var
  RestClient: TRESTClient;
  RestRequest: TRESTRequest;
  RestResponse: TRESTResponse;
  Json: TJSONObject;
begin
  Result := TCep.Create;
  RestClient := TRESTClient.Create('https://viacep.com.br/ws/' + ACep + '/json/');
  RestRequest := TRESTRequest.Create(nil);
  RestResponse := TRESTResponse.Create(nil);
  try
    RestRequest.Client := RestClient;
    RestRequest.Response := RestResponse;
    RestRequest.Method := rmGET;
    RestRequest.Execute;

    if RestResponse.StatusCode = 200 then
    begin
      Json := TJSONObject.ParseJSONValue(RestResponse.Content) as TJSONObject;
      if Assigned(Json) then
      begin
        try
          Result.cep := Json.GetValue<string>('cep', '');
          Result.logradouro := Json.GetValue<string>('logradouro', '');
          Result.complemento := Json.GetValue<string>('complemento', '');
          Result.bairro := Json.GetValue<string>('bairro', '');
          Result.localidade := Json.GetValue<string>('localidade', '');
          Result.uf := Json.GetValue<string>('uf', '');
          Result.ibge := Json.GetValue<string>('ibge', '');
          Result.gia := Json.GetValue<string>('gia', '');
          Result.ddd := Json.GetValue<string>('ddd', '');
          Result.siafi := Json.GetValue<string>('siafi', '');
        finally
          Json.Free;
        end;
      end;
    end
    else
    begin
      raise Exception.Create('Erro na consulta do CEP: ' + RestResponse.StatusText);
    end;
  finally
    RestRequest.Free;
    RestResponse.Free;
    RestClient.Free;
  end;
end;

procedure TCepService.ConsultAndSaveCep(const ACep: string);
var
  Cep: TCep;
  DAO: TCepDAO;
begin
  Cep := ConsultCep(ACep);
  try
    DAO := TCepDAO.Create(FConnection);
    try
      DAO.SaveOrUpdate(Cep);
    finally
      DAO.Free;
    end;
  finally
    Cep.Free;
  end;
end;

function TCepService.GetCepsUF(const AUF: string): TFDQuery;
var
  DAO: TCepDAO;
begin
  DAO := TCepDAO.Create(FConnection);
  try
    Result := DAO.GetCepsUF(AUF);
  finally
    DAO.Free;
  end;
end;

end.
