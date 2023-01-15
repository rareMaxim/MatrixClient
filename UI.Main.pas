unit UI.Main;

interface

uses
  ViewNavigator,
  MatrixaPi,
  Core.ChatApp,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.MultiView;

type
  TForm5 = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btnLogin: TSpeedButton;
    btnPublicRooms: TSpeedButton;
    btnChat: TSpeedButton;
    procedure btnChatClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnPublicRoomsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FNav: TViewNavigator;
    FChatApp: TChatApp;
  public
  end;

var
  Form5: TForm5;

implementation

uses
  FMX.DialogService,
  UI.Chat,
  UI.ChatLogin,
  UI.PublicRooms;

{$R *.fmx}

procedure TForm5.btnChatClick(Sender: TObject);
begin
  FNav.Navigate(TuiChat, FChatApp);
end;

procedure TForm5.btnLoginClick(Sender: TObject);
begin
  FNav.Navigate(TuiChatLogin, FChatApp);
end;

procedure TForm5.btnPublicRoomsClick(Sender: TObject);
begin
  FNav.Navigate(TuiPublicRooms, FChatApp);
end;

procedure TForm5.FormDestroy(Sender: TObject);
begin
  FNav.Free;
  FChatApp.Free;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  FNav := TViewNavigator.Create(nil);
  FNav.Parent := Layout1;
  FNav.RegisterFrame([TuiPublicRooms, TuiChatLogin, TuiChat]);
  FNav.OnNavigateCallback := procedure(AView: TvnViewInfo)
    begin
      if AView.Name = TuiChatLogin.ClassName then
        btnLogin.IsPressed := True
      else if AView.Name = TuiChat.ClassName then
        btnChat.IsPressed := True;
    end;
  FNav.OnNavigationFailedCallback := procedure(APage: string)
    begin
      TDialogService.ShowMessage('ViewNavigator - Page not found: ' + APage)
    end;
  FChatApp := TChatApp.Create;
  FNav.SendData(TuiChatLogin, FNav);
  FNav.Navigate(TuiChatLogin, FChatApp);
end;

end.
