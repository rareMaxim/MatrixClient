unit UI.ChatLogin;

interface

uses
  Citrus.Mandarin,
  ViewNavigator,
  Core.ChatApp,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Edit, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.ExtCtrls, FMX.ListBox, System.ImageList,
  FMX.ImgList, FMX.Objects, MatrixaPi.Types.Response,
  MatrixaPi.Core.Infrastructure.Dto.Login;

type
  TuiChatLogin = class(TFrame, IvnView, IvnChangeState)
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
    Memo1: TMemo;
    ComboBox1: TComboBox;
    ImageList1: TImageList;
    Layout1: TLayout;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure edtHomeServerExit(Sender: TObject);
  private
    { Private declarations }
    FChatApp: TChatApp;
    FViewNavigator: TViewNavigator;
    FGroupMandarin: TMandarinClientGroupe;
    procedure AddSSoProvider(AProv: TmtrLoginFlows.TIdentityProviders);
  public
    procedure DataReceive(AData: TValue);
    procedure ViewNavigatorChangeState(AStates: TvnViewInfoStates);
    { Public declarations }

  end;

implementation

uses

  MatrixaPi;

{$R *.fmx}

procedure TuiChatLogin.AddSSoProvider(AProv: TmtrLoginFlows.TIdentityProviders);
var
  LBtn: TImage;
begin
  FChatApp.Matrix.Download(
    procedure(AHttp: IHTTPResponse)
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          LBtn := TImage.Create(Layout1);
          LBtn.Align := TAlignLayout.Left;
          LBtn.Margins.Left := 5;
          LBtn.Parent := Layout1;
          LBtn.Bitmap.LoadFromStream(AHttp.ContentStream);
        end);
    end, AProv.Icon);
end;

procedure TuiChatLogin.Button1Click(Sender: TObject);
begin
  FChatApp.Matrix.LoginWithPassword(
    procedure(ALogin: TmtrLogin; AHttp: IHTTPResponse)
    begin
      FChatApp.Matrix.Authenticator.AccessToken := ALogin.AccessToken;
      FChatApp.Matrix.Start;
      Button1.Text := ALogin.UserId;
      FChatApp.Matrix.Start();
      ALogin.Free;
      TThread.Synchronize(nil,
        procedure
        begin
          FViewNavigator.Navigate('TuiChat');
        end);
    end, edtHomeServer.Text, edtLogin.Text, edtPassword.Text, 'Matrix Client by Delphi');
end;

{ TuiChatLogin }

procedure TuiChatLogin.DataReceive(AData: TValue);
begin
  if AData.IsType<TViewNavigator> then
    FViewNavigator := AData.AsType<TViewNavigator>
  else if AData.IsType<TChatApp> then
  begin
    FChatApp := AData.AsType<TChatApp>;
    FChatApp.Matrix.BaseAddress := edtHomeServer.Text;
    FGroupMandarin := TMandarinClientGroupe.Create(FChatApp.MatrixFactory.GetMandarinClient);
  end;

end;

procedure TuiChatLogin.edtHomeServerExit(Sender: TObject);
begin
  FChatApp.Matrix.LoginFlows(
    procedure(AFlows: TmtrLoginFlows; AHttp: IHTTPResponse)
    begin
      Layout1.DeleteChildren;

      //        TThread.Queue(nil,
      //          procedure
      begin
        for var LFlow in AFlows.Flows do
        begin

          Memo1.Lines.Add(LFlow.&Type);
          if LFlow.IdentityProviders <> nil then
          begin
            for var LProvider in LFlow.IdentityProviders do
            begin
              AddSSoProvider(LProvider);
              Memo1.Lines.Add('     ' + LProvider.Name)
            end;
          end
          else
          begin
            ComboBox1.Items.Add(LFlow.&Type)
          end;

        end;
        AFlows.Free;
      end;
      //          end);

    end, edtHomeServer.Text);
end;

procedure TuiChatLogin.ViewNavigatorChangeState(AStates: TvnViewInfoStates);
begin
  if TvnViewInfoState.IsVisible in AStates then
  begin

  end;
end;

end.
