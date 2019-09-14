unit formVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask,
  Vcl.Imaging.jpeg, Data.DB;

type
  TfrmVendas = class(TForm)
    Panel1: TPanel;
    pnDados: TPanel;
    Panel3: TPanel;
    btnAdicionar: TBitBtn;
    btnAlterar: TBitBtn;
    btnExcluir: TBitBtn;
    btnConfirmar: TBitBtn;
    btnSair: TBitBtn;
    btnCancelar: TBitBtn;
    edtCodVenda: TEdit;
    btnPesquisar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    DBEdit1: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit6: TDBEdit;
    Label6: TLabel;
    DBEdit2: TDBEdit;
    dbeData: TDBEdit;
    Label4: TLabel;
    btnItens: TBitBtn;
    DBLookupComboBox1: TDBLookupComboBox;
    Image1: TImage;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
    procedure btnItensClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBEdit6Change(Sender: TObject);
  private

    procedure AbreVenda(CodVenda : Integer);
    procedure Habilita(Tipo : Boolean);
  public
    { Public declarations }
  end;

var
  frmVendas: TfrmVendas;

implementation

{$R *.dfm}

uses DataModule, formVendasItens;

procedure TfrmVendas.Habilita(Tipo : Boolean);
Begin

   btnAdicionar.Enabled := not Tipo;
   btnAlterar.Enabled := not Tipo;
   btnExcluir.Enabled := not Tipo;
   btnSair.Enabled := not Tipo;

   pnDados.Enabled := Tipo;
   btnConfirmar.Enabled := Tipo;
   btnCancelar.Enabled := Tipo;
End;

procedure TfrmVendas.AbreVenda(CodVenda: Integer);
begin

   Dm.tblVendas.Close;
   Dm.tblVendas.ParamByName('wCodVenda').AsInteger := CodVenda;
   Dm.tblVendas.Open;

end;


procedure TfrmVendas.btnAdicionarClick(Sender: TObject);
begin
   AbreVenda(-1);

   Habilita(True);
   Dm.tblVendas.Append;
   Dm.tblVendas.Edit;
   Dm.tblVendasDATA.AsDateTime := Date;
   dbeData.SetFocus;
end;

procedure TfrmVendas.btnAlterarClick(Sender: TObject);
begin

   Habilita(True);

   Dm.tblVendas.Edit;
   dbeData.SetFocus;

end;

procedure TfrmVendas.btnCancelarClick(Sender: TObject);
begin

   Dm.tblVendas.Cancel;
   Habilita(False);

end;

procedure TfrmVendas.btnConfirmarClick(Sender: TObject);
begin

  if Dm.tblVendasVALOR_TOTAL.AsCurrency <= 0 then
  begin
     Application.MessageBox('Por favor, informe o Valor Total', 'Erro', MB_ICONERROR + mb_ok);
     Exit;
  end;

   Dm.tblVendas.Post;
   Dm.tblVendas.ApplyUpdates;
   Habilita(False);

end;

procedure TfrmVendas.btnExcluirClick(Sender: TObject);
begin

   if (MessageBox(0, 'Deseja excluir essa Venda?', 'Vendas', MB_ICONQUESTION or MB_YESNO) = idNo) then
      Exit;

   Dm.tblVendas.Delete;
   Dm.tblVendas.ApplyUpdates;

end;

procedure TfrmVendas.btnItensClick(Sender: TObject);
var
   vValorBruto : Currency;

begin

    if Dm.tblVendas.IsEmpty then
    begin
      Application.MessageBox('Selecione uma venda', 'Erro', MB_ICONERROR + mb_ok);
      Exit;
    end;

    Habilita(True);

    Dm.tblVendasItens.Close;
    Dm.tblVendasItens.ParamByName('wCodVenda').AsInteger := Dm.tblVendasCODVENDA.AsInteger;
    Dm.tblVendasItens.Open;

    Application.CreateForm(TfrmVendasItens, frmVendasItens);
    frmVendasItens.ShowModal;
    frmVendasItens.Destroy;

    if not Dm.tblVendasItens.IsEmpty then
      Begin
         Dm.qSQL.Close;
         Dm.qSQL.SQL.Clear;
         Dm.qSQL.SQL.Add('Select Sum(VALOR_TOTAL) as TOTAL from VENDASITENS where CODVENDA = :wCODVENDA');
         Dm.qSQL.ParamByName('wCODVENDA').AsInteger := Dm.tblVendasCODVENDA.AsInteger;
         Dm.qSQL.Open;

         vValorBruto := Dm.qSQL.FieldByName('TOTAL').AsCurrency;
         Dm.qSQL.Close;

         btnAlterar.Click;
         Dm.tblVendasVALOR_BRUTO.AsCurrency := vValorBruto;

      End;

    Dm.tblVendasItens.Close;

end;

procedure TfrmVendas.btnSairClick(Sender: TObject);
begin

   Close;

end;

procedure TfrmVendas.btnPesquisarClick(Sender: TObject);
begin

   AbreVenda(StrToInt(edtCodVenda.Text));

   if Dm.tblVendas.IsEmpty then
      Application.MessageBox('Venda n�o encontrada!', 'Erro', MB_ICONERROR + mb_ok);
      edtCodVenda.Text := '';

end;

procedure TfrmVendas.DBEdit2Exit(Sender: TObject);
begin

   if Dm.tblVendasDESCONTO.Text = '' then
   begin
      Dm.tblVendasDESCONTO.Text := '0';
   end;

   Dm.tblVendasVALOR_TOTAL.AsCurrency := Dm.tblVendasVALOR_BRUTO.AsCurrency - Dm.tblVendasDESCONTO.AsCurrency;
end;

procedure TfrmVendas.DBEdit6Change(Sender: TObject);
begin
 { if Dm.tblVendas.FieldByName('VALOR_TOTAL').AsCurrency > 0 then
     begin
      btnConfirmar.Enabled := True;
     end; }
end;

procedure TfrmVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin

   Dm.tblVendas.Close;

end;

procedure TfrmVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

     case key of
     VK_F2: btnAdicionar.Click;
     VK_F3: btnAlterar.Click;
     VK_F4: btnConfirmar.Click;
     VK_F5: btnExcluir.Click;
     VK_F6: btnCancelar.Click;
     VK_F7: btnItens.Click;
     VK_ESCAPE: btnSair.Click;

     end;

end;

procedure TfrmVendas.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if (Key = #13) then
     begin
		      Key:=#0;
        Perform(WM_NextDlgCtl,0,0);
     end;

end;

procedure TfrmVendas.FormShow(Sender: TObject);
begin
   Habilita(False);

end;

end.
