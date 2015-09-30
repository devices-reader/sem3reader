unit terminal;

interface
  procedure ShowOutData(wSize: word);
  procedure ShowInData(wSize: word);
  procedure ShowTimeout;

var
  mpbOut,
  mpbIn:  array[0..$4000] of byte;

  iwOut,
  iwIn:   word;

  daOut,
  daIn:   TDateTime;

implementation

uses SysUtils, Graphics, main, support, kernel;

function Time2Str: string;
var
  Hour,Min,Sec,MSec:  word;
begin
  DecodeTime(Now, Hour,Min,Sec,MSec);

  Result := Int2Str(Hour) + '.' +
            Int2Str(Min)  + '.' +
            Int2Str(Sec)  + '.' +
            Int2Str(MSec);
end;

function GetTimeDiff: longword;
var
  Hour,Min,Sec,MSec:  word;
begin
  DecodeTime(daIn-daOut, Hour,Min,Sec,MSec);
  Result := Sec*1000+MSec;
end;

procedure ShowTimeout;
begin
  with frmMain do
    stbMain.Panels[panTIMEOUT].Text := ' ' + IntToStr(GetTimeDiff) + ' ����';
end;

procedure ShowOutData(wSize: word);
var
  i:  word;
  s:  string;
begin
  with frmMain do if wSize > 0 then begin
    AddTerminal('',clGray);
    AddTerminal('',clGray);
    s := '';
    for i := 0 to wSize-1 do s := s + IntToHex(mpbOut[i],2) + ' ';

    daOut := Now;
    AddTerminal(s + '  // ��������: ' + IntToStr(wSize) + ' ����; ' + Time2Str,clGray);
  end; 
end;

procedure ShowInData(wSize: word);
var
  i:  word;
  s:  string;
begin
  with frmMain do if wSize > 0 then begin
    AddTerminal('',clGray);
    s := '';
    for i := 0 to wSize-1 do s := s + IntToHex(mpbIn[i],2) + ' ';

    daIn := Now;
    AddTerminal(s+'  // �����: ' + IntToStr(wSize) + ' ����; ' + Time2Str,clGray);
    AddTerminal('// �������: ' + IntToStr(GetTimeDiff) + ' ����',clGray);
    AddTerminal('',clGray);
  end;
end;

end.
