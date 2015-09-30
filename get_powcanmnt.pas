unit get_powcanmnt;

interface

function InfoGetPowCanMnt: string;
procedure BoxGetPowCanMnt;
procedure ShowGetPowCanMnt;

implementation

uses SysUtils, main, output, support, box, kernel, realz, borders, progress, pipeline, get_config, get_devices;

var
  mpPowCanMnt: array [0 .. CANALS, 0 .. MINUTES3] of extended;

const
  quGetPowCanMnt: querys = (Action: acGetPowCanMnt; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $50);

function InfoGetPowCanMnt: string;
begin
  Result := '—редн€€ трехминутна€ мощность по каналам';
end;

procedure QueryGetPowCanMnt;
begin
  ShowCanalsPipeline;

  with frmMain do begin
    InitPush(6);
    PushInt(wCanalsMin);
    PushInt(wCanalsCount);
    PushInt(updMinutesMin.Position);
    PushInt(updMinutesCount.Position);
    Query(quGetPowCanMnt);
  end;
end;

procedure BoxGetPowCanMnt;
begin
  with frmMain do if TestCanals and TestMinutes then
  begin
    InitCanalsPipeline((wSafeBuffSize-16) div (updMinutesCount.Position*4), updCanalsMin.Position, updCanalsCount.Position);

    AddInfo('');
    AddInfo('');
    AddInfo(InfoGetPowCanMnt);
    AddInfo('');
    QueryGetPowCanMnt;
  end;
end;

procedure ShowGetPowCanMnt;
var
  c: word;
  s: string;
  x, y: word;
begin
  Stop;
  InitPop(6);

  with frmMain do
  begin
    for c := wCanalsMin to wCanalsMin + wCanalsCount - 1 do
      for x := updMinutesMin.Position to updMinutesMin.Position + updMinutesCount.Position - 1 do
        mpPowCanMnt[c, x] := PopFloat;

    ShowProgress(wCanalsMin+wCanalsCount-1, updCanalsCount.Position);

    if wCanalsMin+wCanalsCount-1 >= updCanalsCount.Position then begin
      s := PackStrR('', GetColWidth);
      for c := updCanalsMin.Position to updCanalsMin.Position + updCanalsCount.Position - 1 do
        s := s + PackStrR('канал ' + IntToStr(c), GetColWidth);
      AddInfo(s);

      y := (tiCurr.bHour * 20 + tiCurr.bMinute div 3) - updMinutesMin.Position;

      for x := updMinutesMin.Position to updMinutesMin.Position + updMinutesCount.Position - 1 do
      begin
        s := PackStrR(Int2Str(y div 20) + ':' + Int2Str((y mod 20) * 3) + '  -' + IntToStr(x), GetColWidth);

        for c := updCanalsMin.Position to updCanalsMin.Position + updCanalsCount.Position - 1 do
          s := s + PackStrR(Float2Str(mpPowCanMnt[c, x]), GetColWidth);

        AddInfo(s);

        if y = 0 then y := 24 * 20 else y := y - 1;
      end;

      RunBox;
    end
    else begin
      NextCanalsPipeline(updCanalsCount.Position);
      QueryGetPowCanMnt;
    end;
  end;
end;

end.
