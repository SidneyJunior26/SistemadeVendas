object Dm: TDm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 464
  Width = 841
  object tblProdutos: TFDQuery
    CachedUpdates = True
    Connection = dbConexao
    Transaction = transConexao
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_PRODUTOS_ID'
    UpdateOptions.KeyFields = 'CODINT'
    UpdateOptions.AutoIncFields = 'CODINT'
    UpdateObject = uProdutos
    SQL.Strings = (
      'Select * from Produtos')
    Left = 303
    Top = 47
    object tblProdutosCODINT: TIntegerField
      FieldName = 'CODINT'
      Origin = 'CODINT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tblProdutosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
    object tblProdutosQTDE: TIntegerField
      FieldName = 'QTDE'
      Origin = 'QTDE'
    end
    object tblProdutosVALOR_CUSTO: TBCDField
      FieldName = 'VALOR_CUSTO'
      Origin = 'VALOR_CUSTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object tblProdutosVALOR_VENDA: TBCDField
      FieldName = 'VALOR_VENDA'
      Origin = 'VALOR_VENDA'
      currency = True
      Precision = 18
      Size = 2
    end
  end
  object uProdutos: TFDUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO PRODUTOS'
      '(CODINT, DESCRICAO, QTDE, VALOR_CUSTO, VALOR_VENDA)'
      
        'VALUES (:NEW_CODINT, :NEW_DESCRICAO, :NEW_QTDE, :NEW_VALOR_CUSTO' +
        ', :NEW_VALOR_VENDA)'
      'RETURNING CODINT, DESCRICAO, QTDE, VALOR_CUSTO, VALOR_VENDA')
    ModifySQL.Strings = (
      'UPDATE PRODUTOS'
      
        'SET CODINT = :NEW_CODINT, DESCRICAO = :NEW_DESCRICAO, QTDE = :NE' +
        'W_QTDE, '
      '  VALOR_CUSTO = :NEW_VALOR_CUSTO, VALOR_VENDA = :NEW_VALOR_VENDA'
      'WHERE CODINT = :OLD_CODINT'
      'RETURNING CODINT, DESCRICAO, QTDE, VALOR_CUSTO, VALOR_VENDA')
    DeleteSQL.Strings = (
      'DELETE FROM PRODUTOS'
      'WHERE CODINT = :OLD_CODINT')
    FetchRowSQL.Strings = (
      'SELECT CODINT, DESCRICAO, QTDE, VALOR_CUSTO, VALOR_VENDA'
      'FROM PRODUTOS'
      'WHERE CODINT = :CODINT')
    Left = 301
    Top = 104
  end
  object dsProdutos: TDataSource
    DataSet = tblProdutos
    Left = 299
    Top = 156
  end
  object tblVendas: TFDQuery
    CachedUpdates = True
    Connection = dbConexao
    Transaction = transConexao
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_VENDAS_ID'
    UpdateOptions.KeyFields = 'CODVENDA'
    UpdateOptions.AutoIncFields = 'CODVENDA'
    UpdateObject = uVendas
    SQL.Strings = (
      'Select * from vendas'
      'Where CodVenda = :wCodVenda')
    Left = 375
    Top = 51
    ParamData = <
      item
        Name = 'WCODVENDA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object tblVendasCODVENDA: TIntegerField
      FieldName = 'CODVENDA'
      Origin = 'CODVENDA'
      Required = True
    end
    object tblVendasDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
      EditMask = '!99/99/00;1;_'
    end
    object tblVendasCODCLIENTE: TIntegerField
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
    end
    object tblVendasVALOR_BRUTO: TBCDField
      FieldName = 'VALOR_BRUTO'
      Origin = 'VALOR_BRUTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object tblVendasDESCONTO: TBCDField
      FieldName = 'DESCONTO'
      Origin = 'DESCONTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object tblVendasVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object tblVendasLCliente: TStringField
      FieldKind = fkLookup
      FieldName = 'LCliente'
      LookupDataSet = tblClientes
      LookupKeyFields = 'CODINT'
      LookupResultField = 'NOME'
      KeyFields = 'CODCLIENTE'
      Size = 100
      Lookup = True
    end
  end
  object uVendas: TFDUpdateSQL
    InsertSQL.Strings = (
      'INSERT INTO VENDAS'
      '(CODVENDA, "DATA", CODCLIENTE, VALOR_BRUTO, '
      '  DESCONTO, VALOR_TOTAL)'
      
        'VALUES (:NEW_CODVENDA, :NEW_DATA, :NEW_CODCLIENTE, :NEW_VALOR_BR' +
        'UTO, '
      '  :NEW_DESCONTO, :NEW_VALOR_TOTAL)'
      
        'RETURNING CODVENDA, "DATA", CODCLIENTE, VALOR_BRUTO, DESCONTO, V' +
        'ALOR_TOTAL')
    ModifySQL.Strings = (
      'UPDATE VENDAS'
      
        'SET CODVENDA = :NEW_CODVENDA, "DATA" = :NEW_DATA, CODCLIENTE = :' +
        'NEW_CODCLIENTE, '
      '  VALOR_BRUTO = :NEW_VALOR_BRUTO, DESCONTO = :NEW_DESCONTO, '
      '  VALOR_TOTAL = :NEW_VALOR_TOTAL'
      'WHERE CODVENDA = :OLD_CODVENDA'
      
        'RETURNING CODVENDA, "DATA", CODCLIENTE, VALOR_BRUTO, DESCONTO, V' +
        'ALOR_TOTAL')
    DeleteSQL.Strings = (
      'DELETE FROM VENDAS'
      'WHERE CODVENDA = :OLD_CODVENDA')
    FetchRowSQL.Strings = (
      
        'SELECT CODVENDA, "DATA" AS "DATA", CODCLIENTE, VALOR_BRUTO, DESC' +
        'ONTO, '
      '  VALOR_TOTAL'
      'FROM VENDAS'
      'WHERE CODVENDA = :CODVENDA')
    Left = 372
    Top = 108
  end
  object dsVendas: TDataSource
    DataSet = tblVendas
    Left = 375
    Top = 160
  end
  object qClientes: TFDQuery
    Connection = dbConexao
    Transaction = transConexao
    SQL.Strings = (
      'Select * from Clientes')
    Left = 229
    Top = 294
    object qClientesCODINT: TIntegerField
      FieldName = 'CODINT'
      Origin = 'CODINT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object qClientesENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 100
    end
    object qClientesBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 50
    end
    object qClientesCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 50
    end
    object qClientesCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      EditMask = '00000\-999;1;_'
      Size = 10
    end
    object qClientesTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      EditMask = '!\(99\)00000-0000;1;_'
      Size = 15
    end
  end
  object dsQClientes: TDataSource
    DataSet = qClientes
    Left = 231
    Top = 350
  end
  object qProdutos: TFDQuery
    Connection = dbConexao
    Transaction = transConexao
    SQL.Strings = (
      'Select * from Produtos')
    Left = 307
    Top = 298
    object qProdutosCODINT: TIntegerField
      FieldName = 'CODINT'
      Origin = 'CODINT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qProdutosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      Size = 50
    end
    object qProdutosQTDE: TIntegerField
      FieldName = 'QTDE'
      Origin = 'QTDE'
    end
    object qProdutosVALOR_CUSTO: TBCDField
      FieldName = 'VALOR_CUSTO'
      Origin = 'VALOR_CUSTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object qProdutosVALOR_VENDA: TBCDField
      FieldName = 'VALOR_VENDA'
      Origin = 'VALOR_VENDA'
      currency = True
      Precision = 18
      Size = 2
    end
  end
  object dsQProdutos: TDataSource
    DataSet = qProdutos
    Left = 307
    Top = 355
  end
  object dbConexao: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\sidne\OneDrive\Documentos\Projeto Desenvolvime' +
        'nto\Dados\DBVENDAS.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = transConexao
    Left = 45
    Top = 25
  end
  object transConexao: TFDTransaction
    Connection = dbConexao
    Left = 45
    Top = 84
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 45
    Top = 141
  end
  object tblClientes: TFDQuery
    CachedUpdates = True
    Connection = dbConexao
    Transaction = transConexao
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_CLIENTES_ID'
    UpdateOptions.KeyFields = 'CODINT'
    UpdateOptions.AutoIncFields = 'CODINT'
    UpdateObject = uClientes
    SQL.Strings = (
      'Select * from Clientes')
    Left = 224
    Top = 44
    object tblClientesCODINT: TIntegerField
      FieldName = 'CODINT'
      Origin = 'CODINT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tblClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object tblClientesENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 100
    end
    object tblClientesBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 50
    end
    object tblClientesCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 50
    end
    object tblClientesCEP: TStringField
      FieldName = 'CEP'
      Origin = 'CEP'
      EditMask = '00000\-999;1;_'
      Size = 10
    end
    object tblClientesTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      EditMask = '!\(99\)00000-0000;1;_'
      Size = 15
    end
  end
  object uClientes: TFDUpdateSQL
    Connection = dbConexao
    InsertSQL.Strings = (
      'INSERT INTO CLIENTES'
      '(CODINT, NOME, ENDERECO, BAIRRO, CIDADE, '
      '  CEP, TELEFONE)'
      
        'VALUES (:NEW_CODINT, :NEW_NOME, :NEW_ENDERECO, :NEW_BAIRRO, :NEW' +
        '_CIDADE, '
      '  :NEW_CEP, :NEW_TELEFONE)'
      'RETURNING CODINT, NOME, ENDERECO, BAIRRO, CIDADE, CEP, TELEFONE')
    ModifySQL.Strings = (
      'UPDATE CLIENTES'
      
        'SET CODINT = :NEW_CODINT, NOME = :NEW_NOME, ENDERECO = :NEW_ENDE' +
        'RECO, '
      '  BAIRRO = :NEW_BAIRRO, CIDADE = :NEW_CIDADE, CEP = :NEW_CEP, '
      '  TELEFONE = :NEW_TELEFONE'
      'WHERE CODINT = :OLD_CODINT'
      'RETURNING CODINT, NOME, ENDERECO, BAIRRO, CIDADE, CEP, TELEFONE')
    DeleteSQL.Strings = (
      'DELETE FROM CLIENTES'
      'WHERE CODINT = :OLD_CODINT')
    FetchRowSQL.Strings = (
      'SELECT CODINT, NOME, ENDERECO, BAIRRO, CIDADE, CEP, TELEFONE'
      'FROM CLIENTES'
      'WHERE CODINT = :CODINT')
    Left = 223
    Top = 104
  end
  object dsClientes: TDataSource
    DataSet = tblClientes
    Left = 223
    Top = 155
  end
  object tblVendasItens: TFDQuery
    CachedUpdates = True
    Connection = dbConexao
    Transaction = transConexao
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_VENDASITENS_ID'
    UpdateOptions.KeyFields = 'CODINT'
    UpdateOptions.AutoIncFields = 'CODINT'
    UpdateObject = uVendasItens
    SQL.Strings = (
      'Select * from VendasItens'
      'Where CodVenda = :wCodVenda')
    Left = 455
    Top = 46
    ParamData = <
      item
        Name = 'WCODVENDA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object tblVendasItensCODVENDA: TIntegerField
      FieldName = 'CODVENDA'
      Origin = 'CODVENDA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tblVendasItensCODINT: TIntegerField
      FieldName = 'CODINT'
      Origin = 'CODINT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tblVendasItensCODPRODUTO: TIntegerField
      FieldName = 'CODPRODUTO'
      Origin = 'CODPRODUTO'
    end
    object tblVendasItensQTDE: TIntegerField
      FieldName = 'QTDE'
      Origin = 'QTDE'
    end
    object tblVendasItensVALOR_UNITARIO: TBCDField
      FieldName = 'VALOR_UNITARIO'
      Origin = 'VALOR_UNITARIO'
      currency = True
      Precision = 18
      Size = 2
    end
    object tblVendasItensVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object tblVendasItensLProduto: TStringField
      FieldKind = fkLookup
      FieldName = 'LProduto'
      LookupDataSet = tblProdutos
      LookupKeyFields = 'CODINT'
      LookupResultField = 'DESCRICAO'
      KeyFields = 'CODPRODUTO'
      Size = 50
      Lookup = True
    end
  end
  object uVendasItens: TFDUpdateSQL
    Connection = dbConexao
    Left = 456
    Top = 99
  end
  object dsVendasItens: TDataSource
    DataSet = tblVendasItens
    Left = 456
    Top = 159
  end
  object qSQL: TFDQuery
    Connection = dbConexao
    Transaction = transConexao
    Left = 67
    Top = 299
  end
  object dsqSQL: TDataSource
    DataSet = qSQL
    Left = 69
    Top = 356
  end
  object frxReport1: TfrxReport
    Version = '5.1.5'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43652.505643425900000000
    ReportOptions.LastChange = 43668.368927418980000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 702
    Top = 31
    Datasets = <
      item
        DataSet = frxDBProdutos
        DataSetName = 'frxDBProdutos'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Height = 113.385900000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 241.889920000000000000
          Top = 15.118120000000000000
          Width = 234.330860000000000000
          Height = 30.236240000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'Relat'#243'rio de Produtos')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 3.779530000000000000
          Top = 102.047310000000000000
          Width = 702.992580000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo2: TfrxMemoView
          Left = 7.559060000000000000
          Top = 79.590551180000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'C'#243'digo')
        end
        object Memo3: TfrxMemoView
          Left = 117.165430000000000000
          Top = 79.590551180000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Descri'#231#227'o')
        end
        object Memo4: TfrxMemoView
          Left = 442.205010000000000000
          Top = 79.590551180000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Qtde')
        end
        object Memo5: TfrxMemoView
          Left = 502.677490000000000000
          Top = 79.590551180000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Valor Custo')
        end
        object Memo6: TfrxMemoView
          Left = 612.283860000000000000
          Top = 79.590551180000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'Valor Venda')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 26.456710000000000000
        Top = 192.756030000000000000
        Width = 718.110700000000000000
        DataSet = frxDBProdutos
        DataSetName = 'frxDBProdutos'
        RowCount = 0
        object frxDBProdutosCODINT: TfrxMemoView
          Left = 7.559060000000000000
          Top = 1.889763779527560000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'CODINT'
          DataSet = frxDBProdutos
          DataSetName = 'frxDBProdutos'
          Memo.UTF8W = (
            '[frxDBProdutos."CODINT"]')
        end
        object frxDBProdutosDESCRICAO: TfrxMemoView
          Left = 94.488250000000000000
          Top = 1.889763779527560000
          Width = 340.157700000000000000
          Height = 18.897650000000000000
          DataField = 'DESCRICAO'
          DataSet = frxDBProdutos
          DataSetName = 'frxDBProdutos'
          Memo.UTF8W = (
            '[frxDBProdutos."DESCRICAO"]')
        end
        object frxDBProdutosQTDE: TfrxMemoView
          Left = 442.205010000000000000
          Top = 1.889763780000010000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          DataField = 'QTDE'
          DataSet = frxDBProdutos
          DataSetName = 'frxDBProdutos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBProdutos."QTDE"]')
          ParentFont = False
        end
        object frxDBProdutosVALOR_CUSTO: TfrxMemoView
          Left = 502.677490000000000000
          Top = 1.889763780000010000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'VALOR_CUSTO'
          DataSet = frxDBProdutos
          DataSetName = 'frxDBProdutos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBProdutos."VALOR_CUSTO"]')
          ParentFont = False
        end
        object frxDBProdutosVALOR_VENDA: TfrxMemoView
          Left = 612.283860000000000000
          Top = 1.889763780000010000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'VALOR_VENDA'
          DataSet = frxDBProdutos
          DataSetName = 'frxDBProdutos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBProdutos."VALOR_VENDA"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Height = 45.354360000000000000
        Top = 279.685220000000000000
        Width = 718.110700000000000000
        object Memo7: TfrxMemoView
          Left = 8.118120000000000000
          Top = 7.338590000000010000
          Width = 196.535560000000000000
          Height = 18.897650000000000000
          Memo.UTF8W = (
            'P'#225'gina: [Page] de [TotalPages]')
        end
        object Line2: TfrxLineView
          Left = 3.779530000000000000
          Top = 3.779529999999970000
          Width = 702.992580000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
    end
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'frxDBVendas'
    CloseDataSource = False
    DataSource = dsQVendas
    BCDToCurrency = False
    Left = 696
    Top = 87
  end
  object frxDBProdutos: TfrxDBDataset
    UserName = 'frxDBProdutos'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODINT=CODINT'
      'DESCRICAO=DESCRICAO'
      'QTDE=QTDE'
      'VALOR_CUSTO=VALOR_CUSTO'
      'VALOR_VENDA=VALOR_VENDA')
    DataSource = dsQProdutos
    BCDToCurrency = False
    Left = 782
    Top = 83
  end
  object qVendas: TFDQuery
    AfterScroll = qVendasAfterScroll
    Connection = dbConexao
    SQL.Strings = (
      'select Vendas.*, Clientes.Nome as LCliente'
      'from Vendas'
      'Left Join Clientes on '
      '(Vendas.CodCliente = Clientes.CodInt)'
      'Order by Vendas.CodVenda')
    Left = 383
    Top = 295
    object qVendasCODVENDA: TIntegerField
      FieldName = 'CODVENDA'
      Origin = 'CODVENDA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qVendasDATA: TDateField
      FieldName = 'DATA'
      Origin = '"DATA"'
      EditMask = '!99/99/00;1;_'
    end
    object qVendasCODCLIENTE: TIntegerField
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
    end
    object qVendasVALOR_BRUTO: TBCDField
      FieldName = 'VALOR_BRUTO'
      Origin = 'VALOR_BRUTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object qVendasDESCONTO: TBCDField
      FieldName = 'DESCONTO'
      Origin = 'DESCONTO'
      currency = True
      Precision = 18
      Size = 2
    end
    object qVendasVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object qVendasLCLIENTE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'LCLIENTE'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
  object dsQVendas: TDataSource
    DataSet = qVendas
    Left = 380
    Top = 354
  end
  object qVendasItens: TFDQuery
    Connection = dbConexao
    Transaction = transConexao
    SQL.Strings = (
      'Select VendasItens.*, Produtos.Descricao as LProduto'
      'from VendasItens'
      'left join Produtos on'
      '(VendasItens.CodProduto = Produtos.CodInt)'
      'Where VendasItens.CodVenda = :wCodVenda'
      '')
    Left = 457
    Top = 297
    ParamData = <
      item
        Name = 'WCODVENDA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qVendasItensCODVENDA: TIntegerField
      FieldName = 'CODVENDA'
      Origin = 'CODVENDA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qVendasItensCODINT: TIntegerField
      FieldName = 'CODINT'
      Origin = 'CODINT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qVendasItensCODPRODUTO: TIntegerField
      FieldName = 'CODPRODUTO'
      Origin = 'CODPRODUTO'
    end
    object qVendasItensQTDE: TIntegerField
      FieldName = 'QTDE'
      Origin = 'QTDE'
    end
    object qVendasItensVALOR_UNITARIO: TBCDField
      FieldName = 'VALOR_UNITARIO'
      Origin = 'VALOR_UNITARIO'
      currency = True
      Precision = 18
      Size = 2
    end
    object qVendasItensVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Origin = 'VALOR_TOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object qVendasItensLPRODUTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'LPRODUTO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 50
    end
  end
  object dsQVendasItens: TDataSource
    DataSet = qVendasItens
    Left = 454
    Top = 356
  end
  object frxDBDataset2: TfrxDBDataset
    UserName = 'frxDBVendasItens'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODVENDA=CODVENDA'
      'CODINT=CODINT'
      'CODPRODUTO=CODPRODUTO'
      'QTDE=QTDE'
      'VALOR_UNITARIO=VALOR_UNITARIO'
      'VALOR_TOTAL=VALOR_TOTAL'
      'LPRODUTO=LPRODUTO')
    DataSource = dsQVendasItens
    BCDToCurrency = False
    Left = 696
    Top = 145
  end
  object frxDBClientes: TfrxDBDataset
    UserName = 'frxDBClientes'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CODINT=CODINT'
      'NOME=NOME'
      'ENDERECO=ENDERECO'
      'BAIRRO=BAIRRO'
      'CIDADE=CIDADE'
      'CEP=CEP'
      'TELEFONE=TELEFONE')
    DataSource = dsQClientes
    BCDToCurrency = False
    Left = 784
    Top = 153
  end
end
