unit get_enggrpday;

interface

uses get_eng;

type

  TGetEngGrpDay = class sealed(TGetEng)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetEngGrpDay: querys = (Action: acGetEngGrpDay; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $41);

constructor TGetEngGrpDay.Create;
begin
  with frmMain do
    inherited Create(
    quGetEngGrpDay,
    TDay.Create, updDaysMin.Position, updDaysCount.Position,
    GROUP_NAMES, updGroupsMin.Position, updGroupsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetEngGrpDay.GetInfo: string;
begin
  Result := 'Энергия по группам (за сутки)';
end;

function TGetEngGrpDay.TestRange: boolean;
begin
  Result := TestGroups;
end;

end.
