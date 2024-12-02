program SistemaFinanceiro;

uses
  Vcl.Forms,
  UMovimento in '..\FORMS\UMovimento.pas' {Fm_Movimento},
  UDM in '..\FORMS\UDM.pas' {DM: TDataModule},
  U_Pesquisa in '..\FORMS\U_Pesquisa.pas' {FM_Pesquisa},
  U_Menu in '..\FORMS\U_Menu.pas' {Fm_Menu},
  U_Usuario in '..\FORMS\U_Usuario.pas' {FM_Usuario};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFm_Menu, Fm_Menu);
  Application.Run;
end.
