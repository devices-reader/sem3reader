unit get_enggrpday_x2;

interface

uses get_eng_x2;

type

  TGetEngGrpDayX2 = class sealed(TGetEngX2)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetEngGrpDayX2: querys = (Action: acGetEngGrpDayX2; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $1041);

constructor TGetEngGrpDayX2.Create;
begin
  with frmMain do
    inherited Create(
    quGetEngGrpDayX2,
    TDay.Create, updDaysMin.Position, updDaysCount.Position,
    GROUP_NAMES, updGroupsMin.Position, updGroupsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetEngGrpDayX2.GetInfo: string;
begin
  Result := 'Энергия по группам (за сутки) (двойная точность)';
end;

function TGetEngGrpDayX2.TestRange: boolean;
begin
  Result := TestGroups;
end;

end.
