unit get_enggrpmon;

interface

uses get_eng;

type

  TGetEngGrpMon = class sealed(TGetEng)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetEngGrpMon: querys = (Action: acGetEngGrpMon; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $43);

constructor TGetEngGrpMon.Create;
begin
  with frmMain do
    inherited Create(
    quGetEngGrpMon,
    TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
    GROUP_NAMES, updGroupsMin.Position, updGroupsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetEngGrpMon.GetInfo: string;
begin
  Result := 'Энергия по группам (за месяц)';
end;

function TGetEngGrpMon.TestRange: boolean;
begin
  Result := TestGroups;
end;

end.
