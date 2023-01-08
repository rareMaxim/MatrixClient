unit Core.ChatLogin;

interface

uses
  System.Generics.Collections;

type
  ILoginInfo = interface
    function GetType: string;
    function CheckPattern(const APattern: string): Boolean;
    function Name: string;
  end;

  TLoginInfo = class
  private
    FLoginInfoList: TList<ILoginInfo>;
  public
    constructor Create;
    destructor Destroy; override;
    function FindLoginInfo(const APattern: string): ILoginInfo;
  end;

implementation

uses
  System.SysUtils;

type
  TLoginInfoPassword = class(TInterfacedObject, ILoginInfo)
  public
    function GetType: string;
    function CheckPattern(const APattern: string): Boolean;
    function Name: string;
  end;

  TLoginInfoEmail = class(TInterfacedObject, ILoginInfo)
  public
    function GetType: string;
    function CheckPattern(const APattern: string): Boolean;
    function Name: string;
  end;

constructor TLoginInfo.Create;
begin
  inherited Create;
  FLoginInfoList := TList<ILoginInfo>.Create();
  FLoginInfoList.Add(TLoginInfoPassword.Create);
end;

destructor TLoginInfo.Destroy;
begin
  FLoginInfoList.Free;
  inherited Destroy;
end;

{ TLoginInfo }

function TLoginInfo.FindLoginInfo(const APattern: string): ILoginInfo;
begin

end;

{ TLoginInfoPassword }

function TLoginInfoPassword.CheckPattern(const APattern: string): Boolean;
begin
  Result := (not APattern.Contains('@') or (not APattern.Contains('+')));
end;

function TLoginInfoPassword.GetType: string;
begin
  Result := 'm.login.password';
end;

function TLoginInfoPassword.Name: string;
begin
  Result := 'Login';
end;

{ TLoginInfoEmail }

function TLoginInfoEmail.CheckPattern(const APattern: string): Boolean;
begin

end;

function TLoginInfoEmail.GetType: string;
begin

end;

function TLoginInfoEmail.Name: string;
begin

end;

end.
