# Utils

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
```

```delphi
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