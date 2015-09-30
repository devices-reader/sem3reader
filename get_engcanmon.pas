unit get_engcanmon;

interface

uses get_eng;

type

  TGetEngCanMon = class sealed(TGetEng)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetEngCanMon: querys = (Action: acGetEngCanMon; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $42);

constructor TGetEngCanMon.Create;
begin
  with frmMain do
    inherited Create(
    quGetEngCanMon,
    TMonth.Create, updMonthsMin.Position, updMonthsCount.Position,
    CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetEngCanMon.GetInfo: string;
begin
  Result := 'Энергия по каналам (за месяц)';
end;

function TGetEngCanMon.TestRange: boolean;
begin
  Result := TestCanals;
end;

end.
