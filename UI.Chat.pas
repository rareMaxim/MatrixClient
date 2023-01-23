unit UI.Chat;

interface

uses
  ViewNavigator,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  Core.ChatApp, MatrixaPi.Core.Domain.RoomEvent, FMX.Layouts;

type

  [ViewInfo(TpmLifeStyle.CreateDestroy)]
  TuiChat = class(TFrame, IvnView)
    Memo1: TMemo;
    Memo2: TMemo;
    Layout1: TLayout;
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
      for var LRoom in FChatApp.Matrix.JoinedRooms do
        Memo1.Lines.Add(LRoom.Name);
      for var LEvent in AEvents do
      begin
        if LEvent is TTopicRoomEvent then
        begin
          var
          LTopic := (LEvent as TTopicRoomEvent).Topic;
          Memo2.Lines.Add('Topic: ' + LTopic);
        end;
      end;
    end;
end;

end.
