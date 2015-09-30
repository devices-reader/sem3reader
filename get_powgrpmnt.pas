unit get_powgrpmnt;

interface

function InfoGetPowGrpMnt: string;
procedure BoxGetPowGrpMnt;
procedure ShowGetPowGrpMnt;

implementation

uses SysUtils, main, output, support, box, kernel, realz, borders, progress, pipeline, get_config, get_devices;

var
  mpPowGrpMnt: array [0 .. GROUPS, 0 .. MINUTES3] of extended;

const
  quGetPowGrpMnt: querys = (Action: acGetPowGrpMnt; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $51);

function InfoGetPowGrpMnt: string;
begin
  Result := '—редн€€ трехминутна€ мощность по группам';
end;

procedure QueryGetPowGrpMnt;
begin
  ShowGroupsPipeline;

  with frmMain do
  begin
    InitPush(6);
    PushInt(wGroupsMin);
    PushInt(wGroupsCount);
    PushInt(updMinutesMin.Position);
    PushInt(updMinutesCount.Position);
    Query(quGetPowGrpMnt);
  end;
end;

procedure BoxGetPowGrpMnt;
begin
  with frmMain do if TestGroups and TestMinutes then
  begin
    InitGroupsPipeline((wSafeBuffSize-16) div (updMinutesCount.Position*4), updGroupsMin.Position, updGroupsCount.Position);

    AddInfo('');
    AddInfo('');
    AddInfo(InfoGetPowGrpMnt);
    AddInfo('');
    QueryGetPowGrpMnt;
  end;
end;

procedure ShowGetPowGrpMnt;
var
  g: word;
  s: string;
  x, y: word;
begin
  Stop;
  InitPop(6);

  with frmMain do
  begin
    for g := updGroupsMin.Position to updGroupsMin.Position + updGroupsCount.Position - 1 do
      for x := updMinutesMin.Position to updMinutesMin.Position + updMinutesCount.Position - 1 do
        mpPowGrpMnt[g, x] := PopFloat;

    ShowProgress(wGroupsMin+wGroupsCount-1, updGroupsCount.Position);

    if wGroupsMin+wGroupsCount-1 >= updGroupsCount.Position then begin

      s := PackStrR('', GetColWidth);
      for g := updGroupsMin.Position to updGroupsMin.Position + updGroupsCount.Position - 1 do
        s := s + PackStrR('группа ' + IntToStr(g), GetColWidth);
      AddInfo(s);

      y := (tiCurr.bHour * 20 + tiCurr.bMinute div 3 ) - updMinutesMin.Position;

      for x := updMinutesMin.Position to updMinutesMin.Position + updMinutesCount.Position - 1 do
      begin
        s := PackStrR(Int2Str(y div 20) + ':' + Int2Str((y mod 20) * 3) + '  -' + IntToStr(x), GetColWidth);

        for g := updGroupsMin.Position to updGroupsMin.Position + updGroupsCount.Position - 1 do
          s := s + PackStrR(Float2Str(mpPowGrpMnt[g, x]), GetColWidth);

        AddInfo(s);

        if y = 0 then y := 24 * 20 else y := y - 1;
      end;

      RunBox;
    end
    else begin
      NextGroupsPipeline(updGroupsCount.Position);
      QueryGetPowGrpMnt;
    end;
  end;
end;

end.
