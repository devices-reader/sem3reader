unit get_serials;

interface

uses kernel;

var
  mpSerials: array [1 .. CANALS] of digital;

function InfoGetSerials: string;
procedure BoxGetSerials;
procedure ShowGetSerials;

implementation

uses SysUtils, output, support, box, timez, get_config, get_devices;

const
  quGetSerials: querys = (Action: acGetSerials; cwOut: 6 + 4 + 4; cwIn: 0; wNumber: $8012);

function InfoGetSerials: string;
begin
  Result := 'Заводские номера';
end;

procedure QueryGetSerials;
begin
  InitPush(6);
  PushInt(GetDigitalsMin);
  PushInt(GetDigitalsCount);
  Query(quGetSerials);
end;

procedure BoxGetSerials;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetSerials);
  AddInfo('');
  QueryGetSerials;
end;

function GetSerial(dwSerial: longword): string;
begin
  if dwSerial = $FFFFFFFF then
    Result := '-'
  else
    Result := IntToStr(dwSerial);
end;

function LongToTimes(j: longword): times;
var
  d,m,y: longword;
	date,t: longword;
begin
	date := j div 86400;
	t := j - (date * 86400);
	date := date + 720000;

	y  := (4 * date - 1) div 146097;
	d  := (4 * date - 1 - 146097 * y) div 4;

	date := (4 * d + 3) div 1461;

	d := (4 * d + 7 - 1461 * date) div 4;
	m := (5 * d - 3) div 153;

	d := (5 * d + 2 - 153 * m) div 5;
	y := 100 * y + date;

	if (m < 10) then
		m := m + 3
	else begin
		m := m - 9;
		y := y + 1;
	end;

	result.bMonth  := m;
	result.bYear   := y mod 100;
	result.bDay    := d;

	result.bSecond := t mod 60;
  t := t div 60;
	result.bHour   := t div 60;
	result.bMinute := t mod 60;
end;

function GetTime(dwTime: longword): string;
begin
  Result := IntToHex(dwTime,8);

  if ((dwTime and $FFFFFFF0) <> $FFFFFFF0) then
    Result := Result + '    ' + Times2Str(LongToTimes(dwTime));
end;

procedure ShowGetSerials;
var
  dwSerial,dwTime: longword;
  d: word;
  s: string;
begin
  Stop;
  InitPop(6);

  s := PackStrR('заводской №', 14);
  s := s + PackStrR('время сохранения', 14);
  AddInfo(s);

  AddInfo(PackLine(14 + 14));

  for d := GetDigitalsMin to GetDigitalsMin+GetDigitalsCount-1 do  begin
      dwSerial := PopLong;
      dwTime := PopLong;

      s := PackStrR(GetSerial(dwSerial), 14);
      s := s + PackStrR(GetTime(dwTime), 14);

      AddInfo(s);
    end;

  RunBox;
end;

end.
