unit get_defgrpday;

interface

function InfoGetDefGrpDay: string;
procedure BoxGetDefGrpDay;
procedure ShowGetDefGrpDay;

implementation

uses SysUtils, main, output, support, box, kernel, timez, borders, calendar, get_config;

const
  quGetDefGrpDay: querys = (Action: acGetDefGrpDay; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $B1);

var
  mpDefGrp: array [0 .. 64 - 1] of byte;

function InfoGetDefGrpDay: string;
begin
  Result := 'Достоверность данных по группам за сутки';
end;

procedure QueryGetDefGrpDay;
begin
  with frmMain do
  begin
    InitPush(6);
    PushInt(updGroupsMin.Position);
    PushInt(updGroupsCount.Position);
    PushInt(updDaysMin.Position);
    PushInt(updDaysCount.Position);
    Query(quGetDefGrpDay);
  end;
end;

procedure BoxGetDefGrpDay;
begin
  if TestGroups and TestDays then
  begin
    AddInfo('');
    AddInfo('');
    AddInfo(InfoGetDefGrpDay);
    AddInfo('');
    QueryGetDefGrpDay;
  end;
end;

procedure ShowGetDefGrpDay;
var
  c: word;
  s: string;
  d: byte;
  i: word;
  j: byte;
  b: byte;
  wGroupMin, wGroupMax: word;
begin
  Stop;
  InitPop(6);

  with frmMain do
  begin
    wGroupMin := updGroupsMin.Position;
    wGroupMax := updGroupsMin.Position + updGroupsCount.Position - 1;

    s := PackStrR('', GetColWidth);
    for c := wGroupMin to wGroupMax do
      s := s + PackStrR(IntToStr(c), 4);
    AddInfo(s);

    for d := updDaysMin.Position to updDaysMin.Position + updDaysCount.Position - 1 do
    begin
      s := PackStrR('-' + IntToStr(d), 4);
      s := s + Times2StrDay(DayIndexToDate(DateToDayIndex(tiCurr) - d));
      s := PackStrR(s, GetColWidth);

      for i := 1 to 64 do
        mpDefGrp[i - 1] := 0;

      j := (((updGroupsCount.Position-1) div 16) + 1) * 2;
      for i := 1 to j do
        mpDefGrp[i - 1] := PopByte;

      for c := 0 to (wGroupMax - wGroupMin) do
      begin
        b := mpDefGrp[j - 1 - (c div 8)];
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
