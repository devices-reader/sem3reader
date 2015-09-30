unit get_maxgrpmon0;

interface

uses get_max;

type

  TGetMaxGrpMon0 = class sealed(TGetMax)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
    function GetInSize: word; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetMaxGrpMon0: querys = (Action: acGetMaxGrpMon0; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $A3);

constructor TGetMaxGrpMon0.Create;
begin
  with frmMain do
    inherited Create(
    quGetMaxGrpMon0,
    TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
    GROUP_NAMES, updGroupsMin.Position, updGroupsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetMaxGrpMon0.GetInfo: string;
begin
  Result := 'Максимумы мощности по группам (за месяц) *';
end;

function TGetMaxGrpMon0.TestRange: boolean;
begin
  Result := TestGroups;
end;

function TGetMaxGrpMon0.GetInSize: word;
begin
  Result := 6 + 6 * wStepCount * wTariffsCount + 10 + (8 * wStepCount);
end;

end.
