unit period;

interface

uses kernel, timez;

type
TPeriod = class
  function ToIndex(tiT: times): longword; virtual; abstract;
  function FromIndex(dwT: longword): times; virtual; abstract;
  function ToString(ti: times): string; virtual; abstract;
  function GetNames: names; virtual; abstract;
end;

TDay = class sealed (TPeriod)
  function ToIndex(ti: times): longword; override;
  function FromIndex(dw: longword): times; override;
  function ToString(ti: times): string; override;
  function GetNames: names; override;
end;

TMonth = class sealed (TPeriod)
  function ToIndex(ti: times): longword; override;
  function FromIndex(dw: longword): times; override;
  function ToString(ti: times): string; override;
  function GetNames: names; override;
end;

implementation

uses calendar;

function TDay.ToIndex(ti: times): longword;
begin
  Result := DateToDayIndex(ti);
end;

function TDay.FromIndex(dw: longword): times;
begin
  Result := DayIndexToDate(dw);
end;

function TDay.ToString(ti: times): string;
begin
  Result := Times2StrDay(ti);
end;

function TDay.GetNames: names;
begin
  Result := DAY_NAMES;
end;

function TMonth.ToIndex(ti: times): longword;
begin
  Result := DateToMonIndex(ti);
end;

function TMonth.FromIndex(dw: longword): times;
begin
  Result := MonIndexToDate(dw);
end;

function TMonth.ToString(ti: times): string;
begin
  Result := Times2StrMon(ti);
end;

function TMonth.GetNames: names;
begin
  Result := MONTH_NAMES;
end;

end.
