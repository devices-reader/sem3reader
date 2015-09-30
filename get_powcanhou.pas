unit get_powcanhou;

interface

function InfoGetPowCanHou: string;
procedure BoxGetPowCanHou;
procedure ShowGetPowCanHou;

implementation

uses SysUtils, main, output, support, box, kernel, realz, timez, borders, pipeline, progress, get_config, get_devices, calendar, profile;

const
  quGetPowCanHou: querys = (Action: acGetPowCanHou; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $52);

var
  P: TProfile;

function InfoGetPowCanHou: string;
begin
  Result := 'Средняя получасовая мощность по каналам';
end;

procedure QueryGetPowCanHou;
begin
  ShowCanalsPipeline;

  with frmMain do begin
    InitPush(6);
    PushInt(wCanalsMin);
    PushInt(wCanalsCount);
    PushInt(updHoursMin.Position);
    PushInt(updHoursCount.Position);
    Query(quGetPowCanHou);
  end;
end;

procedure BoxGetPowCanHou;
var
  wMin, wMax: word;
begin
  if TestCanals then
    with frmMain do
    begin
      wMin := updCanalsMin.Position;
      wMax := updCanalsMin.Position + updCanalsCount.Position - 1;
      P := TProfile.Create(wMin, wMax);

      InitCanalsPipeline((wSafeBuffSize-16) div (updHoursCount.Position*4), updCanalsMin.Position, updCanalsCount.Position);

      AddInfo('');
      AddInfo('');
      AddInfo(InfoGetPowCanHou);
      AddInfo('');
      QueryGetPowCanHou;
    end;
end;

procedure ShowGetPowCanHou;
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
      ti := HouIndexToDate(DateToHouIndex(tiCurr) - updHoursMin.Position);
      for x := 0 to updHoursCount.Position - 1 do
      begin
        e := PopFloat;
        P.AddValue(c, e, HouIndexToDate(DateToHouIndex(ti) - x));
      end;
    end;

    ShowProgress(wCanalsMin+wCanalsCount-1, updCanalsCount.Position);

    if wCanalsMin+wCanalsCount-1 >= updCanalsCount.Position then begin
      AddInfoAll(P.GetResult('канал '));
      RunBox;
    end
    else begin
      NextCanalsPipeline(updCanalsCount.Position);
      QueryGetPowCanHou;
    end;
  end;
end;

end.
