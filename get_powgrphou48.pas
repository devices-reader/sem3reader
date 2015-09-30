unit get_powgrphou48;

interface

function InfoGetPowGrpHou48: string;
procedure BoxGetPowGrpHou48;
procedure ShowGetPowGrpHou48;

implementation

uses SysUtils, main, output, support, box, kernel, realz, timez, borders, pipeline, progress, get_config, get_devices, calendar, profile;

const
  quGetPowGrpHou48: querys = (Action: acGetPowGrpHou48; cwOut: 6 + 6 + 4; cwIn: 0; wNumber: $55);

var
  cwDays: word;
  P: TProfile;

function InfoGetPowGrpHou48: string;
begin
  Result := 'Средняя получасовая мощность по группам (за сутки)';
end;

procedure QueryGetPowGrpHou48;
begin
  ShowGroupsPipeline;

  with frmMain do
  begin
    InitPush(6);
    PushInt(wGroupsMin);
    PushInt(wGroupsCount);
    PushInt(updDaysMin.Position + cwDays);
    Query(quGetPowGrpHou48);
  end;
end;

procedure BoxGetPowGrpHou48;
var
  wMin, wMax: word;
begin
  if TestGroups then
    with frmMain do
    begin
      cwDays := 0;

      wMin := updGroupsMin.Position;
      wMax := updGroupsMin.Position + updGroupsCount.Position - 1;
      P := TProfile.Create(wMin, wMax);

      InitGroupsPipeline((wSafeBuffSize-16) div (48*4), updGroupsMin.Position, updGroupsCount.Position);

      AddInfo('');
      AddInfo('');
      AddInfo(InfoGetPowGrpHou48);
      AddInfo('');
      ShowDaysPipeline(cwDays);
      QueryGetPowGrpHou48;
    end;
end;

procedure ShowGetPowGrpHou48;
var
  c: word;
  x: word;
  e: extended;
  ti: times;
begin
  Stop;
  InitPop(6);

  with frmMain do
  begin
    for c := wGroupsMin to wGroupsMin + wGroupsCount - 1 do begin
      ti := DayIndexToDate(DateToDayIndex(tiCurr) - updDaysMin.Position - cwDays);
      for x := 0 to 48 - 1 do
      begin
        e := PopFloat;
        P.AddValue(c, e, HouIndexToDate(DateToHouIndex(ti) + x));
      end;
    end;

    ShowProgress(cwDays*updGroupsCount.Position + wGroupsMin+wGroupsCount-1, updDaysCount.Position*updGroupsCount.Position);

    if wGroupsMin+wGroupsCount-1 >= updGroupsCount.Position then begin
      Inc(cwDays);
      if (cwDays < updDaysCount.Position) then begin
        ShowDaysPipeline(cwDays);
        InitGroupsPipeline((wSafeBuffSize-16) div (48*4), updGroupsMin.Position, updGroupsCount.Position);
        QueryGetPowGrpHou48;
      end
      else begin
        AddInfoAll(P.GetResult('группа '));
        RunBox;
      end;
    end
    else begin
      NextGroupsPipeline(updGroupsCount.Position);
      QueryGetPowGrpHou48;
    end;
  end;

end;

end.
