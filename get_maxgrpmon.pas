unit get_maxgrpmon;

interface

uses get_max;

type

  TGetMaxGrpMon = class sealed(TGetMax)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetMaxGrpMon: querys = (Action: acGetMaxGrpMon; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $A3);

constructor TGetMaxGrpMon.Create;
begin
  with frmMain do
    inherited Create(
    quGetMaxGrpMon,
    TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
    GROUP_NAMES, updGroupsMin.Position, updGroupsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetMaxGrpMon.GetInfo: string;
begin
  Result := 'Максимумы мощности по группам (за месяц)';
end;

function TGetMaxGrpMon.TestRange: boolean;
begin
  Result := TestGroups;
end;

end.
