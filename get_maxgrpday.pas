unit get_maxgrpday;

interface

uses get_max;

type

  TGetMaxGrpDay = class sealed(TGetMax)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetMaxGrpDay: querys = (Action: acGetMaxGrpDay; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $A1);

constructor TGetMaxGrpDay.Create;
begin
  with frmMain do
    inherited Create(
    quGetMaxGrpDay,
    TDay.Create, updDaysMin.Position, updDaysCount.Position,
    GROUP_NAMES, updGroupsMin.Position, updGroupsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetMaxGrpDay.GetInfo: string;
begin
  Result := 'Максимумы мощности по группам (за сутки)';
end;

function TGetMaxGrpDay.TestRange: boolean;
begin
  Result := TestGroups;
end;

end.
