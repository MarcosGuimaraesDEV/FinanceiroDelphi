unit UMovimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.Mask;

type
  TFm_Movimento = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtNovo: TBitBtn;
    BtEditar: TBitBtn;
    BtDeletar: TBitBtn;
    BtGravar: TBitBtn;
    BtCancelar: TBitBtn;
    BtAtualizar: TBitBtn;
    BtPesquisar: TBitBtn;
    BtSair: TBitBtn;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    DBTipo: TDBComboBox;
    procedure BtSairClick(Sender: TObject);
    procedure BtNovoClick(Sender: TObject);
    procedure BtEditarClick(Sender: TObject);
    procedure BtDeletarClick(Sender: TObject);
    procedure BtGravarClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
    procedure BtAtualizarClick(Sender: TObject);
    procedure TrataBotao();
    procedure BtPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fm_Movimento: TFm_Movimento;

implementation

{$R *.dfm}

uses UDM, U_Pesquisa;

procedure TFm_Movimento.BtAtualizarClick(Sender: TObject);
begin
  TrataBotao();
  dm.QMovimento.Refresh;
  messagedlg('Registro atualizado com sucesso!',MtInformation,[mbOk],0);
end;

procedure TFm_Movimento.BtCancelarClick(Sender: TObject);
begin
  TrataBotao();
  dm.QMovimento.Cancel;
  messagedlg('A��o cancelada',MtInformation,[mbOk],0);
end;

procedure TFm_Movimento.BtDeletarClick(Sender: TObject);
begin
  TrataBotao();
  if messagedlg('Deseja deleta o registro?',MtConfirmation,[mbOk,mbNo],0)=mrOK then
  begin
    TrataBotao();
    dm.QMovimento.delete;
  end
  else
    TrataBotao();
    abort;

end;

procedure TFm_Movimento.BtEditarClick(Sender: TObject);
begin
  TrataBotao();
  if messagedlg('Deseja editar o registro?',Mtconfirmation,[mbOk,mbNo],0)=mrOk then
  begin
    dm.QMovimento.Edit;
  end
  else
    TrataBotao();
    abort;
end;

procedure TFm_Movimento.BtGravarClick(Sender: TObject);
begin
  TrataBotao();
  dm.QMovimento.Post;
  messagedlg('Registro salvo!',MtInformation,[mbOk],0);
end;

procedure TFm_Movimento.BtNovoClick(Sender: TObject);
  var prox:Integer;
begin
  TrataBotao();
  dm.QMovimento.Open;
  dm.QMovimento.Last;
  prox:= dm.QMovimentoIDMOVIMENTO.AsInteger +1;
  dm.QMovimento.Append;
  dm.QMovimentoIDMOVIMENTO.AsInteger := prox;
  dbedit3.SetFocus;
  dm.QMovimentoCADASTRO.AsDateTime:=DATE;
end;

procedure TFm_Movimento.BtPesquisarClick(Sender: TObject);
begin
  Fm_Pesquisa := TFm_Pesquisa.Create(self);
  Fm_Pesquisa.ShowModal;
  try
    if FM_Pesquisa.Codigo > 0 then
      begin
        dm.QMovimento.Open();
        dm.QMovimento.Locate('IDMOVIMENTO',FM_Pesquisa.Codigo,[]);
      end;
  finally
    Fm_pesquisa := nil;
    Fm_pesquisa.Free;
  end;
end;

procedure TFm_Movimento.BtSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFm_Movimento.TrataBotao;
begin
  BtNovo.Enabled := not BTNovo.Enabled;
  BtEditar.Enabled := not BtEditar.Enabled;
  BtDeletar.Enabled := not BtDeletar.Enabled;
  BtGravar.Enabled := not BtGravar.Enabled;
  BtAtualizar.Enabled := not BtAtualizar.Enabled;
end;

end.
