unit get_maxcanmon;

interface

uses get_max;

type
  TGetMaxCanMon = class sealed(TGetMax)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetMaxCanMon: querys = (Action: acGetMaxCanMon; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $A2);

constructor TGetMaxCanMon.Create;
begin
  with frmMain do
    inherited Create(
    quGetMaxCanMon,
    TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
    CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetMaxCanMon.GetInfo: string;
begin
  Result := 'Максимумы мощности по каналам (за месяц)';
end;

function TGetMaxCanMon.TestRange: boolean;
begin
  Result := TestCanals;
end;

end.
