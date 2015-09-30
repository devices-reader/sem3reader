unit get_maxcanmon0;

interface

uses get_max;

type
  TGetMaxCanMon0 = class sealed(TGetMax)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
    function GetInSize: word; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders, get_config;

const
  quGetMaxCanMon0: querys = (Action: acGetMaxCanMon0; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $A2);

constructor TGetMaxCanMon0.Create;
begin
  with frmMain do
    inherited Create(
    quGetMaxCanMon0,
    TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
    CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetMaxCanMon0.GetInfo: string;
begin
  Result := 'Максимумы мощности по каналам (за месяц) *';
end;

function TGetMaxCanMon0.TestRange: boolean;
begin
  Result := TestCanals;
end;

function TGetMaxCanMon0.GetInSize: word;
begin
  Result := 6 + 6 * wStepCount * wTariffsCount + 10 + (8 * wStepCount);
end;

end.
