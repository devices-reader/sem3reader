unit request_pipeline;

interface

uses kernel, period, get;

type

  TRequestPipeline = class(TGet)
  protected
    period: TPeriod;
    ItemNames: names;
    wItemsMin, wItemsCount: word;
    wStepMin, wStepCount: word;
    constructor Create(period: TPeriod; ItemNames: names; wItemsMin, wItemsCount: word);
    procedure InitStep;
    procedure ShowStep;
    procedure NextStep;
    procedure ShowPeriod(cwPeriod: word);
    function GetStep: word; virtual; abstract;
  private
    wStep: word;
  end;

implementation

uses SysUtils, support;

constructor TRequestPipeline.Create(period: TPeriod; ItemNames: names; wItemsMin, wItemsCount: word);
begin
  self.period := period;
  self.ItemNames := ItemNames;
  self.wItemsMin := wItemsMin;
  self.wItemsCount := wItemsCount;
end;

procedure TRequestPipeline.InitStep;
begin
  wStep := GetStep;
  if wStep > 5 then
    wStep := (wStep div 5) * 5;

  if wStep = 0 then wStep := 1;

  wStepMin := wItemsMin;
  if wStepMin + wStep - 1 < wItemsCount then
    wStepCount := wStep
  else
    wStepCount := wItemsCount;
end;

procedure TRequestPipeline.ShowStep;
begin
  AddInfo('Чтение данных по ' + ItemNames.Plural.Dative + ' '
  + IntToStr(wStepMin) + '-' + IntToStr(wStepMin + wStepCount - 1)
  + ' (всего ' + IntToStr(wStepCount) + ')');
end;

procedure TRequestPipeline.NextStep;
begin
  wStepMin := wStepMin + wStepCount;

  if wStepMin + wStep - 1 < wItemsCount then
    wStepCount := wStep
  else
    wStepCount := wItemsCount - wStepMin + 1;
end;

procedure TRequestPipeline.ShowPeriod(cwPeriod: word);
begin
  AddInfo('');
  AddInfo('Чтение данных за ' + period.GetNames.Singular.Nominative + ' -' + IntToStr(cwPeriod));
  AddInfo('');
end;

end.
