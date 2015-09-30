unit get_config;

interface

var
  wCanals:  word;
  wGroups:  word;
  bTariffs: byte;
  bDevices: byte;
  wDigitals: word;
  wBuffSize: word;
  wSafeBuffSize: word;

  Sem3: boolean;

function InfoGetConfig: string;
procedure BoxGetConfig;
procedure ShowGetConfig;

implementation

uses SysUtils, output, support, box, kernel;

const
  quGetConfig:   querys = (Action: acGetConfig; cwOut: 10; cwIn: 6+82+10; wNumber: $D0);
  COLUMN_WIDTH = 28;

function InfoGetConfig: string;
begin
  Result := 'Конфигурация';
end;

procedure QueryGetConfig;
begin
  Query(quGetConfig);
end;

procedure BoxGetConfig;
begin
  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetConfig);
  AddInfo('');
  QueryGetConfig;
end;

procedure ShowGetConfig;
var
  s:  string;
begin
  Stop;
  InitPop(6);

  s := PopStr(32);
  Sem3 := (Pos('СЭМ-3',s) > 0);

  AddInfo(PackStrR('Название сумматора', COLUMN_WIDTH)+s);
  AddInfo(PackStrR('Название объекта', COLUMN_WIDTH)+PopStr(32));
  AddInfo(PackStrR('Заводской номер', COLUMN_WIDTH)+IntToStr(PopLong));
  AddInfo(PackStrR('Версия', COLUMN_WIDTH)+'0x'+IntToHex(PopWord,4));

  wCanals := PopWord;
  wGroups := PopWord;
  bTariffs := PopWord;
  bDevices := PopWord;
  wDigitals := PopWord;

  AddInfo(PackStrR('Используемые каналы', COLUMN_WIDTH)+IntToStr(wCanals));
  AddInfo(PackStrR('Используемые группы', COLUMN_WIDTH)+IntToStr(wGroups));
  AddInfo(PackStrR('Используемые тарифные зоны', COLUMN_WIDTH)+IntToStr(bTariffs));
  AddInfo(PackStrR('Поддерживаемые устройства', COLUMN_WIDTH)+IntToStr(bDevices));
  AddInfo(PackStrR('Подключенные устройства', COLUMN_WIDTH)+IntToStr(wDigitals));
  wBuffSize := PopWord;
  wSafeBuffSize := wBuffSize - 100;
  AddInfo(PackStrR('Размер передающего буфера', COLUMN_WIDTH)+IntToStr(wBuffSize));

  RunBox;
end;

end.
