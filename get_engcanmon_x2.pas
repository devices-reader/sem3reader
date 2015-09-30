unit get_engcanmon_x2;

interface

uses get_eng_x2;

type

  TGetEngCanMonX2 = class sealed(TGetEngX2)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetEngCanMonX2: querys = (Action: acGetEngCanMonX2; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $1042);

constructor TGetEngCanMonX2.Create;
begin
  with frmMain do
    inherited Create(
    quGetEngCanMonX2,
    TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
    CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetEngCanMonX2.GetInfo: string;
begin
  Result := 'Энергия по каналам (за месяц) (двойная точность)';
end;

function TGetEngCanMonX2.TestRange: boolean;
begin
  Result := TestCanals;
end;

end.
