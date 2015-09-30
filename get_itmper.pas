unit get_itmper;

interface

uses kernel, period, request_pipeline, box;

type

  TGetItmPer = class(TRequestPipeline)
    constructor Create(period: TPeriod; wPeriodMin, wPeriodCount: word; ItemNames: names; wItemsMin, wItemsCount: word);
    procedure Run; override;
    procedure Show; override;
  protected
    cwPeriod, wPeriodMin, wPeriodCount: word;
    function TestRange: boolean; virtual; abstract;
    procedure ReadData(wItem: word); virtual; abstract;
    procedure ShowData; virtual; abstract;
    procedure Request; virtual; abstract;
  end;

implementation

uses SysUtils, main, output, support, progress;

constructor TGetItmPer.Create(period: TPeriod; wPeriodMin, wPeriodCount: word; ItemNames: names; wItemsMin, wItemsCount: word);
begin
  inherited Create(period, ItemNames, wItemsMin, wItemsCount);

  self.wPeriodMin := wPeriodMin;
  self.wPeriodCount := wPeriodCount;
end;

procedure TGetItmPer.Run;
begin
  if TestRange then
  begin
    cwPeriod := 0;

    InitStep;

    AddInfo('');
    AddInfo('');
    AddInfo(GetInfo);
    AddInfo('');
    ShowPeriod(cwPeriod);
    Request;
  end;
end;

procedure TGetItmPer.Show;
var
  c: word;
begin
  Stop;
  InitPop(6);

  for c := wStepMin to wStepMin + wStepCount - 1 do
    ReadData(c);

  ShowProgress(cwPeriod * wItemsCount + wStepMin + wStepCount - 1, wPeriodCount * wItemsCount);

  if wStepMin + wStepCount - 1 >= wItemsCount then
  begin
    ShowData();

    Inc(cwPeriod);
    if (cwPeriod < wPeriodCount) then
    begin
      ShowPeriod(cwPeriod);
      InitStep;
      Request;
    end
    else
      RunBox;
  end
  else
  begin
    NextStep;
    Request;
  end;
end;

end.
