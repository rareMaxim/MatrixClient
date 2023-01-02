unit UI.ChatLogin;

interface

uses
  ViewNavigator,
  Core.ChatApp,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Edit;

type
  TuiChatLogin = class(TFrame, IvnView)
    lytHomeServer: TLayout;
    lblHomeServer: TLabel;
    edtHomeServer: TEdit;
    lytLogin: TLayout;
    lblLogin: TLabel;
    edtLogin: TEdit;
    lytPassword: TLayout;
    lblPassword: TLabel;
    edtPassword: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FChatApp: TChatApp;
  public
    procedure DataReceive(AData: TValue);
    { Public declarations }

  end;

implementation

uses
  Matrix.Types.Response,
  Matrix.Client;

{$R *.fmx}

procedure TuiChatLogin.Button1Click(Sender: TObject);
begin
  FChatApp.Matrix.Url := edtHomeServer.Text;
  FChatApp.Matrix.LoginWithPassword(edtLogin.Text, edtPassword.Text,
    procedure(ALogin: TmtrLogin; AHttp: IHTTPResponse)
    begin
      FChatApp.Matrix.Authenticator.AccessToken := ALogin.AccessToken;
      FChatApp.Matrix.Start;
      Button1.Text := ALogin.UserId;
      ALogin.Free;
    end);
end;

{ TuiChatLogin }

procedure TuiChatLogin.DataReceive(AData: TValue);
begin
  if AData.IsType<TChatApp> then
  begin
    FChatApp := AData.AsType<TChatApp>;
  end;
end;

end.
