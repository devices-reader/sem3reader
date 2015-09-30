unit pipeline;

interface

procedure ShowDaysPipeline(wDay: word);
procedure ShowMonthsPipeline(wMonth: word);

procedure ShowCanalsPipeline;
procedure InitCanalsPipeline(wStep: word; wMin: word; wCount: word);
procedure NextCanalsPipeline(wCount: word);

procedure ShowGroupsPipeline;
procedure InitGroupsPipeline(wStep: word; wMin: word; wCount: word);
procedure NextGroupsPipeline(wCount: word);

var
 wCanalsMin, wCanalsCount: word;
 wGroupsMin, wGroupsCount: word;

implementation

uses SysUtils, support, get_config;

var
 wCanalsStep: word;
 wGroupsStep: word;

procedure ShowDaysPipeline(wDay: word);
begin
  AddInfo('');
  AddInfo('Чтение данных за сутки -' + IntToStr(wDay));
  AddInfo('');
end;

procedure ShowMonthsPipeline(wMonth: word);
begin
  AddInfo('Чтение данных за месяц -' + IntToStr(wMonth));
  AddInfo('');
end;

procedure ShowCanalsPipeline;
begin
  AddInfo('Чтение данных по каналам ' + IntToStr(wCanalsMin) + '-' + IntToStr(wCanalsMin+wCanalsCount-1) + ' (всего ' + IntToStr(wCanalsCount)+ ')');
end;

procedure InitCanalsPipeline(wStep: word; wMin: word; wCount: word);
begin
  wCanalsStep := wStep;
  if wCanalsStep > 5 then wCanalsStep := (wCanalsStep div 5)*5;
  if wCanalsStep = 0 then wCanalsStep := 1;

  wCanalsMin := wMin;
  if wCanalsMin+wCanalsStep-1 < wCount then wCanalsCount := wCanalsStep else wCanalsCount := wCount;
end;

procedure NextCanalsPipeline(wCount: word);
begin
  wCanalsMin := wCanalsMin+wCanalsCount;
  if wCanalsMin+wCanalsStep-1 < wCount then wCanalsCount := wCanalsStep else wCanalsCount := wCount-wCanalsMin+1;
end;

procedure ShowGroupsPipeline;
begin
  AddInfo('Чтение данных по группам ' + IntToStr(wGroupsMin) + '-' + IntToStr(wGroupsMin+wGroupsCount-1) + ' (всего ' + IntToStr(wGroupsCount)+ ')');
end;

procedure InitGroupsPipeline(wStep: word; wMin: word; wCount: word);
begin
  wGroupsStep := wStep;
  if wGroupsStep > 5 then wGroupsStep := (wGroupsStep div 5)*5;
  if wGroupsStep = 0 then wGroupsStep := 1;

  wGroupsMin := wMin;
  if wGroupsMin+wGroupsStep-1 < wCount then wGroupsCount := wGroupsStep else wGroupsCount := wCount;
end;

procedure NextGroupsPipeline(wCount: word);
begin
  wGroupsMin := wGroupsMin+wGroupsCount;
  if wGroupsMin+wGroupsStep-1 < wCount then wGroupsCount := wGroupsStep else wGroupsCount := wCount-wGroupsMin+1;
end;

end.
