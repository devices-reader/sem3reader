unit reguest_pipeline2;

interface

uses kernel, period, request_pipeline, box;

type

  TRequestPipeline2 = class(TRequestPipeline)
    constructor Create(quT: querys; period: TPeriod; wPeriodMin, wPeriodCount: word; ItemNames: names;
      wItemsMin, wItemsCount: word; wTariffsMin, wTariffsCount: word);
    procedure Run; override;
    procedure Show; override;
  protected
    cwPeriod, wPeriodMin, wPeriodCount: word;
    wTariffsMin, wTariffsCount: word;
    function TestRange: boolean; virtual; abstract;
    procedure ReadData(wItem: word); virtual; abstract;
    procedure ShowData; virtual; abstract;
  private
    quT: querys;
    procedure Request;
  end;

implementation

uses SysUtils, main, output, support, progress;

constructor TRequestPipeline2.Create(quT: querys; period: TPeriod; wPeriodMin, wPeriodCount: word; ItemNames: names;
  wItemsMin, wItemsCount: word; wTariffsMin, wTariffsCount: word);
begin
  inherited Create(period, ItemNames, wItemsMin, wItemsCount);

  self.quT := quT;
  self.wPeriodMin := wPeriodMin;
  self.wPeriodCount := wPeriodCount;
  self.wTariffsMin := wTariffsMin;
  self.wTariffsCount := wTariffsCount;
end;

procedure TRequestPipeline2.Request;
begin
  ShowStep;

  InitPush(6);
  PushInt(wStepMin);
  PushInt(wStepCount);
  PushInt(wPeriodMin + cwPeriod);
  PushByte(wTariffsMin);
  PushByte(wTariffsCount);
  Query(quT);

  AddInfo('');
end;

procedure TRequestPipeline2.Run;
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

procedure TRequestPipeline2.Show;
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
