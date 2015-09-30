unit get_cntcanmontar;

interface

uses get_itmpertar;

type

  TGetCntCanMonTar = class sealed(TGetItmPerTar)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
    function GetInSize: word; override;
    function GetStep: word; override;
    procedure Request; override;
    procedure ReadData(i: word); override;
    procedure ShowData; override;
  end;

implementation

uses SysUtils, kernel, box, main, period, borders, output, support, realz, timez, get_config;

const
  quGetCntCanMonTar: querys = (Action: acGetCntCanMonTar; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $80);

var
  mpCntCanMonTar: array [0 .. CANALS - 1, 0 .. TARIFFS - 1] of bytes4;

constructor TGetCntCanMonTar.Create;
begin
  with frmMain do
    inherited Create(
      TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
      CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position,
      updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetCntCanMonTar.GetInfo: string;
begin
  Result := 'Счетчики на начало месяца по тарифам (за месяц)';
end;

function TGetCntCanMonTar.TestRange: boolean;
begin
  Result := TestCanals;
end;

function TGetCntCanMonTar.GetInSize: word;
begin
  Result := 6 + 4 * wStepCount * wTariffsCount + 10
end;

function TGetCntCanMonTar.GetStep: word;
begin
  Result := (wSafeBuffSize - 16) div (wTariffsCount * 4);
end;

procedure TGetCntCanMonTar.Request;
begin
  ShowStep;

  InitPush(6);
  PushInt(wStepMin);
  PushInt(wStepCount);
  PushInt(wPeriodMin + cwPeriod);
  PushByte(wTariffsMin);
  PushByte(wTariffsCount);
  Query(quGetCntCanMonTar);

  AddInfo('');
end;

procedure TGetCntCanMonTar.ReadData(i: word);
var
  t: byte;
begin
  for t := wTariffsMin to wTariffsCount do
    mpCntCanMonTar[i, t] := PopFloatRaw;
end;

procedure TGetCntCanMonTar.ShowData;
var
  i: word;
  t: byte;
  x: bytes4;
  r: extended;
  ti: times;
  s: string;
begin
  s := period.GetNames.Singular.Nominative + ' -' + IntToStr(cwPeriod) + ', ';
  ti := period.FromIndex(period.ToIndex(tiCurr) - wPeriodMin - cwPeriod);
  s := s + period.ToString(ti);
  AddInfo(s);

  s := PackStrR('', GetColWidth);
  for t := wTariffsMin to wTariffsCount do
    s := s + PackStrL('тариф ' + IntToStr(t), GetColWidth);
  s := s + PackStrL('всего', GetColWidth);
  AddInfo(s);

  for i := wItemsMin to wItemsMin + wItemsCount - 1 do
  begin
    s := PackStrR(ItemNames.Singular.Nominative + ' ' + IntToStr(i), GetColWidth);
    r := 0;
    for t := wTariffsMin to wTariffsCount do
    begin
      x := mpCntCanMonTar[i, t];
      r := r + FromFloat(x);
      s := s + FloatRaw2StrL(x);
    end;
    s := s + Float2StrL(r);
    AddInfo(s);
  end;
end;

end.
