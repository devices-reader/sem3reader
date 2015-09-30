unit realz;

interface

type
  bytes4 = array[0..3] of byte;

  combo4 = record case byte of
    0: (siT:  single);
    1: (mpbT: bytes4);
  end;

  bytes8 = array[0..7] of byte;

  combo8 = record case byte of
    0: (dbT:  double);
    1: (mpbT: bytes8);
  end;

function FromFloat(reT: bytes4): extended;
function FromDouble(reT: bytes8): extended;
function ToFloat(exT: extended): bytes4;
function PopFloat: extended;
function PopDouble: extended;
function PopFloatRaw: bytes4;
function PopDoubleRaw: bytes8;
function Float2Str(e: extended): string;
function Double2Str(e: extended): string;
function Float2StrR(e: extended): string;
function Double2StrR(e: extended): string;
function Float2StrL(e: extended): string;
function Double2StrL(e: extended): string;
function FloatRaw2StrR(r: bytes4): string;
function FloatRaw2StrL(r: bytes4): string;
function DoubleRaw2StrR(r: bytes8): string;
function DoubleRaw2StrL(r: bytes8): string;

implementation

uses SysUtils, main, support, output;

function FromFloat(reT: bytes4): extended;
var
  coT:  combo4;
begin
  with coT do begin
    mpbT[0] := reT[3];
    mpbT[1] := reT[2];
    mpbT[2] := reT[1];
    mpbT[3] := reT[0];

    Result := siT;
  end;
end;

function FromDouble(reT: bytes8): extended;
var
  coT:  combo8;
begin
  with coT do begin
    mpbT[0] := reT[7];
    mpbT[1] := reT[6];
    mpbT[2] := reT[5];
    mpbT[3] := reT[4];
    mpbT[4] := reT[3];
    mpbT[5] := reT[2];
    mpbT[6] := reT[1];
    mpbT[7] := reT[0];

    Result := dbT;
  end;
end;

function ToFloat(exT: extended): bytes4;
var
  coT:  combo4;
begin
  with coT do begin
    siT := exT;

    Result[0] := mpbT[3];
    Result[1] := mpbT[2];
    Result[2] := mpbT[1];
    Result[3] := mpbT[0];
  end;
end;

function PopFloat: extended;
var
  reT:  bytes4;
begin
  reT[0] := PopByte;
  reT[1] := PopByte;
  reT[2] := PopByte;
  reT[3] := PopByte;
  Result := FromFloat(reT);
end;

function PopDouble: extended;
var
  reT:  bytes8;
begin
  reT[0] := PopByte;
  reT[1] := PopByte;
  reT[2] := PopByte;
  reT[3] := PopByte;
  reT[4] := PopByte;
  reT[5] := PopByte;
  reT[6] := PopByte;
  reT[7] := PopByte;
  Result := FromDouble(reT);
end;

function PopFloatRaw: bytes4;
var
  reT:  bytes4;
begin
  reT[0] := PopByte;
  reT[1] := PopByte;
  reT[2] := PopByte;
  reT[3] := PopByte;
  Result := reT;
end;

function PopDoubleRaw: bytes8;
var
  reT:  bytes8;
begin
  reT[0] := PopByte;
  reT[1] := PopByte;
  reT[2] := PopByte;
  reT[3] := PopByte;
  reT[4] := PopByte;
  reT[5] := PopByte;
  reT[6] := PopByte;
  reT[7] := PopByte;
  Result := reT;
end;

function Float2Str(e: extended): string;
begin
  with frmMain do
    Result := FloatToStrF(e, ffFixed, 8, updDigits.Position);
end;

function Double2Str(e: extended): string;
begin
  with frmMain do
    Result := FloatToStrF(e, ffFixed, 16, (updDigits.Position*3) div 2);
end;

function Bytes4Raw2Str(r: bytes4): string;
begin
  Result := '';
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) then Result := 'not ready'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FE) then Result := 'no response'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FD) then Result := 'bad response'

  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $E0) then Result := 'empty'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $E1) then Result := 'not supported'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $E2) then Result := 'not presented'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $E3) then Result := 'inquiry error'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $E4) then Result := 'hardware error'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $E5) then Result := 'config. error'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $E6) then Result := 'canal disabled'
end;

function Bytes8Raw2Str(r: bytes8): string;
begin
  Result := '';
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) and (r[4] = $FF) and (r[5] = $FF) and (r[6] = $FF) and (r[7] = $FF) then Result := 'not ready'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) and (r[4] = $FF) and (r[5] = $FF) and (r[6] = $FF) and (r[7] = $FE) then Result := 'no response'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) and (r[4] = $FF) and (r[5] = $FF) and (r[6] = $FF) and (r[7] = $FD) then Result := 'bad response'

  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) and (r[4] = $FF) and (r[5] = $FF) and (r[6] = $FF) and (r[7] = $E0) then Result := 'empty'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) and (r[4] = $FF) and (r[5] = $FF) and (r[6] = $FF) and (r[7] = $E1) then Result := 'not supported'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) and (r[4] = $FF) and (r[5] = $FF) and (r[6] = $FF) and (r[7] = $E2) then Result := 'not presented'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) and (r[4] = $FF) and (r[5] = $FF) and (r[6] = $FF) and (r[7] = $E3) then Result := 'inquiry error'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) and (r[4] = $FF) and (r[5] = $FF) and (r[6] = $FF) and (r[7] = $E4) then Result := 'hardware error'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) and (r[4] = $FF) and (r[5] = $FF) and (r[6] = $FF) and (r[7] = $E5) then Result := 'config. error'
  else
  if (r[0] = $FF) and (r[1] = $FF) and (r[2] = $FF) and (r[3] = $FF) and (r[4] = $FF) and (r[5] = $FF) and (r[6] = $FF) and (r[7] = $E6) then Result := 'canal disabled'
end;

function Float2StrR(e: extended): string;
begin
  Result := PackStrR(Float2Str(e),GetColWidth);
end;

function Double2StrR(e: extended): string;
begin
  Result := PackStrR(Double2Str(e),GetColWidth);
end;

function Float2StrL(e: extended): string;
begin
  Result := PackStrL(Float2Str(e),GetColWidth);
end;

function Double2StrL(e: extended): string;
begin
  Result := PackStrL(Double2Str(e),GetColWidth);
end;

function FloatRaw2StrR(r: bytes4): string;
var
  s:  string;  
begin
  s := Bytes4Raw2Str(r);
  if s = '' then s := Float2Str(FromFloat(r));
  Result := PackStrR(s,GetColWidth);
end;

function FloatRaw2StrL(r: bytes4): string;
var
  s:  string;  
begin
  s := Bytes4Raw2Str(r);
  if s = '' then s := Float2Str(FromFloat(r));
  Result := PackStrL(s,GetColWidth);
end;

function DoubleRaw2StrR(r: bytes8): string;
var
  s:  string;
begin
  s := Bytes8Raw2Str(r);
  if s = '' then s := Double2Str(FromDouble(r));
  Result := PackStrR(s,GetColWidth);
end;

function DoubleRaw2StrL(r: bytes8): string;
var
  s:  string;
begin
  s := Bytes8Raw2Str(r);
  if s = '' then s := Double2Str(FromDouble(r));
  Result := PackStrL(s,GetColWidth);
end;

end.
