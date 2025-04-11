object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClick = BtnListarPRClick
  OnCreate = FormCreate
  TextHeight = 15
  object EditCep: TEdit
    Left = 232
    Top = 75
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object BtnBuscar: TButton
    Left = 254
    Top = 128
    Width = 75
    Height = 25
    Caption = 'BtnBuscar'
    TabOrder = 1
    OnClick = BtnBuscarClick
  end
  object DBGrid1: TDBGrid
    Left = 48
    Top = 192
    Width = 521
    Height = 129
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object StaticText1: TStaticText
    Left = 260
    Top = 40
    Width = 69
    Height = 19
    Caption = 'Digite o CEP'
    TabOrder = 3
  end
  object Button1: TButton
    Left = 232
    Top = 336
    Width = 123
    Height = 25
    Caption = 'Buscar CEPs do PR'
    TabOrder = 4
    OnClick = BtnListarPRClick
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=db_consulta_cep'
      'User_Name=tspdcep'
      'Password=123'
      'DriverID=PG')
    Left = 32
    Top = 376
  end
  object DataSource1: TDataSource
    Top = 376
  end
end
