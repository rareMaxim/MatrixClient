unit UI.PublicRooms;

interface

uses
  ViewNavigator,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation;

type
  TuiPublicRooms = class(TFrame, IvnView)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
  private
    { Private declarations }

  public
    procedure DataReceive(AData: TValue);
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
  Matrix.Types.Response;

{ TuiPublicRooms }

procedure TuiPublicRooms.DataReceive(AData: TValue);
var
  lRooms: TmtrPublicRooms;
begin
  if AData.IsType<TmtrPublicRooms> then
  begin
    lRooms := AData.AsType<TmtrPublicRooms>;
    for var LRoom in lRooms.Chunk do
    begin
      ListBox1.Items.Add(LRoom.Name);
    end;
    lRooms.Free;
  end;
end;

end.
