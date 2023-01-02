unit UI.Main;

interface

uses
  ViewNavigator,
  Matrix.Client,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.MultiView;

type
  TForm5 = class(TForm)
    MultiView1: TMultiView;
    Layout1: TLayout;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1ViewportPositionChange(Sender: TObject; const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
    procedure ListBoxItem1Click(Sender: TObject);
  private
    { Private declarations }
    FMatrixCli: TMatrixaPi;
    FNav: TViewNavigator;
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses
  Matrix.Types.Response,
  UI.PublicRooms;

{$R *.fmx}

procedure TForm5.FormDestroy(Sender: TObject);
begin
  FNav.Free;
  FMatrixCli.Free;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  FNav := TViewNavigator.Create(nil);
  FNav.Parent := Layout1;
  FNav.RegisterFrame(TuiPublicRooms);
  FMatrixCli := TMatrixaPi.Create();
  FMatrixCli.PublicRooms(
    procedure(ARooms: TmtrPublicRooms; AHttp: IHTTPResponse)
    begin
      FNav.SendData(TuiPublicRooms, ARooms);
    end);
end;

procedure TForm5.ListBox1ViewportPositionChange(Sender: TObject;
const OldViewportPosition, NewViewportPosition: TPointF; const ContentSizeChanged: Boolean);
begin
  Caption := NewViewportPosition.Y.ToString;
end;

procedure TForm5.ListBoxItem1Click(Sender: TObject);
begin
  FNav.Navigate(TuiPublicRooms);
end;

end.
