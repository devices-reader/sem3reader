unit get_cntcantar_x2;

interface

function InfoGetCntCanTarX2: string;
procedure BoxGetCntCanTarX2;
procedure ShowGetCntCanTarX2;

implementation

uses SysUtils, main, output, support, box, kernel, realz, timez, borders, pipeline, get_config, get_devices, calendar, progress;

var
  mpCntCanTarX2: array[0..CANALS,0..TARIFFS] of cnt;

const
  quGetCntCanTarX2: querys = (Action: acGetCntCanTarX2; cwOut: 6 + 6 + 4; cwIn: 0; wNumber: $1085);

function InfoGetCntCanTarX2: string;
begin
  Result := 'Счетчики на момент последнего опроса по тарифам (двойная точность)';
end;

procedure QueryGetCntCanTarX2;
begin
  ShowCanalsPipeline;

  with frmMain do
  begin
    InitPush(6);
    PushInt(wCanalsMin);
    PushInt(wCanalsCount);
    PushByte(updTariffsMin.Position);
    PushByte(updTariffsCount.Position);
    Query(quGetCntCanTarX2);

    AddInfo('');
  end;
end;

procedure BoxGetCntCanTarX2;
begin
  if TestCanals then
    with frmMain do
    begin
      InitCanalsPipeline((wSafeBuffSize-16) div (updTariffsCount.Position*10), updCanalsMin.Position, updCanalsCount.Position);

      AddInfo('');
      AddInfo('');
      AddInfo(InfoGetCntCanTarX2);
      QueryGetCntCanTarX2;
    end;
end;

procedure ShowGetCntCanTarX2;
var
  c: word;
  t: byte;
  r: extended;
  s: string;
begin
  Stop;
  InitPop(6);

  with frmMain do
  begin
    for c := wCanalsMin to wCanalsMin+wCanalsCount-1 do begin
      for t := updTariffsMin.Position to updTariffsCount.Position do begin
       with mpCntCanTarX2[c,t] do begin
        tiValue := PopTimes;
        eValue := PopDouble;
       end;
      end;
    end;

    ShowProgress(wCanalsMin+wCanalsCount-1, updCanalsCount.Position);

    if wCanalsMin+wCanalsCount-1 >= updCanalsCount.Position then begin
      s := PackStrR('', GetColWidth);
      for t := updTariffsMin.Position to updTariffsCount.Position do
        s := s + PackStrL('тариф ' + IntToStr(t), GetColWidth) + ' ' + PackStrR('', 20);
      s := s + PackStrL('всего', GetColWidth);
      AddInfo(s);

      for c := updCanalsMin.Position to updCanalsMin.Position + updCanalsCount.Position - 1 do
      begin
        s := PackStrR('канал ' + IntToStr(c), GetColWidth);
        r := 0;
        for t := updTariffsMin.Position to updTariffsCount.Position do
        with mpCntCanTarX2[c,t] do begin
          r := r + eValue;
          s := s + PackStrL(Double2Str(eValue), GetColWidth) + ' ' + PackStrR(Times2Str(tiValue), 20);
        end;
        s := s + PackStrL(Double2Str(r), GetColWidth);
        AddInfo(s);
      end;

      RunBox;
    end
    else begin
      NextCanalsPipeline(updCanalsCount.Position);
      QueryGetCntCanTarX2;
    end;
  end;
end;

end.
