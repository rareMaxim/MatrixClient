program MatrixClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  UI.Main in 'UI.Main.pas' {Form5},
  UI.PublicRooms in 'UI.PublicRooms.pas' {uiPublicRooms: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
