unit get_digitals;

interface

uses kernel;

var
  mpDigitals: array [1 .. CANALS] of digital;

function InfoGetDigitals: string;
procedure BoxGetDigitals;
procedure ShowGetDigitals;

implementation

uses SysUtils, output, support, box, get_config, get_devices;

const
  quGetDigitals: querys = (Action: acGetDigitals; cwOut: 6 + 4 + 4; cwIn: 0; wNumber: $D2);

function InfoGetDigitals: string;
begin
  Result := 'Устройства';
end;

procedure QueryGetDigitals;
begin
  InitPush(6);
  PushInt(GetDigitalsMin);
  PushInt(GetDigitalsCount);
  Query(quGetDigitals);
end;

procedure BoxGetDigitals;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetDigitals);
  AddInfo('');
  QueryGetDigitals;
end;

function GetSerial(d: byte): string;
begin
  with mpDigitals[d] do
  begin
    if dwSerial = $FFFFFFFF then
      Result := '-'
    else
      Result := IntToStr(dwSerial);
  end;
end;

function GetCanals(d: byte): string;
var
  i: word;
begin
  with mpDigitals[d] do
  begin
    if cwCanals = 0 then
      Result := 'нет каналов'
    else
    begin
      Result := '';
      for i := 1 to cwCanals do
      begin
        Result := Result + IntToStr(wCanal1 + i - 1);
        if i <> cwCanals then
          Result := Result + ',';
      end;
    end
  end;
end;

procedure ShowGetDigitals;
var
  i: byte;
  b: byte;
  d: word;
  s: string;
begin
  Stop;
  InitPop(6);

  s := PackStrR('№', 4);
  s := s + PackStrR('код', 4);
  s := s + PackStrR('название промежуточного узла', 32);
  s := s + PackStrR('заводской №', 14);
  s := s + PackStrR('сетевой №', 12);
  s := s + PackStrR('глубина опроса', 16);
  s := s + PackStrR('каналы', 40);
  AddInfo(s);

  AddInfo(PackLine(4 + 4 + 32 + 14 + 12 + 16 + 40));

  for d := GetDigitalsMin to GetDigitalsMin+GetDigitalsCount-1 do
    with mpDigitals[d] do
    begin
      n := PopWord;

      iwDevice := PopWord;
      dwSerial := PopLong;
      wNumber := PopWord;
      cwCanals := PopWord;
      wWidth := PopWord;
      wCanal1 := PopWord;

      for i := 1 to 6 do
        PopByte;

      for i := 1 to 2 do
        mpMask1[i - 1] := PopByte;
      for i := 1 to 8 do
        mpMask2[i - 1] := PopByte;

      sName := PopStr(32);

      s := PackStrR(IntToStr(n), 4);
      s := s + PackStrR(IntToStr(iwDevice), 4);
      s := s + PackStrR(sName, 32);
      s := s + PackStrR(GetSerial(d), 14);
      s := s + PackStrR(IntToStr(wNumber), 12);
      s := s + PackStrR(IntToStr(wWidth), 16);
      s := s + PackStrR(GetCanals(d), 40);

      AddInfo(s);
    end;

  AddInfo('');
  s := PackStrR('№', 4);
  s := s + PackStrR('3-минутный опрос', 20);
  s := s + PackStrR('коррекция времени', 20);
  s := s + PackStrR('30-минутный опрос', 20);
  s := s + PackStrR('опрос мгновенных значений', 26);
  AddInfo(s);

  AddInfo(PackLine(4 + 20 + 20 + 20 + 26));

  for d := GetDigitalsMin to GetDigitalsMin+GetDigitalsCount-1 do
    with mpDigitals[d] do
    begin
      s := PackStrR(IntToStr(n), 4);
      s := s + PackStrR(Bit2Str(mpMask1[1] and $01), 20);
      s := s + PackStrR(Bit2Str(mpMask1[1] and $02), 20);
      s := s + PackStrR(Bit2Str(mpMask1[1] and $04), 20);
      s := s + PackStrR(Bit2Str(mpMask1[1] and $08), 26);
      AddInfo(s);
    end;

  AddInfo('');
  s := PackStrR('№', 4);
  for i := 0 to CURRENTS_COUNT-1 do
    s := s + PackStrR(CURRENTS[i].sName, 6);
  AddInfo(s);

  AddInfo(PackLine(4 + CURRENTS_COUNT * 6));

  for d := GetDigitalsMin to GetDigitalsMin+GetDigitalsCount-1 do
    with mpDigitals[d] do
    begin
      s := PackStrR(IntToStr(n), 4);
      for i := 0 to CURRENTS_COUNT-1 do begin
        b := mpMask2[7 - (i div 8)] and ($01 shl (i mod 8));
        s := s + PackStrR(Bit2Str(b), 6);
      end;
      AddInfo(s);
    end;

  RunBox;
end;

end.
