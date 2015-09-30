{?}unit get_open;

interface

function InfoGetOpen: string;
procedure BoxGetOpen;
procedure ShowGetOpen;

implementation

uses SysUtils, support, output, timez, box;

const
  quGetOpen:  querys = (Action: acGetOpen; cwOut: 6+8+4; cwIn: 6+1+9; wNumber: $E0);

function InfoGetOpen: string;
begin
  Result := 'Открытие канала';
end;

procedure QueryGetOpen;
var
  s:  string;
  i:  byte;
begin
    s := GetPassword;
    AddInfo(PackStrR('Пароль:', GetColWidth) + s);
//    if Length(s) <> 8 then raise Exception.Create('Неправильная длина пароля !');

    InitPush(6);
    for i := 1 to 8 do begin
      if i <= Length(s) then
        PushByte(Ord(s[i]))
      else
        PushByte(0);
    end;
    Query(quGetOpen);
end;

procedure BoxGetOpen;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetOpen);
  AddInfo('');
  QueryGetOpen;
end;

procedure ShowGetOpen;
var
  i:    byte;
begin
  Stop;
  InitPop(6);

  i := PopByte;
  if i = 6 then begin
    AddInfo('Канал открыт успешно');
    RunBox
  end
  else if i = 7 then
    WrnBox('Неправильный пароль')
  else
    WrnBox('Ошибка открытия канала - код '+IntToStr(i));
end;

end.
