unit get_defcanday;

interface

function InfoGetDefCanDay: string;
procedure BoxGetDefCanDay;
procedure ShowGetDefCanDay;

implementation

uses SysUtils, main, output, support, box, kernel, timez, borders, calendar, get_config;

const
  quGetDefCanDay: querys = (Action: acGetDefCanDay; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $B0);

var
  mpDefCan: array [0 .. 64 - 1] of byte;

function InfoGetDefCanDay: string;
begin
  Result := 'Достоверность данных по каналам за сутки';
end;

procedure QueryGetDefCanDay;
begin
  with frmMain do
  begin
    InitPush(6);
    PushInt(updCanalsMin.Position);
    PushInt(updCanalsCount.Position);
    PushInt(updDaysMin.Position);
    PushInt(updDaysCount.Position);
    Query(quGetDefCanDay);
  end;
end;

procedure BoxGetDefCanDay;
begin
  if TestCanals and TestDays then
  begin
    AddInfo('');
    AddInfo('');
    AddInfo(InfoGetDefCanDay);
    AddInfo('');
    QueryGetDefCanDay;
  end;
end;

procedure ShowGetDefCanDay;
var
  c: word;
  s: string;
  d: byte;
  i: word;
  j: byte;
  b: byte;
  wCanalMin, wCanalMax: word;
begin
  Stop;
  InitPop(6);

  with frmMain do
  begin
    wCanalMin := updCanalsMin.Position;
    wCanalMax := updCanalsMin.Position + updCanalsCount.Position - 1;

    s := PackStrR('', GetColWidth);
    for c := wCanalMin to wCanalMax do
      s := s + PackStrR(IntToStr(c), 4);
    AddInfo(s);

    for d := updDaysMin.Position to updDaysMin.Position + updDaysCount.Position - 1 do
    begin
      s := PackStrR('-' + IntToStr(d), 4);
      s := s + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr) - d));
      s := PackStrR(s, GetColWidth);

      for i := 1 to 64 do
        mpDefCan[i - 1] := 0;

      j := (((updCanalsCount.Position-1) div 16) + 1) * 2;
      for i := 1 to j do
        mpDefCan[i - 1] := PopByte;

      for c := 0 to (wCanalMax - wCanalMin) do
      begin
        b := mpDefCan[j - 1 - (c div 8)];
        if (b and ($01 shl (c mod 8))) <> 0 then
          s := s + PackStrR('нет', 4)
        else
          s := s + PackStrR('да', 4);
      end;
      AddInfo(s);
    end;
  end;

  RunBox;
end;

end.
