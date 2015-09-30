unit get_cntcantar;

interface

function InfoGetCntCanTar: string;
procedure BoxGetCntCanTar;
procedure ShowGetCntCanTar;

implementation

uses SysUtils, main, output, support, box, kernel, realz, timez, borders, pipeline, get_config, get_devices, calendar, progress;

var
  mpCntCanTar: array[0..CANALS,0..TARIFFS] of cnt;

const
  quGetCntCanTar: querys = (Action: acGetCntCanTar; cwOut: 6 + 6 + 4; cwIn: 0; wNumber: $85);

function InfoGetCntCanTar: string;
begin
  Result := 'Счетчики на момент последнего опроса по тарифам';
end;

procedure QueryGetCntCanTar;
begin
  ShowCanalsPipeline;

  with frmMain do
  begin
    InitPush(6);
    PushInt(wCanalsMin);
    PushInt(wCanalsCount);
    PushByte(updTariffsMin.Position);
    PushByte(updTariffsCount.Position);
    Query(quGetCntCanTar);

    AddInfo('');
  end;
end;

procedure BoxGetCntCanTar;
begin
  if TestCanals then
    with frmMain do
    begin
      InitCanalsPipeline((wSafeBuffSize-16) div (updTariffsCount.Position*10), updCanalsMin.Position, updCanalsCount.Position);

      AddInfo('');
      AddInfo('');
      AddInfo(InfoGetCntCanTar);
      QueryGetCntCanTar;
    end;
end;

procedure ShowGetCntCanTar;
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
       with mpCntCanTar[c,t] do begin
        tiValue := PopTimes;
        eValue := PopFloat;
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
        with mpCntCanTar[c,t] do begin
          r := r + eValue;
          s := s + PackStrL(Float2Str(eValue), GetColWidth) + ' ' + PackStrR(Times2Str(tiValue), 20);
        end;
        s := s + PackStrL(Float2Str(r), GetColWidth);
        AddInfo(s);
      end;

      RunBox;
    end
    else begin
      NextCanalsPipeline(updCanalsCount.Position);
      QueryGetCntCanTar;
    end;
  end;
end;

end.
