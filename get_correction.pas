unit get_correction;

interface

function InfoGetCorrection: string;
procedure BoxGetCorrection;
procedure ShowGetCorrection;

implementation

uses SysUtils, support, output, timez, box, kernel, progress, realz, calendar;

const
  quGetCorrection: querys = (Action: acGetCorrection; cwOut: 6 + 2 + 4; cwIn: 6 + 2 * 12 + 10; wNumber: $03);

function InfoGetCorrection: string;
begin
  Result := 'Величина коррекции времени по месяцам';
end;

procedure QueryGetCorrection;
begin
  InitPush(6);
  PushByte(0);
  PushByte(12);
  Query(quGetCorrection);
end;

procedure BoxGetCorrection;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetCorrection);
  AddInfo('');
  QueryGetCorrection;
end;

procedure ShowGetCorrection;
var
  m: byte;
  s: string;
begin
  Stop;
  InitPop(6);

  s := '';
  for m := 0 to 12 - 1 do s := s + PackStrR(Times2StrMon(MonIndexToDate(DateToMonIndex(tiCurr) - m)), GetColWidth);
  AddInfo(s);
  s := '';
  for m := 0 to 12 - 1 do s := s + PackStrR('месяц -' + IntToStr(m), GetColWidth);
  AddInfo(s);
  s := '';
  for m := 0 to 12 - 1 do begin
    s := s + PackStrR(IntToStr(PopInt()), GetColWidth);
  end;

  AddInfo(s);

  RunBox;
end;

end.
