unit Core.ChatApp;

interface

uses
  MatrixaPi;

type
  TChatApp = class
  private
    FMatrixFactory: TMatrixClientFactory;
    FMatrix: IMatrixaPI;
  public
    constructor Create;
    destructor Destroy; override;
    property MatrixFactory: TMatrixClientFactory read FMatrixFactory write FMatrixFactory;
    property Matrix: IMatrixaPI read FMatrix write FMatrix;
  end;

implementation

{ TChatApp }

constructor TChatApp.Create;
begin
  FMatrixFactory := TMatrixClientFactory.Create;
  FMatrix := FMatrixFactory.CreateASyncClient;
end;

destructor TChatApp.Destroy;
begin
  FMatrixFactory.Free;
  inherited;
end;

end.
