program MatrixClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  UI.Main in 'UI.Main.pas' {Form5},
  UI.PublicRooms in 'UI.PublicRooms.pas' {uiPublicRooms: TFrame},
  UI.ChatLogin in 'UI.ChatLogin.pas' {uiChatLogin: TFrame},
  Core.ChatApp in 'Core.ChatApp.pas',
  UI.Chat in 'UI.Chat.pas' {uiChat: TFrame},
  Core.ChatLogin in 'Core.ChatLogin.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
