unit get_time21;

interface

function InfoGetTime21: string;
procedure BoxGetTime21;
procedure ShowGetTime21;

implementation

uses SysUtils, output, support, box, calendar, timez;

const
  quGetTime21: querys = (Action: acGetTime21; cwOut: 6 + 0 + 4; cwIn: 6 + 6 + 10; wNumber: $01);

function InfoGetTime21: string;
begin
  Result := 'Текущее время после коррекции';
end;

procedure QueryGetTime21;
begin
  Query(quGetTime21);
end;

procedure BoxGetTime21;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetTime21);
  AddInfo('');
  QueryGetTime21;
end;

procedure ShowGetTime21;
var
  ti: times;
begin
  Stop;
  InitPop(6);

  ti := PopTimes;
  AddInfoTime(ti);

  AddInfo('');
  InfBox('Коррекция времени проведена успешно')
end;

end.

