unit get_cntcanmon;

interface

uses get_itmper;

type

  TGetCntCanMon = class sealed(TGetItmPer)
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
  quGetCntCanMon: querys = (Action: acGetCntCanMon; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $80);

var
  mpCntCanMon: array [0..CANALS-1] of string;

constructor TGetCntCanMon.Create;
begin
  with frmMain do
    inherited Create(
      TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
      CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position
    );
end;

function TGetCntCanMon.GetInfo: string;
begin
  Result := 'Счетчики на начало месяца (за месяц)';
end;

function TGetCntCanMon.TestRange: boolean;
begin
  Result := TestCanals;
end;

function TGetCntCanMon.GetInSize: word;
begin
  Result := 6 + 4 * wStepCount + 10;
end;

function TGetCntCanMon.GetStep: word;
begin
  Result := (wSafeBuffSize - 16) div 4;
end;

procedure TGetCntCanMon.Request;
begin
  ShowStep;

  InitPush(6);
  PushInt(wStepMin);
  PushInt(wStepCount);
  PushInt(wPeriodMin + cwPeriod);
  PushByte(0);
  PushByte(1);
  Query(quGetCntCanMon);

  AddInfo('');
end;

procedure TGetCntCanMon.ReadData(i: word);
begin
   mpCntCanMon[i] := FloatRaw2StrL(PopFloatRaw);
end;

procedure TGetCntCanMon.ShowData;
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
