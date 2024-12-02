unit U_Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls;

type
  TFm_Menu = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    StatusBar1: TStatusBar;
    SpeedButton3: TSpeedButton;
    Label1: TLabel;
    Timer1: TTimer;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fm_Menu: TFm_Menu;

implementation

{$R *.dfm}

uses UMovimento, U_Usuario;

procedure TFm_Menu.SpeedButton1Click(Sender: TObject);
begin
  if application.MessageBox('Deseja sair do sistema?','Confirmação',mb_YesNo + MB_ICONQUESTION) = id_Yes then
  begin
  application.Terminate;
  end
  else
    abort;
end;

procedure TFm_Menu.SpeedButton2Click(Sender: TObject);
begin
  FM_Usuario := TFM_Usuario.Create(self);
  try
    FM_Usuario.ShowModal;
  finally
  FM_Usuario.Free;
  FM_Usuario := nil;
  end;
end;

procedure TFm_Menu.SpeedButton3Click(Sender: TObject);
begin
  FM_Movimento := TFM_Movimento.Create(self);
  try
    FM_movimento.ShowModal;
  finally
      FM_Movimento.Free;
      FM_Movimento := Nil;
  end;
end;

procedure TFm_Menu.Timer1Timer(Sender: TObject);
begin
  Statusbar1.Panels[0].Text := DateToStr(now);
  Statusbar1.Panels[1].Text := TimeToStr(now);
end;

end.
