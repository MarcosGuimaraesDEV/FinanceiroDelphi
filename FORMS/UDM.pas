unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.IBBase;

type
  TDM = class(TDataModule)
    Conexao: TFDConnection;
    FDTransaction1: TFDTransaction;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QMovimento: TFDQuery;
    DsMovimento: TDataSource;
    QMovimentoIDMOVIMENTO: TIntegerField;
    QMovimentoCADASTRO: TDateField;
    QMovimentoUSUARIO: TStringField;
    QMovimentoTIPO: TStringField;
    QMovimentoVALOR: TFMTBCDField;
    QUsuario: TFDQuery;
    DsUsuario: TDataSource;
    QUsuarioIDUSUARIO: TIntegerField;
    QUsuarioNOME: TStringField;
    QUsuarioSENHA: TStringField;
    QUsuarioTIPO: TStringField;
    QUsuarioCADASTRO: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
