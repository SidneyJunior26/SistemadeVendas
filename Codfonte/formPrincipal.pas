unit formPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    Vendas1: TMenuItem;
    Consulta1: TMenuItem;
    Vendas2: TMenuItem;
    Clientes2: TMenuItem;
    Produtos2: TMenuItem;
    N3: TMenuItem;
    Sair1: TMenuItem;
    N1: TMenuItem;
    Image1: TImage;
    procedure Clientes1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Vendas1Click(Sender: TObject);
    procedure Clientes2Click(Sender: TObject);
    procedure Produtos2Click(Sender: TObject);
    procedure Vendas2Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses formClientes, formConsultaClientes, formConsultaProdutos, formConsultaVendas, formProdutos, formVendas;

procedure TfrmPrincipal.Clientes1Click(Sender: TObject);
begin
   Application.CreateForm(TfrmClientes, frmClientes);
   frmClientes.ShowModal;
   frmClientes.Destroy;
end;

procedure TfrmPrincipal.Clientes2Click(Sender: TObject);
begin
   Application.CreateForm(TfrmCons_Clientes, frmCons_Clientes);
   frmCons_Clientes.ShowModal;
   frmCons_Clientes.Destroy;
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
   Application.CreateForm(TfrmProdutos, frmProdutos);
   frmProdutos.ShowModal;
   frmProdutos.Destroy;
end;

procedure TfrmPrincipal.Produtos2Click(Sender: TObject);
begin
   Application.CreateForm(TfrmCons_Produtos, frmCons_Produtos);
   frmCons_Produtos.ShowModal;
   frmCons_Produtos.Destroy;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
   if (MessageBox(0, 'Deseja sair do sistema?', 'Sistema', MB_ICONQUESTION or MB_YESNO) = idNo) then
      Exit;

   frmPrincipal.Close;
end;

procedure TfrmPrincipal.Vendas1Click(Sender: TObject);
begin
   Application.CreateForm(TfrmVendas, frmVendas);
   frmVendas.ShowModal;
   frmVendas.Destroy;
end;

procedure TfrmPrincipal.Vendas2Click(Sender: TObject);
begin
   Application.CreateForm(TfrmCons_Vendas, frmCons_Vendas);
   frmCons_Vendas.ShowModal;
   frmCons_Vendas.Destroy;
end;

end.
