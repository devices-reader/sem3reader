unit get_engcanday_x2;

interface

uses get_eng_x2;

type

  TGetEngCanDayX2 = class sealed(TGetEngX2)
    constructor Create;
    function GetInfo: string; override;
    function TestRange: boolean; override;
  end;

implementation

uses SysUtils, main, kernel, box, period, borders;

const
  quGetEngCanDayX2: querys = (Action: acGetEngCanDayX2; cwOut: 6 + 8 + 4; cwIn: 0; wNumber: $1040);

constructor TGetEngCanDayX2.Create;
begin
  with frmMain do
    inherited Create(
    quGetEngCanDayX2,
    TDay.Create, updDaysMin.Position, updDaysCount.Position,
    CANAL_NAMES, updCanalsMin.Position, updCanalsCount.Position,
    updTariffsMin.Position, updTariffsCount.Position
    );
end;

function TGetEngCanDayX2.GetInfo: string;
begin
  Result := 'Энергия по каналам (за сутки) (двойная точность)';
end;

function TGetEngCanDayX2.TestRange: boolean;
begin
  Result := TestCanals;
end;

end.
