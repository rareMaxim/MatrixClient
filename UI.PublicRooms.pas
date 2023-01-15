unit UI.PublicRooms;

interface

uses
  ViewNavigator,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, Core.ChatApp;

type
  TuiPublicRooms = class(TFrame, IvnView)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
  private
    { Private declarations }
    FChatApp: TChatApp;
  public
    procedure DataReceive(AData: TValue);
    constructor Create(AOwner: TComponent); override;
    procedure GetPublicRooms;
    { Public declarations }
  end;

implementation

uses
  MatrixaPi.Types.Response, System.Net.HttpClient;

{$R *.fmx}
{ TuiPublicRooms }

constructor TuiPublicRooms.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TuiPublicRooms.DataReceive(AData: TValue);
begin
  if AData.IsType<TChatApp> then
  begin
    FChatApp := AData.AsType<TChatApp>;
    GetPublicRooms;
  end;
end;

procedure TuiPublicRooms.GetPublicRooms;
begin
  FChatApp.Matrix.PublicRooms(
    procedure(ARooms: TmtrPublicRooms; AHttp: IHTTPResponse)
    begin
      ListBox1.BeginUpdate;
      try
        for var LRoom in ARooms.Chunk do
        begin
          ListBox1.Items.Add(LRoom.Name);
        end;
      finally
        ListBox1.EndUpdate;
        ARooms.Free;
      end;
    end);
end;

end.
