unit get_eng_x2;

interface

uses reguest_pipeline2, kernel;

type

  TGetEngX2 = class(TRequestPipeline2)
  protected
    function GetInSize: word; override;
    function GetStep: word; override;
    procedure ReadData(i: word); override;
    procedure ShowData; override;
  private
    mpEngItm: array [0 .. ITEMS - 1] of energy;
  end;

implementation

uses SysUtils, support, box, output, realz, timez, get_config;

function TGetEngX2.GetInSize: word;
begin
  Result := 6 + 8 * wStepCount * wTariffsCount + 10;
end;

function TGetEngX2.GetStep: word;
begin
  Result := (wSafeBuffSize - 16) div (wTariffsCount * 8 * 2);
end;

procedure TGetEngX2.ReadData(i: word);
var
  t: byte;
begin
  with mpEngItm[i] do
  begin
    eSum := 0;
    for t := wTariffsMin to wTariffsCount do
    begin
      mpeTariff[t] := PopDouble;
      eSum := eSum + mpeTariff[t];
    end;
  end;
end;

procedure TGetEngX2.ShowData;
var
  c: word;
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
    s := s + PackStrR('тариф ' + IntToStr(t), GetColWidth);
  s := s + PackStrR('всего', GetColWidth);
  AddInfo(s);

  for c := wItemsMin to wItemsMin + wItemsCount - 1 do
    with mpEngItm[c] do
    begin
      s := PackStrR(ItemNames.Singular.Nominative + ' ' + IntToStr(c), GetColWidth);
      for t := wTariffsMin to wTariffsCount do
      begin
        s := s + Double2StrR(mpeTariff[t]);
      end;
      s := s + Double2StrR(eSum);
      AddInfo(s);
    end;
end;

end.
