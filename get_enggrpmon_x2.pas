unit get_enggrpmon_x2;

interface

uses get_eng_x2;

type

  TGetEngGrpMonX2 = class sealed(TGetEngX2)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetEngGrpMonX2: querys = (Action: acGetEngGrpMonX2; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $1043);

constructor TGetEngGrpMonX2.Create;
begin
  with frmMain do
    inherited Create(
    quGetEngGrpMonX2,
    TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
    GROUP_NAMES, updGroupsMin.Position, updGroupsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetEngGrpMonX2.GetInfo: string;
begin
  Result := 'Энергия по группам (за месяц) (двойная точность)';
end;

function TGetEngGrpMonX2.TestRange: boolean;
begin
  Result := TestGroups;
end;

end.
