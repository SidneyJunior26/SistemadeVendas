unit formConsultaClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg;

type
  TfrmCons_Clientes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    btnPesquisar: TBitBtn;
    btnSair: TBitBtn;
    btnLimpar: TBitBtn;
    ckCodigo: TCheckBox;
    edtCodigo: TEdit;
    ckNome: TCheckBox;
    edtNome: TEdit;
    btnImprimir: TBitBtn;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCons_Clientes: TfrmCons_Clientes;

implementation

{$R *.dfm}

uses DataModule;

procedure TfrmCons_Clientes.btnImprimirClick(Sender: TObject);
begin
   Dm.frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'Relatorios\ConsClientes.fr3');
   Dm.frxReport1.ShowReport;
end;

procedure TfrmCons_Clientes.btnLimparClick(Sender: TObject);
begin
   Dm.qClientes.Close;
   ckCodigo.Checked := False;
   ckNome.Checked := False;
   edtCodigo.Text := '';
   edtNome.Text := '';
end;

procedure TfrmCons_Clientes.btnPesquisarClick(Sender: TObject);
begin
   Dm.qClientes.Close;
   Dm.qClientes.SQL.Clear;
   Dm.qClientes.SQL.Add('Select * from Clientes');
   Dm.qClientes.SQL.Add('Where (CodInt is not null)');

   if ckCodigo.Checked then
      Begin
         Dm.qClientes.SQL.Add('And (CodInt = :wCodigo)');
         Dm.qClientes.ParamByName('wCodigo').AsInteger := StrToInt(edtCodigo.Text);
      End;

   if ckNome.Checked then
      Begin
         Dm.qClientes.SQL.Add('And (Nome like :wNome)');
         Dm.qClientes.ParamByName('wNome').AsString := edtNome.Text;
      End;
   Dm.qClientes.SQL.Add('order by Nome');
   Dm.qClientes.Open;
end;

procedure TfrmCons_Clientes.btnSairClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmCons_Clientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

     case key of
     VK_F2: btnPesquisar.Click;
     VK_F3: btnLimpar.Click;
     VK_F4: btnImprimir.Click;
     VK_ESCAPE: btnSair.Click;
     end;
end;

end.
