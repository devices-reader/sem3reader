unit get_time;

interface

uses get;

type

TGetTime = class sealed (TGet)
  function GetInfo: string; override;
  function GetInSize: word; override;
  procedure Run; override;
  procedure Show; override;
private
  procedure Request;
end;

implementation

uses SysUtils, output, support, box, calendar, timez;

const
  quGetTime: querys = (Action: acGetTime; cwOut: 6 + 0 + 4; cwIn: 6 + 6 + 10; wNumber: $01);

function TGetTime.GetInfo: string;
begin
  Result := 'Текущее время';
end;

function TGetTime.GetInSize: word;
begin
  Result := quGetTime.cwIn;
end;

procedure TGetTime.Request;
begin
  Query(quGetTime);
end;

procedure TGetTime.Run;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(GetInfo);
  AddInfo('');
  Request;
end;

procedure TGetTime.Show;
begin
  Stop;
  InitPop(6);

  tiCurr := PopTimes;
  AddInfoTime(tiCurr);

  RunBox;
end;

end.
