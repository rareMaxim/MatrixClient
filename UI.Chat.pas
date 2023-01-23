unit UI.Chat;

interface

uses
  ViewNavigator,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  Core.ChatApp, MatrixaPi.Core.Domain.RoomEvent;

type

  [ViewInfo(TpmLifeStyle.CreateDestroy)]
  TuiChat = class(TFrame, IvnView)
    Memo1: TMemo;
  private
    { Private declarations }
    FChatApp: TChatApp;
  public
    procedure DataReceive(AData: TValue);
    { Public declarations }
  end;

implementation

uses
  System.Generics.Collections;

{$R *.fmx}
{ TuiChat }

procedure TuiChat.DataReceive(AData: TValue);
begin
  if AData.IsType<TChatApp> then
    FChatApp := AData.AsType<TChatApp>;
  FChatApp.Matrix.OnMatrixRoomEventsReceived := procedure(AEvents: TList<TBaseRoomEvent>; Unknown: string)
    begin
      for var LEvent in AEvents do
      begin
        if LEvent is TNameRoomEvent then
          Memo1.Lines.Add((LEvent as TNameRoomEvent).Name);
      end;
    end;
end;

end.
