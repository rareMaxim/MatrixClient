unit Core.ChatApp;

interface

uses
  Matrix.Client;

type
  TChatApp = class
  private
    FMatrix: TMatrixaPi;
  public
    constructor Create;
    destructor Destroy; override;
    property Matrix: TMatrixaPi read FMatrix write FMatrix;
  end;

implementation

{ TChatApp }

constructor TChatApp.Create;
begin
  FMatrix := TMatrixaPi.Create();
  FMatrix.IsSyncMode := False;
end;

destructor TChatApp.Destroy;
begin
  FMatrix.Free;
  inherited;
end;

end.
