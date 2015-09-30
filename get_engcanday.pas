unit get_engcanday;

interface

uses get_eng;

type

  TGetEngCanDay = class sealed(TGetEng)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetEngCanDay: querys = (Action: acGetEngCanDay; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $40);

constructor TGetEngCanDay.Create;
begin
  with frmMain do
    inherited Create(
    quGetEngCanDay,
    TDay.Create, updDaysMin.Position, updDaysCount.Position,
    CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetEngCanDay.GetInfo: string;
begin
  Result := 'Энергия по каналам (за сутки)';
end;

function TGetEngCanDay.TestRange: boolean;
begin
  Result := TestCanals;
end;

end.
