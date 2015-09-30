unit get_itmpertar;

interface

uses get_itmper, period, kernel;

type

  TGetItmPerTar = class(TGetItmPer)
    constructor Create(period: TPeriod; wPeriodMin, wPeriodCount: word; ItemNames: names; wItemsMin, wItemsCount: word; wTariffsMin, wTariffsCount: word);
  protected
    wTariffsMin, wTariffsCount: word;
  end;

implementation

constructor TGetItmPerTar.Create(period: TPeriod; wPeriodMin, wPeriodCount: word; ItemNames: names; wItemsMin, wItemsCount: word; wTariffsMin, wTariffsCount: word);
begin
  inherited Create(period, wPeriodMin, wPeriodCount, ItemNames, wItemsMin, wItemsCount);
  self.wTariffsMin := wTariffsMin;
  self.wTariffsCount := wTariffsCount;
end;
end.
