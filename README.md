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

<details>
<summary> Little Endian - Big Endian </summary>

``` delphi
// byte swaps 16 bit values
function Swap16(V: WORD): WORD; { inline; }
asm
  XCHG    AL,AH
end;

// byte swaps 32 bit values
function Swap32(V: DWORD): DWORD; { inline; }
asm
  BSWAP   EAX
end;

// byte swaps 64 bit values
function Swap64(V: Int64): Int64; { inline; }
asm
  MOV     EDX,[EAX]
  MOV     EAX,[EAX+4]
  BSWAP   EAX
  BSWAP   EDX
end;
```

``` delphi
var DVal: Double;
    IVal: ^Int64;
    SVal: Int64;
begin

  DVal := 3.14159265;
  IVal := @DVal;

  SVal := Swap64(IVal^);
```

</details>


<details>
<summary> File operation - ShellAPI </summary>

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
</details>

<details>
<summary> String to char array buffer </summary>

``` delphi
procedure StrToCharBuffer(AStr: String; var ABuffer: Array of Char);
var BLen: Integer;
    SLen: Integer;
begin

  BLen := Length(ABuffer);
  SLen := Length(AStr);

  AStr := AStr + #0;

  if SLen >= BLen then
    begin
      SLen := BLen;
      AStr[SLen] := #0;
    end;

  ZeroMemory(@ABuffer[0], BLen * SizeOf(Char));
  CopyMemory(@ABuffer[0], @AStr[1], SLen * SizeOf(Char));
end;
```
</details>

<details>
<summary> Random String - First Idea </summary>

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
</details>

<details>
<summary> Colored Logger - bind in main program </summary>

``` delphi
uses
  ..., MyLogger, ...;
	
procedure TMainForm.FormCreate(Sender: TObject);
begin

  MyLogControl.Parent := Self;
  MyLogControl.Align := alRight;
  MyLogControl.Width := 250;
  
end;
``` 
</details>
