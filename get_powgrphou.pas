unit get_powgrphou;

interface

function InfoGetPowGrpHou: string;
procedure BoxGetPowGrpHou;
procedure ShowGetPowGrpHou;

implementation

uses SysUtils, main, output, support, box, kernel, realz, timez, borders, pipeline, progress, get_config, get_devices, calendar, profile;

const
  quGetPowGrpHou: querys = (Action: acGetPowGrpHou; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $53);

var
  P: TProfile;

function InfoGetPowGrpHou: string;
begin
  Result := 'Средняя получасовая мощность по группам';
end;

procedure QueryGetPowGrpHou;
begin
  ShowGroupsPipeline;

  with frmMain do
  begin
    InitPush(6);
    PushInt(wGroupsMin);
    PushInt(wGroupsCount);
    PushInt(updHoursMin.Position);
    PushInt(updHoursCount.Position);
    Query(quGetPowGrpHou);
  end;
end;

procedure BoxGetPowGrpHou;
var
  wMin, wMax: word;
begin
  if TestGroups then
    with frmMain do
    begin
      wMin := updGroupsMin.Position;
      wMax := updGroupsMin.Position + updGroupsCount.Position - 1;
      P := TProfile.Create(wMin, wMax);

      InitGroupsPipeline((wSafeBuffSize-16) div (updHoursCount.Position*4), updGroupsMin.Position, updGroupsCount.Position);

      AddInfo('');
      AddInfo('');
      AddInfo(InfoGetPowGrpHou);
      AddInfo('');
      QueryGetPowGrpHou;
    end;
end;

procedure ShowGetPowGrpHou;
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
      ti := HouIndexToDate(DateToHouIndex(tiCurr) - updHoursMin.Position);
      for x := 0 to updHoursCount.Position - 1 do
      begin
        e := PopFloat;
        P.AddValue(c, e, HouIndexToDate(DateToHouIndex(ti) - x));
      end;
    end;

    ShowProgress(wGroupsMin+wGroupsCount-1, updGroupsCount.Position);

    if wGroupsMin+wGroupsCount-1 >= updGroupsCount.Position then begin
      AddInfoAll(P.GetResult('группа '));
      RunBox;
    end
    else begin
      NextGroupsPipeline(updGroupsCount.Position);
      QueryGetPowGrpHou;
    end;
  end;
end;

end.
