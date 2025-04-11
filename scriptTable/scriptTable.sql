CREATE TABLE IF NOT EXISTS tspdcep (
  cep VARCHAR(20) PRIMARY KEY,
  logradouro VARCHAR(255),
  complemento VARCHAR(255),
  bairro VARCHAR(255),
  localidade VARCHAR(255),
  uf VARCHAR(2),
  ibge VARCHAR(20),
  gia VARCHAR(20),
  ddd VARCHAR(10),
  siafi VARCHAR(10)
);
