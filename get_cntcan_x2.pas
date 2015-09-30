unit get_cntcan_x2;

interface

function InfoGetCntCanX2: string;
procedure BoxGetCntCanX2;
procedure ShowGetCntCanX2;

implementation

uses SysUtils, main, output, support, box, kernel, realz, timez, borders, pipeline, get_config, get_devices, calendar, progress;

var
  mpCntCan: array[0..CANALS] of cnt;

const
  quGetCntCanX2: querys = (Action: acGetCntCanX2; cwOut: 6 + 6 + 4; cwIn: 0; wNumber: $1085);

function InfoGetCntCanX2: string;
begin
  Result := 'Счетчики на момент последнего опроса (двойная точность)';
end;

procedure QueryGetCntCanX2;
begin
  ShowCanalsPipeline;

  with frmMain do
  begin
    InitPush(6);
    PushInt(wCanalsMin);
    PushInt(wCanalsCount);
    PushByte(0);
    PushByte(1);
    Query(quGetCntCanX2);

    AddInfo('');
  end;
end;

procedure BoxGetCntCanX2;
begin
  if TestCanals then
    with frmMain do
    begin
      InitCanalsPipeline((wSafeBuffSize-16) div 10, updCanalsMin.Position, updCanalsCount.Position);

      AddInfo('');
      AddInfo('');
      AddInfo(InfoGetCntCanX2);
      QueryGetCntCanX2;
    end;
end;

procedure ShowGetCntCanX2;
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
      eValue := PopDouble;
    end;

    ShowProgress(wCanalsMin+wCanalsCount-1, updCanalsCount.Position);

    if wCanalsMin+wCanalsCount-1 >= updCanalsCount.Position then begin
      s := PackStrR('', GetColWidth);
      s := s + PackStrL('всего', GetColWidth);
      AddInfo(s);

      for c := updCanalsMin.Position to updCanalsMin.Position + updCanalsCount.Position - 1 do
      with mpCntCan[c] do begin
        s := PackStrR('канал ' + IntToStr(c), GetColWidth);
        s := s + PackStrL(Double2Str(eValue), GetColWidth) + ' ' + PackStrR(Times2Str(tiValue), GetColWidth);
        AddInfo(s);
      end;

      RunBox;
    end
    else begin
      NextCanalsPipeline(updCanalsCount.Position);
      QueryGetCntCanX2;
    end;
  end;
end;

end.
