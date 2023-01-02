unit UI.Main;

interface

uses
  ViewNavigator,
  Matrix.Client,
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
    procedure btnLoginClick(Sender: TObject);
    procedure btnPublicRoomsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1ViewportPositionChange(Sender: TObject; const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
  private
    { Private declarations }

    FNav: TViewNavigator;
    FChatApp: TChatApp;
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses
  FMX.DialogService,
  Matrix.Types.Response,
  UI.ChatLogin,
  UI.PublicRooms;

{$R *.fmx}

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
  FNav.RegisterFrame([TuiPublicRooms, TuiChatLogin]);
  FNav.OnNavigationFailedCallback := procedure(APage: string)
    begin
      TDialogService.ShowMessage('ViewNavigator - Page not found: ' + APage)
    end;
  FChatApp := TChatApp.Create;

end;

procedure TForm5.ListBox1ViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF; const ContentSizeChanged: Boolean);
begin
  Caption := NewViewportPosition.Y.ToString;
end;

end.
