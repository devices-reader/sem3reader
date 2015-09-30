unit get_transit;

interface

function InfoGetTransit: string;
procedure BoxGetTransit;
procedure ShowGetTransit;

implementation

uses SysUtils, output, input, support, box, main, timez;

const
  quGetTransit: querys = (Action: acGetTransit; cwOut: 6 + 4 + 4; cwIn: 6 + 0 + 10; wNumber: $F8);

function InfoGetTransit: string;
begin
  Result := 'Транзит';
end;

procedure QueryGetTransit;
begin
  with frmMain do begin
    InitPush(6);
    PushInt(updTransitDevice.Position);
    PushByte(0);
    PushByte(updTransitTimeout.Position);
    Query(quGetTransit);
  end;
end;

procedure BoxGetTransit;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetTransit);
  AddInfo('');
  QueryGetTransit;
end;

procedure ShowGetTransit;
var
  i:  byte;
  s:  string;
  ti: times;
begin
  Stop;
  InitPop(6);

  i := PopByte;

  s := PackStrR('Время', GetColWidth);
  with ti do begin
    bSecond := 0;
    bMinute := PopByte;
    bHour   := PopByte;
    bDay    := PopByte;
    bMonth  := PopByte;
    bYear   := PopByte;

    s := s +        Int2Str(bHour)   +
              ':' + Int2Str(bMinute) +
              ':' + Int2Str(bSecond) +
              ' ' + Int2Str(bDay)    +
              '.' + Int2Str(bMonth)  +
              '.' + Int2Str(bYear);
  end;
  AddInfo(s);

  if i = 9 then
    AddInfo('Транзит открыт успешно')
  else if i = 10 then
    WrnBox('Ошибка открытия транзита !')
  else
    WrnBox('Ошибка обмена - код ' + IntToStr(i))
end;

end.
