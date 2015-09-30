{ ? } unit get_canals;

interface

function InfoGetCanals: string;
procedure BoxGetCanals;
procedure ShowGetCanals;

implementation

uses SysUtils, output, support, box, kernel, realz, progress, pipeline, get_config, get_devices;

const
  quGetCanals: querys = (Action: acGetCanals; cwOut: 6 + 4 + 4; cwIn: 0; wNumber: $D3);

var
  mpCanals: array [1 .. CANALS] of canal;

function InfoGetCanals: string;
begin
  Result := 'Каналы';
end;

procedure QueryGetCanals;
begin
  ShowCanalsPipeline;

  InitPush(6);
  PushInt(wCanalsMin);
  PushInt(wCanalsCount);
  Query(quGetCanals);
end;

procedure BoxGetCanals;
begin
  InitCanalsPipeline((wSafeBuffSize-16) div 52, 1, wCanals);

  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetCanals);
  AddInfo('');
  QueryGetCanals;
end;

function Line2Str(c: byte): string;
begin
  with mpCanals[c] do
  begin
    case bLine of
      0:
        Result := 'A+';
      1:
        Result := 'A-';
      2:
        Result := 'R+';
      3:
        Result := 'R-';
    else
      Result := '?';
    end;
  end;
end;

function Type2Str(c: byte): string;
begin
  with mpCanals[c] do
  begin
    if (bMask and $01) = 0 then
      Result := 'разрешен'
    else
      Result := 'запрещен';
  end;
end;

function Tariffs2Str(c: byte): string;
begin
  with mpCanals[c] do
  begin
    if (bMask and $02) = 0 then
      Result := '1'
    else
      Result := '2';
  end;
end;

procedure ShowGetCanals;
var
  c: word;
  n: word;
  s: string;
begin
  Stop;
  InitPop(6);

  for c := wCanalsMin to wCanalsMin+wCanalsCount-1 do
    with mpCanals[c] do
    begin
      n := PopWord;
      AddTerm('номер канала: ' + IntToStr(n));

      iwDigital := PopWord;
      iwCanal := PopWord;
      Ktrans := PopFloat();
      Kpulse := PopFloat();
      Klosse := PopFloat();
      bLine := PopByte;
      bMask := PopByte;
      sName := PopStr(32);
    end;

  ShowProgress(wCanalsMin+wCanalsCount-1, wCanals);

  if wCanalsMin+wCanalsCount-1 >= wCanals then begin

    s := PackStrR('№', 4);
    s := s + PackStrR('название', 32 + 2);
    s := s + PackStrR('устройство', 12);
    s := s + PackStrR('канал', 7);
    s := s + PackStrR('энергия', 9);
    s := s + PackStrR('К трансформации', 17);
    s := s + PackStrR('К преобразования', 18);
    s := s + PackStrR('К потерь', 10);
    s := s + PackStrR('опрос', 10);
    s := s + PackStrR('тарифное расписание', 20);
    AddInfo(s);

    AddInfo(PackLine(4 + 32 + 2 + 12 + 7 + 9 + 17 + 18 + 10 + 10 + 20));

    for c := 1 to wCanals do with mpCanals[c] do begin
      s := PackStrR(IntToStr(c), 4);
      s := s + PackStrR(sName, 32 + 2);
      s := s + PackStrR(IntToStr(iwDigital), 12);
      s := s + PackStrR(IntToStr(iwCanal), 7);
      s := s + PackStrR(Line2Str(c), 9);
      s := s + PackStrR(Float2Str(Ktrans), 17);
      s := s + PackStrR(Float2Str(Kpulse), 18);
      s := s + PackStrR(Float2Str(Klosse), 10);
      s := s + PackStrR(Type2Str(c), 10);
      s := s + PackStrR(Tariffs2Str(c), 10);
      AddInfo(s);
    end;

    RunBox;
  end
  else begin
    NextCanalsPipeline(wCanals);
    QueryGetCanals;
  end;
end;

end.
