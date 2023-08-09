# Utils

<details>
 <summary> Bits </summary>
```pascal
procedure PrintBits(AVal: Cardinal);
var i: Integer;
begin
  for i := 31 downto 0 do
    begin
      Write((AVal shr i) and $01);

      if i mod 4 = 0 then
        Write(' ');
    end;

  Writeln('');
end;
```
</details>

```delphi
function DeleteFile(AFileName: String): Boolean;
var FOS : TSHFileOpStruct;
begin
  FillChar(FOS, SizeOf(FOS), 0);

  FOS.wFunc   := FO_DELETE;
  FOS.pFrom   := PChar(AFileName + #0);
  FOS.fFlags  := FOF_NOCONFIRMATION or FOF_SILENT;

  Result := ShFileOperation(FOS) = 0;
end;

function RenameFile(AOldFileName, ANewFileName: String): Boolean;
var FOS : TSHFileOpStruct;
begin

  FillChar(FOS, SizeOf(FOS), 0);

  FOS.wFunc   := FO_RENAME;
  FOS.pFrom   := PChar(AOldFileName + #0);
  FOS.pTo     := PChar(ANewFileName + #0);
  FOS.fFlags  := FOF_SILENT or FOF_SIMPLEPROGRESS or FOF_NOCONFIRMATION;

  Result := ShFileOperation(FOS) = 0;
end;
```


``` delphi
function RandomStr(ALow, AHigh, ADigs: Integer; AOther: String = ''): String;
const
  L = 'abcdefghijklmnopqrstuvwxyz';
  H = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  D = '0123456789';
var
  i: Integer;
  R: Integer;

  C: Char;
  a, b: Integer;
begin
  Result := '';

  for i := 1 to ALow do
    begin
      R := Random(Length(L)) + 1;
      Result := Result + L[R]
    end;

  for i := 1 to AHigh do
    begin
      R := Random(Length(H)) + 1;
      Result := Result + H[R]
    end;

  for i := 1 to ADigs do
    begin
      R := Random(Length(D)) + 1;
      Result := Result + D[R]
    end;

  for i := 1 to Length(Result) do
    begin
      a := Random(Length(Result)) + 1;
      b := Random(Length(Result)) + 1;

      C := Result[a];
      Result[a] := Result[b];
      Result[b] := C;
    end;
end;
```