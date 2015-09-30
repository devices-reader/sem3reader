unit profile;

interface

uses Classes, timez;

type
  TProfile = class
  public
    constructor Create(wMin: word; wMax: word);
    procedure AddValue(wCanal: word; eValue: extended; ti: times);
    function GetResult(sName: string): TStringList;
  private
    wItemMin: word;
    wItemMax: word;
  end;

implementation

uses SysUtils, Math, support, realz;

const
  ITEMS = 512;

type
  canal_t = record
    energy: array [0 .. ITEMS - 1] of extended;
  end;

  half_t = record
    value: canal_t;
    flag: boolean;
    nan: boolean;
  end;

  day_t = record
    halfs: array [0 .. 47] of half_t;
    value: canal_t;
    flag: boolean;
    nan: boolean;
  end;

  month_t = record
    days: array [1 .. 31] of day_t;
    value: canal_t;
    flag: boolean;
    nan: boolean;
  end;

var
  year: array [1 .. 12] of month_t;

constructor TProfile.Create(wMin: word; wMax: word);
var
  c: word;
  d, h, m: byte;
begin
  wItemMin := wMin;
  wItemMax := wMax;

  for c := 0 to ITEMS - 1 do
  begin
    for m := 1 to 12 do
    begin
      year[m].flag := false;
      year[m].nan := false;
      year[m].value.energy[c] := 0;
      for d := 1 to 31 do
      begin
        year[m].days[d].flag := false;
        year[m].days[d].nan := false;
        year[m].days[d].value.energy[c] := 0;
        for h := 0 to 47 do
        begin
          year[m].days[d].halfs[h].flag := false;
          year[m].days[d].halfs[h].nan := false;
          year[m].days[d].halfs[h].value.energy[c] := 0;
        end;
      end;
    end;
  end;
end;

procedure TProfile.AddValue(wCanal: word; eValue: extended; ti: times);
var
  d, h, m: byte;
  nan: boolean;
begin
  h := ti.bHour * 2 + ti.bMinute div 30;
  d := ti.bDay;
  m := ti.bMonth;

  if IsNaN(eValue) then
  begin
    nan := true;
    eValue := 0;
  end
  else
    nan := false;

  year[m].flag := true;
  year[m].nan := year[m].nan or nan;
  year[m].value.energy[wCanal] := year[m].value.energy[wCanal] + eValue;

  year[m].days[d].flag := true;
  year[m].days[d].nan := year[m].days[d].nan or nan;
  year[m].days[d].value.energy[wCanal] := year[m].days[d].value.energy[wCanal] + eValue;

  year[m].days[d].halfs[h].flag := true;
  year[m].days[d].halfs[h].nan := year[m].days[d].halfs[h].nan or nan;
  year[m].days[d].halfs[h].value.energy[wCanal] := year[m].days[d].halfs[h].value.energy[wCanal] + eValue;
end;

function TProfile.GetResult(sName: string): TStringList;
var
  c: word;
  d, h, m: byte;
  s, z: string;
begin

  Result := TStringList.Create;

  Result.Add('');
  for m := 1 to 12 do
  begin
    for d := 1 to 31 do
    begin
      if year[m].days[d].flag then
      begin

        Result.Add('');

        s := PackStrR('', GetColWidth);
        for c := wItemMin to wItemMax do
          s := s + PackStrR(sName + IntToStr(c), GetColWidth);
        Result.Add(s);

        s := PackLine(GetColWidth);
        for c := wItemMin to wItemMax do
          s := s + PackLine(GetColWidth);
        Result.Add(s);

        s := PackStrR('сутки ' + Int2Str(d, 2) + '.' + Int2Str(m, 2), GetColWidth);
        Result.Add(s);

        for h := 0 to 47 do
        begin
          s := PackStrR(Int2Str(h div 2, 2) + '.' + Int2Str((h mod 2) * 30, 2), GetColWidth);
          if (year[m].days[d].halfs[h].flag) then
            for c := wItemMin to wItemMax do
            begin
              if year[m].days[d].halfs[h].nan then
                z := PackStrR('?', GetColWidth)
              else
                z := Float2StrR(year[m].days[d].halfs[h].value.energy[c]);

              s := s + z;
            end;
          Result.Add(s);
        end;
      end;
    end;
  end;

  Result.Add('');
  for m := 1 to 12 do
  begin
    if year[m].flag then
      Result.Add(PackStrR('мес€ц ' + IntToStr(m), GetColWidth));
    for d := 1 to 31 do
    begin
      if year[m].days[d].flag then
      begin
        s := PackStrR('сутки ' + Int2Str(d, 2) + '.' + Int2Str(m, 2), GetColWidth);
        for c := wItemMin to wItemMax do
        begin
          if year[m].days[d].nan then
            z := ' ?'
          else
            z := '';
          s := s + PackStrR(Float2Str(year[m].days[d].value.energy[c]) + z, GetColWidth);
        end;
        Result.Add(s);
      end;
    end;
  end;

  Result.Add('');
  for m := 1 to 12 do
  begin
    if year[m].flag then
    begin
      s := PackStrR('мес€ц ' + IntToStr(m), GetColWidth);
      for c := wItemMin to wItemMax do
      begin
        if year[m].nan then
          z := ' ?'
        else
          z := '';
        s := s + PackStrR(Float2Str(year[m].value.energy[c]) + z, GetColWidth);
      end;
      Result.Add(s);
    end;
  end;

end;

end.
