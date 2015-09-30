unit get_time20;

interface

function InfoGetTime20: string;
procedure BoxGetTime20;
procedure ShowGetTime20;

implementation

uses SysUtils, output, support, box, calendar, timez, get_setup2;

const
  quGetTime20: querys = (Action: acGetTime20; cwOut: 6 + 0 + 4; cwIn: 6 + 6 + 10; wNumber: $01);

function InfoGetTime20: string;
begin
  Result := 'Текущее время до коррекции';
end;

procedure QueryGetTime20;
begin
  Query(quGetTime20);
end;

procedure BoxGetTime20;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetTime20);
  AddInfo('');
  QueryGetTime20;
end;

procedure ShowGetTime20;
var
  ti: times;
begin
  Stop;
  InitPop(6);

  ti := PopTimes;
  AddInfoTime(ti);

  BoxGetSetup2;
end;

end.
