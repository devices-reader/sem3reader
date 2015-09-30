unit get_cntcanmon_x2;

interface

uses get_itmper;

type

  TGetCntCanMonX2 = class sealed(TGetItmPer)
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
  quGetCntCanMonX2: querys = (Action: acGetCntCanMonX2; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $1080);

var
  mpCntCanMon: array [0..CANALS-1] of string;

constructor TGetCntCanMonX2.Create;
begin
  with frmMain do
    inherited Create(
      TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
      CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position
    );
end;

function TGetCntCanMonX2.GetInfo: string;
begin
  Result := 'Счетчики на начало месяца (за месяц) (двойная точность)';
end;

function TGetCntCanMonX2.TestRange: boolean;
begin
  Result := TestCanals;
end;

function TGetCntCanMonX2.GetInSize: word;
begin
  Result := 6 + 8 * wStepCount + 10;
end;

function TGetCntCanMonX2.GetStep: word;
begin
  Result := (wSafeBuffSize - 16) div 4;
end;

procedure TGetCntCanMonX2.Request;
begin
  ShowStep;

  InitPush(6);
  PushInt(wStepMin);
  PushInt(wStepCount);
  PushInt(wPeriodMin + cwPeriod);
  PushByte(0);
  PushByte(1);
  Query(quGetCntCanMonX2);

  AddInfo('');
end;

procedure TGetCntCanMonX2.ReadData(i: word);
begin
   mpCntCanMon[i] := DoubleRaw2StrL(PopDoubleRaw);
end;

procedure TGetCntCanMonX2.ShowData;
var
  c: word;
  ti: times;
  s: string;
begin
    s := Period.GetNames.Singular.Nominative + ' -' + IntToStr(cwPeriod) + ', ';
    ti := Period.FromIndex(Period.ToIndex(tiCurr) - wPeriodMin - cwPeriod);
    s := s + Period.ToString(ti);
    AddInfo(s);

    s := PackStrR('', GetColWidth);
    s := s + PackStrL('всего', GetColWidth);
    AddInfo(s);

    for c := wItemsMin to wItemsMin + wItemsCount - 1 do
    begin
      s := PackStrR(ItemNames.Singular.Nominative + ' ' + IntToStr(c), GetColWidth);
      s := s + mpCntCanMon[c];
      AddInfo(s);
    end;
end;

end.
