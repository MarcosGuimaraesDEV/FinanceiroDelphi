object DM: TDM
  Height = 693
  Width = 1089
  object Conexao: TFDConnection
    Params.Strings = (
      
        'Database=E:\Documentos\Projetos_desenvolvimento\Delphi\FINANCEIR' +
        'O\XE\DADOS\FINANCEIRO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=Localhost'
      'Port=3050'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 72
  end
  object FDTransaction1: TFDTransaction
    Connection = Conexao
    Left = 176
    Top = 80
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'C:\Windows\System32\FBCLIENT.DLL'
    Left = 288
    Top = 80
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 416
    Top = 80
  end
  object QMovimento: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from movimento order by idmovimento')
    Left = 72
    Top = 168
    object QMovimentoIDMOVIMENTO: TIntegerField
      FieldName = 'IDMOVIMENTO'
      Origin = 'IDMOVIMENTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QMovimentoCADASTRO: TDateField
      FieldName = 'CADASTRO'
      Origin = 'CADASTRO'
      Required = True
    end
    object QMovimentoUSUARIO: TStringField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      Required = True
      Size = 100
    end
    object QMovimentoTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      Required = True
      Size = 60
    end
    object QMovimentoVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Origin = 'VALOR'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
  end
  object DsMovimento: TDataSource
    DataSet = QMovimento
    Left = 160
    Top = 168
  end
  object QUsuario: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select *from usuario'
      'order by IDUSUARIO')
    Left = 272
    Top = 168
    object QUsuarioCADASTRO: TDateField
      FieldName = 'CADASTRO'
      Origin = 'CADASTRO'
      Required = True
    end
    object QUsuarioIDUSUARIO: TIntegerField
      FieldName = 'IDUSUARIO'
      Origin = 'IDUSUARIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QUsuarioNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object QUsuarioSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Required = True
      Size = 30
    end
    object QUsuarioTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
      Required = True
      Size = 30
    end
  end
  object DsUsuario: TDataSource
    DataSet = QUsuario
    Left = 352
    Top = 168
  end
end
