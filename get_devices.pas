unit get_devices;

interface

uses kernel;

var
  mpDevices: array[1..CANALS] of string;

function InfoGetDevices: string;
procedure BoxGetDevices;
procedure ShowGetDevices;

implementation

uses SysUtils, output, support, box, get_config;

const
  quGetDevices:   querys = (Action: acGetDevices; cwOut: 6+4+4; cwIn: 0; wNumber: $D1);

function InfoGetDevices: string;
begin
  Result := 'Поддерживаемые устройства';
end;

procedure QueryGetDevices;
begin
  InitPush(6);
  PushInt(1);
  PushInt(bDevices);
  Query(quGetDevices);
end;

procedure BoxGetDevices;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetDevices);
  AddInfo('');
  QueryGetDevices;
end;

procedure ShowGetDevices;
var
  d:  byte;
  n:  word;
  s:  string;
begin
  Stop;
  InitPop(6);

  s := PackStrR('№', 4);
  s := s + PackStrR('название', 16);
  AddInfo(s);

  AddInfo(PackLine(4+16));

  for d := 1 to bDevices do begin
    n := PopWord;
    mpDevices[d] := PopStr(16);
    AddInfo(PackStrR(IntToStr(n), 4) + mpDevices[d]);
  end;

  RunBox;
end;

end.
