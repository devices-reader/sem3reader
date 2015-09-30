unit get_time22;

interface

function InfoGetTime22: string;
procedure BoxGetTime22;
procedure ShowGetTime22;

implementation

uses SysUtils, output, support, box, calendar, timez;

const
  quGetTime22: querys = (Action: acGetTime22; cwOut: 6 + 0 + 4; cwIn: 6 + 6 + 10; wNumber: $01);

function InfoGetTime22: string;
begin
  Result := 'Текущее время';
end;

procedure QueryGetTime22;
begin
  Query(quGetTime22);
end;

procedure BoxGetTime22;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetTime22);
  AddInfo('');
  QueryGetTime22;
end;

procedure ShowGetTime22;
var
  ti: times;
begin
  Stop;
  InitPop(6);

  ti := PopTimes;
  AddInfoTime(ti);
end;

end.
