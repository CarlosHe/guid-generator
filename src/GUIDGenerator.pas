unit GUIDGenerator;

interface

type

  IGUIDGenerator = interface
    ['{B018A540-719B-4088-AF9C-B427C157A1AC}']
    function SetWithoutBraces(const ABraces: Boolean = True): IGUIDGenerator;
    function SetWithoutHyphen(const AHyphen: Boolean = True): IGUIDGenerator;
    function SetUppercase(const AUppercase: Boolean = True): IGUIDGenerator;
    function Generate: string;
  end;

  TGUIDGenerator = class(TInterfacedObject, IGUIDGenerator)
  private
    { private declarations }
    FWithoutBraces: Boolean;
    FWithoutHyphen: Boolean;
    FUppercase: Boolean;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    class function New: IGUIDGenerator;
    function SetWithoutBraces(const AWithoutBraces: Boolean = True): IGUIDGenerator;
    function SetWithoutHyphen(const AWithoutHyphen: Boolean = True): IGUIDGenerator;
    function SetUppercase(const AUppercase: Boolean = True): IGUIDGenerator;
    function Generate: string;
  end;

implementation

uses
  System.SysUtils;

{ TGUIDGeneratorProvider }

constructor TGUIDGenerator.Create;
begin
  FWithoutBraces := False;
  FWithoutHyphen := False;
  FUppercase := False;
end;

function TGUIDGenerator.Generate: string;
var
  LGUID: TGUID;
  LHResult: HResult;
begin
  LHResult := CreateGUID(LGUID);
  Result := EmptyStr;
  if LHResult = S_OK then
    Result := LGUID.ToString;
  if FWithoutBraces then
    Result := Result.Replace('{', '').Replace('}', '');
  if FWithoutHyphen then
    Result := Result.Replace('-', '');
  if FUppercase then
    Result := Result.ToUpper;
end;

class function TGUIDGenerator.New: IGUIDGenerator;
begin
  Result := TGUIDGenerator.Create;
end;

function TGUIDGenerator.SetUppercase(const AUppercase: Boolean): IGUIDGenerator;
begin
  Result := Self;
  FUppercase := AUppercase;
end;

function TGUIDGenerator.SetWithoutBraces(const AWithoutBraces: Boolean): IGUIDGenerator;
begin
  Result := Self;
  FWithoutBraces := AWithoutBraces;
end;

function TGUIDGenerator.SetWithoutHyphen(const AWithoutHyphen: Boolean = True): IGUIDGenerator;
begin
  Result := Self;
  FWithoutHyphen := AWithoutHyphen;
end;

end.
