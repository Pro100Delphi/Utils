# Utils

'''pascal
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
'''