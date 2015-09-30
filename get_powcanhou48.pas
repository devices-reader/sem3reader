unit get_powcanhou48;

interface

function InfoGetPowCanHou48: string;
procedure BoxGetPowCanHou48;
procedure ShowGetPowCanHou48;

implementation

uses SysUtils, main, output, support, box, kernel, realz, timez, borders, pipeline, progress, get_config, get_devices, calendar, profile;

const
  quGetPowCanHou48: querys = (Action: acGetPowCanHou48; cwOut: 6 + 6 + 4; cwIn: 0; wNumber: $54);

var
  cwDays: word;
  P: TProfile;

function InfoGetPowCanHou48: string;
begin
  Result := 'Средняя получасовая мощность по каналам (за сутки)';
end;

procedure QueryGetPowCanHou48;
begin
  ShowCanalsPipeline;

  with frmMain do
  begin
    InitPush(6);
    PushInt(wCanalsMin);
    PushInt(wCanalsCount);
    PushInt(updDaysMin.Position + cwDays);
    Query(quGetPowCanHou48);
  end;
end;

procedure BoxGetPowCanHou48;
var
  wMin, wMax: word;
begin
  if TestCanals then
    with frmMain do
    begin
      cwDays := 0;

      wMin := updCanalsMin.Position;
      wMax := updCanalsMin.Position + updCanalsCount.Position - 1;
      P := TProfile.Create(wMin, wMax);

      InitCanalsPipeline((wSafeBuffSize-16) div (48*4), updCanalsMin.Position, updCanalsCount.Position);

      AddInfo('');
      AddInfo('');
      AddInfo(InfoGetPowCanHou48);
      AddInfo('');
      ShowDaysPipeline(cwDays);
      QueryGetPowCanHou48;
    end;
end;

procedure ShowGetPowCanHou48;
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
    for c := wCanalsMin to wCanalsMin + wCanalsCount - 1 do begin
      ti := DayIndexToDate(DateToDayIndex(tiCurr) - updDaysMin.Position - cwDays);
      for x := 0 to 48 - 1 do
      begin
        e := PopFloat;
        P.AddValue(c, e, HouIndexToDate(DateToHouIndex(ti) + x));
      end;
    end;

    ShowProgress(cwDays*updCanalsCount.Position + wCanalsMin+wCanalsCount-1, updDaysCount.Position*updCanalsCount.Position);

    if wCanalsMin+wCanalsCount-1 >= updCanalsCount.Position then begin
      Inc(cwDays);
      if (cwDays < updDaysCount.Position) then begin
        ShowDaysPipeline(cwDays);
        InitCanalsPipeline((wSafeBuffSize-16) div (48*4), updCanalsMin.Position, updCanalsCount.Position);
        QueryGetPowCanHou48;
      end
      else begin
        AddInfoAll(P.GetResult('канал '));
        RunBox;
      end;
    end
    else begin
      NextCanalsPipeline(updCanalsCount.Position);
      QueryGetPowCanHou48;
    end;
  end;

end;

end.
