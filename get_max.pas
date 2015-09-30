unit get_max;

interface

uses reguest_pipeline2, kernel;

type

  TGetMax = class(TRequestPipeline2)
  protected
    function GetInSize: word; override;
    function GetStep: word; override;
    procedure ReadData(i: word); override;
    procedure ShowData; override;
  private
    mpMaxItm: array [0 .. ITEMS - 1] of maximums;
    function GetMaxTime(a, b: byte; s: string): string;
  end;

implementation

uses SysUtils, support, box, output, realz, timez, get_config;

function TGetMax.GetMaxTime(a, b: byte; s: string): string;
begin
  if b = $FF then
    Result := '??:??'
  else
    Result := Int2Str(b div 2) + ':' + Int2Str((b mod 2) * 30);

  Result := PackStrR(Result, 6);

  if a = $FF then
    Result := Result + '??.??.??'
  else
    Result := Result + Int2Str(a) + '.' + s;
end;

function TGetMax.GetInSize: word;
begin
  Result := 6 + 6 * wStepCount * wTariffsCount + 10;
end;

function TGetMax.GetStep: word;
begin
  Result := (wSafeBuffSize - 16) div (wTariffsCount * 6 * 3);
end;

procedure TGetMax.ReadData(i: word);
var
  t: byte;
begin
  for t := wTariffsMin to wTariffsCount do
  begin
    with mpMaxItm[i].mpTariff[t] do
    begin
      e := PopFloat;
      a := PopByte;
      b := PopByte;
    end;
  end;
end;

procedure TGetMax.ShowData;
var
  i: word;
  t: byte;
  ti: times;
  s: string;
begin
  s := Period.GetNames.Singular.Nominative + ' -' + IntToStr(cwPeriod) + ', ';
  ti := Period.FromIndex(Period.ToIndex(tiCurr) - wPeriodMin - cwPeriod);
  s := s + Period.ToString(ti);
  AddInfo(s);

  s := PackStrR('', GetColWidth);
  for t := wTariffsMin to wTariffsCount do
    s := s + PackStrL('тариф ' + IntToStr(t), GetColWidth * 2);
  AddInfo(s);

  for i := wItemsMin to wItemsMin + wItemsCount - 1 do
  begin
    s := PackStrR(ItemNames.Singular.Nominative + ' ' + IntToStr(i), GetColWidth);
    for t := wTariffsMin to wTariffsCount do
      with mpMaxItm[i].mpTariff[t] do
      begin
        s := s + PackStrL(Float2Str(e) + ' ' + GetMaxTime(a, b, Times2StrMon(ti)), GetColWidth * 2);
      end;
    AddInfo(s);
  end;
end;

end.
