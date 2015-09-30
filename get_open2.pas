unit get_open2;

interface

uses box;

procedure BoxGetOpen2(ac: actions);
procedure ShowGetOpen2;

implementation

uses SysUtils, support, output, timez, input, get_setup2, get_time20, get_transit;

var
  acNext: actions;

const
  quGetOpen2:  querys = (Action: acGetOpen2; cwOut: 6+8+4; cwIn: 6+1+9; wNumber: $E0);

function InfoGetOpen2: string;
begin
  Result := '�������� ������';
end;

procedure QueryGetOpen2(ac: actions);
var
  s:  string;
  i:  byte;
begin
  acNext := ac;

  s := GetPassword;
  AddInfo(PackStrR('������:', GetColWidth) + s);
//  if Length(s) <> 8 then raise Exception.Create('������������ ����� ������ !'); {?}

  InitPush(6);
  for i := 1 to 8 do begin
    if i <= Length(s) then
      PushByte(Ord(s[i]))
    else
      PushByte(0);
  end;
  Query(quGetOpen2);
end;

procedure BoxGetOpen2(ac: actions);
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetOpen2);
  AddInfo('');
  QueryGetOpen2(ac);
end;

procedure ShowGetOpen2;
var
  i:    byte;
begin
  Stop;
  InitPop(6);

  i := PopByte;
  if i = 6 then begin
    AddInfo('����� ������ �������');

    if acNext = acGetSetup2 then
      BoxGetTime20
    else if acNext = acGetTransit then
      BoxGetTransit
    else
      ErrBox('����������� ������ !');

  end
  else
    WrnBox(GetErrorMessage(i))

end;

end.
