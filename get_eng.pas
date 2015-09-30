unit get_eng;

interface

uses reguest_pipeline2, kernel;

type

  TGetEng = class(TRequestPipeline2)
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

function TGetEng.GetInSize: word;
begin
  Result := 6 + 4 * wStepCount * wTariffsCount + 10;
end;

function TGetEng.GetStep: word;
begin
  Result := (wSafeBuffSize - 16) div (wTariffsCount * 4 * 2);
end;

procedure TGetEng.ReadData(i: word);
var
  t: byte;
begin
  with mpEngItm[i] do
  begin
    eSum := 0;
    for t := wTariffsMin to wTariffsCount do
    begin
      mpeTariff[t] := PopFloat;
      eSum := eSum + mpeTariff[t];
    end;
  end;
end;

procedure TGetEng.ShowData;
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
        s := s + Float2StrR(mpeTariff[t]);
      end;
      s := s + Float2StrR(eSum);
      AddInfo(s);
    end;
end;

end.
