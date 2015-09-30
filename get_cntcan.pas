unit get_cntcan;

interface

function InfoGetCntCan: string;
procedure BoxGetCntCan;
procedure ShowGetCntCan;

implementation

uses SysUtils, main, output, support, box, kernel, realz, timez, borders, pipeline, get_config, get_devices, calendar, progress;

var
  mpCntCan: array[0..CANALS] of cnt;

const
  quGetCntCan: querys = (Action: acGetCntCan; cwOut: 6 + 6 + 4; cwIn: 0; wNumber: $85);

function InfoGetCntCan: string;
begin
  Result := 'Счетчики на момент последнего опроса';
end;

procedure QueryGetCntCan;
begin
  ShowCanalsPipeline;

  with frmMain do
  begin
    InitPush(6);
    PushInt(wCanalsMin);
    PushInt(wCanalsCount);
    PushByte(0);
    PushByte(1);
    Query(quGetCntCan);

    AddInfo('');
  end;
end;

procedure BoxGetCntCan;
begin
  if TestCanals then
    with frmMain do
    begin
      InitCanalsPipeline((wSafeBuffSize-16) div 10, updCanalsMin.Position, updCanalsCount.Position);

      AddInfo('');
      AddInfo('');
      AddInfo(InfoGetCntCan);
      QueryGetCntCan;
    end;
end;

procedure ShowGetCntCan;
var
  c: word;
  s: string;
begin
  Stop;
  InitPop(6);

  with frmMain do
  begin
    for c := wCanalsMin to wCanalsMin+wCanalsCount-1 do
    with mpCntCan[c] do
    begin
      tiValue := PopTimes;
      eValue := PopFloat;
    end;

    ShowProgress(wCanalsMin+wCanalsCount-1, updCanalsCount.Position);

    if wCanalsMin+wCanalsCount-1 >= updCanalsCount.Position then begin
      s := PackStrR('', GetColWidth);
      s := s + PackStrL('всего', GetColWidth);
      AddInfo(s);

      for c := updCanalsMin.Position to updCanalsMin.Position + updCanalsCount.Position - 1 do
      with mpCntCan[c] do begin
        s := PackStrR('канал ' + IntToStr(c), GetColWidth);
        s := s + PackStrL(Float2Str(eValue), GetColWidth) + ' ' + PackStrR(Times2Str(tiValue), GetColWidth);
        AddInfo(s);
      end;

      RunBox;
    end
    else begin
      NextCanalsPipeline(updCanalsCount.Position);
      QueryGetCntCan;
    end;
  end;
end;

end.
