unit timez;

interface

type
  times = record
    bSecond:    byte;
    bMinute:    byte;
    bHour:      byte;
    bDay:       byte;
    bMonth:     byte;
    bYear:      byte;
  end;

function ToTimes(daT: TDateTime): times;
function DeltaTimes2Str(tiT: times; tiS: times): string;
function PopTimes: times;
function Times2Str(tiT: times): string;
function Times2StrHour(tiT: times): string;
function Times2StrDay(tiT: times): string;
function Times2StrMon(tiT: times): string;
function PopTimes2Str: string;
function Str2Times(s: string): times;
procedure AddInfoTime(ti: times);

implementation

uses SysUtils, output, support;

function ToTimes(daT: TDateTime): times;
var
  Year,Month,Day,Hour,Min,Sec,MSec: word;
begin
  try
    with Result do begin
      bSecond := 0;
      bMinute := 0;
      bHour   := 0;
      bDay    := 0;
      bMonth  := 0;
      bYear   := 0;
    end;
  
    DecodeTime(daT, Hour,Min,Sec,MSec);
    DecodeDate(daT, Year,Month,Day);

    with Result do begin
      bSecond := Sec;
      bMinute := Min;
      bHour   := Hour;
      bDay    := Day;
      bMonth  := Month;
      bYear   := Year-2000;
    end;
  except
  end;
end;

function DaysInWords(dwDays: longword): string;
begin
  if (dwDays mod 100 = 0) then
    Result := '����'
  else case (dwDays mod 20) of
    1:    Result := '����';
    2..4: Result := '���';
    else  Result := '����';
  end;
  Result := IntToStr(dwDays) + ' ' + Result + ' ';
end;

function DeltaTimes2Str(tiT: times; tiS: times): string;
var
  daA,daB:  TDateTime;
  Hour,Min,Sec,MSec:  word;
begin
  Result := '������';  
  try
    Result := '';

    daA := EncodeDate(2000+tiT.bYear,tiT.bMonth,tiT.bDay) + 
           EncodeTime(tiT.bHour,tiT.bMinute,tiT.bSecond,0);
           
    daB := EncodeDate(2000+tiS.bYear,tiS.bMonth,tiS.bDay) + 
           EncodeTime(tiS.bHour,tiS.bMinute,tiS.bSecond,0);

    if daA > daB then begin
      daA := daA - daB;
      Result := Result + ' + ';
    end
    else begin
      daA := daB - daA;
      Result := Result + ' - ';
    end;

    DecodeTime(daA, Hour,Min,Sec,MSec);

    if (daA > 1)  then Result := Result + DaysInWords(Trunc(daA));
    if (Hour > 0) then Result := Result + IntToStr(Hour) + ' ����� ';
    if (Min > 0)  then Result := Result + IntToStr(Min)  + ' ����� ';

    Result := Result + IntToStr(Sec) + ' ������(�) ';
  except
  end;
end;

function PopTimes: times;
begin
  with Result do begin
    bSecond := PopByte;
    bMinute := PopByte;
    bHour   := PopByte;
    bDay    := PopByte;
    bMonth  := PopByte;
    bYear   := PopByte;
  end;
end;

function Times2Str(tiT: times): string;
begin
  with tiT do
    Result :=       Int2Str(bHour)   +
              ':' + Int2Str(bMinute) +
              ':' + Int2Str(bSecond) +
              ' ' + Int2Str(bDay)    +
              '.' + Int2Str(bMonth)  +
              '.' + Int2Str(bYear);
end;

function Times2StrHour(tiT: times): string;
begin
  with tiT do
    Result :=       Int2Str(bHour)   +
              ':' + Int2Str(bMinute) +
              ':' + Int2Str(bSecond);
end;

function Times2StrDay(tiT: times): string;
begin
  with tiT do
    Result :=       Int2Str(bDay)    +
              '.' + Int2Str(bMonth)  +
              '.' + Int2Str(bYear);
end;

function Times2StrMon(tiT: times): string;
begin
  with tiT do
    Result :=       Int2Str(bMonth)  +
              '.' + Int2Str(bYear);
end;

function PopTimes2Str: string;
begin
  Result := Times2Str(PopTimes);
end;

function Str2Times(s: string): times;
begin
  try
    with Result do begin
      bSecond := StrToInt(Copy(s,  7, 2));
      bMinute := StrToInt(Copy(s,  4, 2));
      bHour   := StrToInt(Copy(s,  1, 2));
      bDay    := StrToInt(Copy(s, 10, 2));
      bMonth  := StrToInt(Copy(s, 13, 2));
      bYear   := StrToInt(Copy(s, 16, 2));
    end;
  except
    ErrBox('�����/���� ������ ����������� !');
    Abort;
  end;
end;

procedure AddInfoTime(ti: times);
const
  COLUMN_WIDTH = 28;
begin
  AddInfo(PackStrR('����� ���������', COLUMN_WIDTH) + Times2Str(ti));
  AddInfo(PackStrR('����� ����������', COLUMN_WIDTH) + Times2Str(ToTimes(Now)));
  AddInfo(PackStrR('�������', COLUMN_WIDTH) + DeltaTimes2Str(ti, ToTimes(Now)));
end;

end.
