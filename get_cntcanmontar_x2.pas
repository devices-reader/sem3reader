unit get_cntcanmontar_x2;

interface

uses get_itmpertar;

type

  TGetCntCanMonTarX2 = class sealed(TGetItmPerTar)
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
  quGetCntCanMonTarX2: querys = (Action: acGetCntCanMonTarX2; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $1080);

var
  mpCntCanMonTar: array [0 .. CANALS - 1, 0 .. TARIFFS - 1] of bytes8;

constructor TGetCntCanMonTarX2.Create;
begin
  with frmMain do
    inherited Create(
      TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
      CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position,
      updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetCntCanMonTarX2.GetInfo: string;
begin
  Result := 'Счетчики на начало месяца по тарифам (за месяц) (двойная точность)';
end;

function TGetCntCanMonTarX2.TestRange: boolean;
begin
  Result := TestCanals;
end;

function TGetCntCanMonTarX2.GetInSize: word;
begin
  Result := 6 + 8 * wStepCount * wTariffsCount + 10
end;

function TGetCntCanMonTarX2.GetStep: word;
begin
  Result := (wSafeBuffSize - 16) div (wTariffsCount * 4);
end;

procedure TGetCntCanMonTarX2.Request;
begin
  ShowStep;

  InitPush(6);
  PushInt(wStepMin);
  PushInt(wStepCount);
  PushInt(wPeriodMin + cwPeriod);
  PushByte(wTariffsMin);
  PushByte(wTariffsCount);
  Query(quGetCntCanMonTarX2);

  AddInfo('');
end;

procedure TGetCntCanMonTarX2.ReadData(i: word);
var
  t: byte;
begin
  for t := wTariffsMin to wTariffsCount do
    mpCntCanMonTar[i, t] := PopDoubleRaw;
end;

procedure TGetCntCanMonTarX2.ShowData;
var
  i: word;
  t: byte;
  x: bytes8;
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
      r := r + FromDouble(x);
      s := s + DoubleRaw2StrL(x);
    end;
    s := s + Double2StrL(r);
    AddInfo(s);
  end;
end;

end.
