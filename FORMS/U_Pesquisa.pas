unit U_Pesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxSmartMemo, frCoreClasses,
  frxClass, frxDBSet, frxExportBaseDialog, frxExportPDF;

type
  TFM_Pesquisa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtSair: TBitBtn;
    BtPesquisar: TBitBtn;
    BtTransferir: TBitBtn;
    DBNavigator1: TDBNavigator;
    BtImprimir: TBitBtn;
    DBChave: TComboBox;
    Ed_descricao: TEdit;
    MK_Fim: TMaskEdit;
    LB_Chave: TLabel;
    LB_Descricao: TLabel;
    LB_Inicio: TLabel;
    LB_Fim: TLabel;
    DBGrid1: TDBGrid;
    MK_Inicio: TMaskEdit;
    QPesquisa: TFDQuery;
    DsPesquisa: TDataSource;
    QPesquisaIDMOVIMENTO: TIntegerField;
    QPesquisaCADASTRO: TDateField;
    QPesquisaUSUARIO: TStringField;
    QPesquisaTIPO: TStringField;
    QPesquisaVALOR: TFMTBCDField;
    LBRegistros: TLabel;
    LBEntrada: TLabel;
    LBSaida: TLabel;
    LBCaixa: TLabel;
    Relatorio: TfrxReport;
    frxDBRelatorio: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    procedure BtSairClick(Sender: TObject);
    procedure DBChaveChange(Sender: TObject);
    procedure BtPesquisarClick(Sender: TObject);
    procedure BtTransferirClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BtImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Codigo:Integer;
  end;

var
  FM_Pesquisa: TFM_Pesquisa;
  Entrada,Saida,Caixa:REAL;
implementation

{$R *.dfm}

uses UDM;

procedure TFM_Pesquisa.BtTransferirClick(Sender: TObject);
begin
  //Transferir o ID para a vari�vel Codigo
  if QPesquisa.RecordCount > 0 then
    begin
      Codigo:=QPesquisaIDMOVIMENTO.AsInteger;
    end;
end;

procedure TFM_Pesquisa.BtImprimirClick(Sender: TObject);
begin
//imprimir relat�rio
  Relatorio.Variables['Entrada']:=Entrada;
  Relatorio.Variables['Saida']:=Saida;
  Relatorio.Variables['Caixa']:=Caixa;
  Relatorio.ShowReport();
end;

procedure TFM_Pesquisa.BtPesquisarClick(Sender: TObject);
begin
  //Realiza consulta
  QPesquisa.Close;
  QPesquisa.sql.Add('');
  Qpesquisa.sql.Clear;
  QPesquisa.Params.Clear;
  Qpesquisa.sql.Add('select * from movimento');
  case DBChave.ItemIndex of  //Pesquisa por c�digo
    0: begin
      QPesquisa.SQL.Add('Where idmovimento =:pcodigo');
      QPesquisa.ParamByName('pcodigo').AsInteger:=StrToInt(Ed_Descricao.Text);
    end;
    1: begin //Pesquisa por tipo
      QPesquisa.SQL.Add('Where tipo =:ptipo');
      QPesquisa.ParamByName('ptipo').AsString:=(ED_Descricao.Text);
    end;
    2: begin  //Pesquisa por Data
       QPesquisa.SQL.Add('Where cadastro =:pcadastro');
       QPesquisa.ParamByName('pcadastro').AsDate:=StrToDate(MK_Inicio.Text);
    end;
    3: begin  //Pesquisa por per�odo
      QPesquisa.SQL.Add('Where cadastro between :pInicio and :pFim');
      QPesquisa.ParamByName('pInicio').AsDate:=StrToDate(MK_Inicio.Text);
      QPesquisa.ParamByName('pFim').AsDate:=StrToDate(MK_Fim.Text);
    end;
    4: begin //Pesquisa todos os registros
      QPesquisa.SQL.Add('order by idmovimento');
    end;
  end;
  //Mostra o resultado da consulta
  QPesquisa.Open();
  //Mostra a quantidade de registros no label quantidade
  LBRegistros.Caption:= 'Registros: '+IntToStr(QPesquisa.RecordCount);
  //Soma as entradas
  QPesquisa.First;
  Entrada:=0.0;
  Saida:=0.0;
  while not QPesquisa.Eof do
    begin
      if QPesquisaTIPO.AsString='ENTRADA' then
        begin
          Entrada:=Entrada + QPesquisaVALOR.AsFloat;
        end;
      if QPesquisaTIPO.AsString='SA�DA' then
        begin
          Saida:=Saida + QPesquisaVALOR.AsFloat;
        end;
        QPesquisa.Next;
    end;
  Caixa:= Entrada-Saida;
  LBEntrada.Caption:='Entrada: ' + formatfloat('R$ ##,##0.00',Entrada);
  LBSaida.Caption:= 'Sa�da: ' + formatfloat('R$ ##,##0.00',Saida);
  LBCaixa.Caption:= 'Caixa: ' + formatfloat('R$ ##,##0.00',Caixa);
  //Se n�o encontrar mostra a mensagem
  if QPesquisa.IsEmpty then
  begin
    Messagedlg('Nenhum registro encontrado!',MtInformation,[mbOK],0);
  end;

end;

procedure TFM_Pesquisa.BtSairClick(Sender: TObject);
begin
  close;
end;

procedure TFM_Pesquisa.DBChaveChange(Sender: TObject);
begin
  //Habilita e desabilita componentes
  //Pesquisa por c�digo
  case DBChave.ItemIndex of 0:
    begin
      Ed_Descricao.Visible:=true;
      LB_Descricao.Caption:='Digite o c�digo:';
      LB_Inicio.Visible:=false;
      MK_Inicio.Visible:=false;
      LB_Fim.Visible:=false;
      MK_Fim.Visible:=false;
      ED_Descricao.SetFocus;
      ED_Descricao.Clear;
    end;
  1:
    begin
      // Pesquisa por descri��o
      ED_Descricao.Visible:=true;
      LB_Descricao.Caption:='Digite o tipo:';
      LB_Inicio.Visible:=false;
      MK_Inicio.Visible:=false;
      LB_Fim.Visible:=false;
      MK_Fim.Visible:=false;
      ED_Descricao.SetFocus;
      ED_Descricao.Clear;
    end;
   2:
    begin
      //Pesquisa por data
      ED_Descricao.Visible:=false;
      LB_Descricao.Visible:=false;
      LB_Inicio.Visible:=true;
      LB_Inicio.Caption:='Digite a data:';
      MK_Inicio.Visible:=true;
      LB_Fim.Visible:=false;
      MK_fim.Visible:=false;
      MK_Inicio.SetFocus;
      MK_Inicio.Clear;
    end;
   3:
    begin
      //Pesquisa por per�odo
      ED_Descricao.Visible:=false;
      LB_Descricao.Visible:=true;
      LB_Descricao.Caption:='Digite o per�odo:';
      MK_Inicio.Visible:=true;
      LB_Inicio.Visible:=true;
      LB_Inicio.Caption:='Inicio:';
      MK_Fim.Visible:=true;
      LB_Fim.Visible:=true;
      MK_Inicio.SetFocus;
      MK_Inicio.Clear;
      MK_Fim.Clear;
    end;
    4:
      begin
        //Pesquisa por todos os registros
        ED_Descricao.Visible:=false;
        LB_Descricao.Visible:=true;
        LB_Descricao.Caption:='Mostrando todos os registros:';
        LB_Inicio.Visible:=false;
        MK_Inicio.Visible:=false;
        LB_Fim.Visible:=false;
        MK_Fim.Visible:=false;
        ED_Descricao.Clear;
        MK_Inicio.Clear;
        MK_Fim.Clear;
      end;
  end;
end;

procedure TFM_Pesquisa.DBGrid1DblClick(Sender: TObject);
begin
  //Fazer a fun��o do bot�o trasnferir com duplo clique
  BtTransferir.Click;
end;

procedure TFM_Pesquisa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //Enter igual ao tab
  if key=#13 then
    begin
      key:=#0;
      Perform(wm_nextDlgCtl,0,0);
    end;
end;

end.
