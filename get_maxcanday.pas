unit get_maxcanday;

interface

uses get_max;

type
  TGetMaxCanDay = class sealed(TGetMax)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetMaxCanDay: querys = (Action: acGetMaxCanDay; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $A0);

constructor TGetMaxCanDay.Create;
begin
  with frmMain do
    inherited Create(
    quGetMaxCanDay,
    TDay.Create, updDaysMin.Position, updDaysCount.Position,
    CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetMaxCanDay.GetInfo: string;
begin
  Result := 'Максимумы мощности по каналам (за сутки)';
end;

function TGetMaxCanDay.TestRange: boolean;
begin
  Result := TestCanals;
end;

end.
