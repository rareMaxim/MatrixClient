unit UI.Chat;

interface

uses
  ViewNavigator,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls;

type

  [ViewInfo(TpmLifeStyle.CreateDestroy)]
  TuiChat = class(TFrame, IvnView)
  private
    { Private declarations }

  public
    procedure DataReceive(AData: TValue);
    { Public declarations }
  end;

implementation

{$R *.fmx}

{ TuiChat }

procedure TuiChat.DataReceive(AData: TValue);
begin

end;

end.
