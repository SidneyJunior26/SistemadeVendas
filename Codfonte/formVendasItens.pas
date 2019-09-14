unit formVendasItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.DBCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.jpeg;

type
  TfrmVendasItens = class(TForm)
    Panel3: TPanel;
    btnAdicionar: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    btnSair: TBitBtn;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    pnDados: TPanel;
    dbeCodigo: TDBEdit;
    Label1: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBLookupComboBox1Exit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure Habilita(Tipo : Boolean);
  public
    { Public declarations }
  end;

var
  frmVendasItens: TfrmVendasItens;

implementation

{$R *.dfm}

uses DataModule;

procedure TfrmVendasItens.Habilita(Tipo : Boolean);
Begin
   btnAdicionar.Enabled := not Tipo;
   btnAlterar.Enabled := not Tipo;
   btnExcluir.Enabled := not Tipo;
   btnSair.Enabled := not Tipo;

   pnDados.Enabled := Tipo;
   btnConfirmar.Enabled := Tipo;
   btnCancelar.Enabled := Tipo;
End;


procedure TfrmVendasItens.btnAdicionarClick(Sender: TObject);
begin
   Habilita(True);
   Dm.tblVendasItens.Append;
   Dm.tblVendasItens.Edit;
   Dm.tblVendasItensCODVENDA.AsInteger := Dm.tblVendasCODVENDA.AsInteger;
   Dm.tblVendasItensQTDE.AsInteger := 1;
   DBLookupComboBox1.SetFocus;
end;

procedure TfrmVendasItens.btnAlterarClick(Sender: TObject);
begin
   Habilita(True);
   Dm.tblVendasItens.Edit;
   dbeCodigo.SetFocus;
end;

procedure TfrmVendasItens.btnCancelarClick(Sender: TObject);
begin
   Dm.tblVendasItens.Cancel;
   Habilita(False);
end;

procedure TfrmVendasItens.btnConfirmarClick(Sender: TObject);
begin

  if Dm.tblVendasItensQTDE.AsInteger > Dm.tblProdutosQTDE.AsInteger then
  begin
     Application.MessageBox('Produto sem estoque suficiente', 'Erro', MB_ICONERROR + mb_ok);
     btnCancelar.Click;
     Exit;
  end;

   Dm.tblProdutos.Edit;
   Dm.tblProdutosQTDE.AsCurrency := Dm.tblProdutosQTDE.AsCurrency - Dm.tblVendasItensQTDE.AsCurrency;
   Dm.tblProdutos.Post;
   Dm.tblProdutos.ApplyUpdates;

   Dm.tblVendasItens.Post;
   Dm.tblVendasItens.ApplyUpdates;
   Habilita(False);
end;

procedure TfrmVendasItens.btnExcluirClick(Sender: TObject);
begin
   if (MessageBox(0, 'Deseja excluir o produto selecionado?', 'Produtos da Venda', MB_ICONQUESTION or MB_YESNO) = idNo) then
      Exit;

   Dm.tblProdutos.Edit;
   Dm.tblProdutosQTDE.AsCurrency := Dm.tblProdutosQTDE.AsCurrency + Dm.tblVendasItensQTDE.AsCurrency;
   Dm.tblProdutos.Post;
   Dm.tblProdutos.ApplyUpdates;

   Dm.tblVendasItens.Delete;
   Dm.tblVendasItens.ApplyUpdates;
end;

procedure TfrmVendasItens.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmVendasItens.DBEdit3Exit(Sender: TObject);
begin
   Dm.tblVendasItensVALOR_TOTAL.AsCurrency := Dm.tblVendasItensVALOR_UNITARIO.AsCurrency * Dm.tblVendasItensQTDE.AsCurrency;
end;

procedure TfrmVendasItens.DBLookupComboBox1Exit(Sender: TObject);
begin

   if not Dm.tblVendasItensCODPRODUTO.IsNull then
      Begin
         Dm.qSQL.Close;
         Dm.qSQL.SQL.Clear;
         Dm.qSQL.SQL.Add('Select VALOR_VENDA from PRODUTOS where CODINT = :wCODINT');
         Dm.qSQL.ParamByName('wCODINT').AsInteger := Dm.tblVendasItensCODPRODUTO.AsInteger;
         Dm.qSQL.Open;

         Dm.tblVendasItensVALOR_UNITARIO.AsCurrency := Dm.qSQL.FieldByName('VALOR_VENDA').AsCurrency;
         Dm.qSQL.Close;
      End;

end;

procedure TfrmVendasItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

     case key of
     VK_F2: btnAdicionar.Click;
     VK_F3: btnAlterar.Click;
     VK_F4: btnConfirmar.Click;
     VK_F5: btnExcluir.Click;
     VK_F6: btnCancelar.Click;
     VK_ESCAPE: btnSair.Click;

     end;
end;

procedure TfrmVendasItens.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
     begin
		      Key:=#0;
        Perform(WM_NextDlgCtl,0,0);
     end;
end;

procedure TfrmVendasItens.FormShow(Sender: TObject);
begin
   Habilita(False);
end;

end.
