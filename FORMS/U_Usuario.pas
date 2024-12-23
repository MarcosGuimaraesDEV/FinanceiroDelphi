unit U_Usuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Mask;

type
  TFM_Usuario = class(TForm)
    Panel1: TPanel;
    BtNovo: TBitBtn;
    BtEditar: TBitBtn;
    BtDeletar: TBitBtn;
    BtGravar: TBitBtn;
    BtCancelar: TBitBtn;
    BtAtualizar: TBitBtn;
    BtPesquisar: TBitBtn;
    BtSair: TBitBtn;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBTipo: TDBComboBox;
    procedure BtNovoClick(Sender: TObject);
    procedure BtEditarClick(Sender: TObject);
    procedure BtDeletarClick(Sender: TObject);
    procedure BtGravarClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
    procedure BtAtualizarClick(Sender: TObject);
    procedure BtPesquisarClick(Sender: TObject);
    procedure BtSairClick(Sender: TObject);
    procedure TrataBotao();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FM_Usuario: TFM_Usuario;

implementation

{$R *.dfm}

uses UDM;

procedure TFM_Usuario.BtAtualizarClick(Sender: TObject);
begin
  TrataBotao();
  dm.QUsuario.Refresh;
  Messagedlg('Registro Atualizado com sucesso!',Mtinformation,[MbOk],0);
end;

procedure TFM_Usuario.BtCancelarClick(Sender: TObject);
begin
  if BtNovo.Enabled=False then
  begin
    TrataBotao();
    dm.QUsuario.Cancel;
    Messagedlg('A��o cancelada!',MtInformation,[MbOk],0);
  end
  else
    Messagedlg('N�o existe a��o a ser cancelada!',MtInformation,[MbOk],0);
end;

procedure TFM_Usuario.BtDeletarClick(Sender: TObject);
  begin
    if messagedlg('Deseja deletar o registro?',MtConfirmation,[MbOk,MbNo],0)=mrOk then
      begin
        dm.QUsuario.delete;
      end
      else
        abort;
end;
procedure TFM_Usuario.BtEditarClick(Sender: TObject);
begin
  if messagedlg('Deseja alterar o registro',MtConfirmation,[mbOk,MbNo],0)=mrOk then
  begin
    TrataBotao();
    dm.QUsuario.Edit;
  end
  else
    abort;
end;

procedure TFM_Usuario.BtGravarClick(Sender: TObject);
begin
  TrataBotao();
  dm.QUsuario.Post;
  Messagedlg('Registro salvo com sucesso!',MtInformation,[mbOk],0);
end;

procedure TFM_Usuario.BtNovoClick(Sender: TObject);
var prox:Integer;
begin
   TrataBotao();
   dm.QUsuario.open;
   dm.QUsuario.last;
   prox := dm.QUsuarioIDUSUARIO.AsInteger +1;
   dm.QUsuario.Append;
   dm.QUsuarioIDUSUARIO.AsInteger := prox;
   DBEdit3.SetFocus;
   dm.QUsuarioCADASTRO.AsDateTime := DATE;
end;

procedure TFM_Usuario.BtPesquisarClick(Sender: TObject);
begin
 //pesquisa
end;

procedure TFM_Usuario.BtSairClick(Sender: TObject);
begin
  close;
end;

procedure TFM_Usuario.TrataBotao;
begin
  BtNovo.Enabled := not BTNovo.Enabled;
  BtEditar.Enabled := not BtEditar.Enabled;
  BtDeletar.Enabled := not BtDeletar.Enabled;
  BtGravar.Enabled := not BtGravar.Enabled;
  BtAtualizar.Enabled := not BtAtualizar.Enabled;
end;

end.
