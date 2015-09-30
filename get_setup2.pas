{ ? } unit get_setup2;

interface

procedure BoxGetSetup2;
procedure ShowGetSetup2;

implementation

uses SysUtils, support, output, timez, box, input, get_open2, get_time21, setup2;

const
  quGetSetup2: querys = (Action: acGetSetup2; cwOut: 6 + 6 + 4; cwIn: 6 + 1 + 9; wNumber: $02);

procedure QueryGetSetup2;
var
  tiT: times;
begin

  tiT := Str2Times(frmSetup2.medSetTime.Text);

  InitPush(6);

  with tiT do
  begin
    PushByte(bSecond);
    PushByte(bMinute);
    PushByte(bHour);
    PushByte(bDay);
    PushByte(bMonth);
    PushByte(bYear);
  end;

  AddInfo(Times2Str(tiT));

  Query(quGetSetup2);
end;

procedure BoxGetSetup2;
begin
  AddInfo('');
  AddInfo('Коррекция времени');
  QueryGetSetup2;
end;

procedure ShowGetSetup2;
var
  i: byte;
begin
  Stop;
  InitPop(6);

  i := PopByte;
  if i = 0 then
    BoxGetTime21
  else
  begin
    WrnBox(GetErrorMessage(i));
  end;
end;

end.
