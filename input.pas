{?}unit input;

interface

procedure PostInputComPort;
procedure PostInputSocket(s: string);
function GetErrorMessage(bT: byte): string;

const
  cbMaxRepeat = 20;
var
  cwIncTotal,
  cbIncRepeat,
  cbCurRepeat:  word;

implementation

uses SysUtils, Graphics, support, output, main, terminal, crc, box, timez, get_config;

function GetErrorMessage(bT: byte): string;
begin
  case bT of
    0: Result := 'Информация достоверна';
    1: Result := 'Неполные данные';
    2: Result := 'Данные не готовы';
    3: Result := 'Функция не поддерживается';
    4: Result := 'Необходимо открытие канала';
    5: Result := 'Аппаратная ошибка';
    6: Result := 'Доступ открыт';
    7: Result := 'Доступ не открыт: неверный пароль';
    8: Result := 'Неправильные параметры';
    9: Result := 'Транзит открыт';
    10: Result := 'Транзит невозможен: устройство занято';
    11: Result := 'Запрошенные данные не существуют';
    12: Result := 'Переполнение выходного буфера';
    13: Result := 'Невозможно скорректировать время: переход через границу получаса';
    14: Result := 'Невозможно скорректировать время: разница слишком велика';

    $fc: Result := 'Устройство находится в режиме программироваие';
    $fd: Result := 'Устройство занято';
    $fe: Result := 'Аппаратная защита';
    $ff: Result := 'Аппаратная ошибка: котрольная сумма данных неверна';

    else Result := 'Неизвестная ошибка: код '+IntToStr(bT);
  end;
end;

function MultiBox(wSize: word): boolean;
begin
  Result := False;

  if wSize = 16 then begin
    if (mpbIn[6] = 0) then begin
      Stop;
      InfBox('Операция завершена успешно');
      Result := True;
    end
    else if (mpbIn[6] = 6) then begin
      AddInfo(GetErrorMessage(mpbIn[6]));
    end
    else if (mpbIn[6] = 9) then begin
    end
    else begin
      Stop;
      WrnBox(GetErrorMessage(mpbIn[6]));
      Result := True;
    end;
  end;
end;

procedure BadSizeBox(wSize1,wSize2: word);
begin
 ErrBox('Неправильная длина ответа: ' +
         IntToStr(wSize1) + ' вместо ' + IntToStr(wSize2) + ' байт');
end;

procedure OtherActionsCRC(cwIn: word);
var
  ti: times;
begin
  cbCurRepeat := 0;

  if cwIn <> queQuery.cwIn then
    BadSizeBox(cwIn,queQuery.cwIn)
  else begin
    with ti do begin
       bSecond := 0;
       bMinute := mpbIn[cwIn-9];
       bHour := mpbIn[cwIn-8];
       bDay := mpbIn[cwIn-7];
       bMonth := mpbIn[cwIn-6];
       bYear := mpbIn[cwIn-5];
       AddInfo('Идентификатор: ' + Int2Str(bHour) + ':' + Int2Str(bMinute) + ' ' + Int2Str(bDay) + '.' + Int2Str(bMonth) + '.' + Int2Str(bYear) + '; ' + GetErrorMessage(mpbIn[cwIn-10]));
       AddInfo('')
     end;
     BoxShow(queQuery.Action);
   end;
 end;

 procedure PostInputComPort;
 var
   wSize: word;
 begin
   with frmMain do
   begin
     wSize := ComPort.InBuffUsed;
     AddTerminal('// принято с порта: ' + IntToStr(wSize) + ' байт',clGray);
     ComPort.GetBlock(mpbIn, wSize);

     ShowInData(wSize);
     ShowTimeout;

     if queQuery.Action = acNone then
     begin
     end

     else if (wSize = 0) and (cbCurRepeat < cbMaxRepeat) then
     begin
       Inc(cbCurRepeat);
       Inc(cbIncRepeat);
       ShowRepeat;
       AddInfo('Нет ответа от устройства, повтор: ' + IntToStr(cbCurRepeat) + ' из ' + IntToStr(cbMaxRepeat));
       Query(queQuery, true);
    end
    else if (CRC16(mpbIn,wSize) <> 0) and (cbCurRepeat < cbMaxRepeat) then begin
      Inc(cbCurRepeat);
      Inc(cbIncRepeat); ShowRepeat;

      if Sem3 and (queQuery.Action = acGetMaxCanMon) then begin
        AddTerm('Ошибка контрольной суммы, запрос не поддерживается');
        Delay(updTimeoutPort.Position);
        ComPort.GetBlock(mpbIn, wSize);
        DeleteInfo(9);
        GetMaxCanMon0.Run;
      end
      else if Sem3 and (queQuery.Action = acGetMaxGrpMon) then begin
        AddTerm('Ошибка контрольной суммы, запрос не поддерживается');
        Delay(updTimeoutPort.Position);
        ComPort.GetBlock(mpbIn, wSize);
        DeleteInfo(9);
        GetMaxGrpMon0.Run;
      end
      else begin
        AddInfo('Ошибка контрольной суммы, повтор: ' + IntToStr(cbCurRepeat) + ' из ' + IntToStr(cbMaxRepeat));
        Query(queQuery, true);
      end;
    end

    else begin
      if wSize = 0 then ErrBox('Нет ответа от устройства !')
      else
      if (CRC16(mpbIn,wSize) <> 0) then ErrBox('Ошибка контрольной суммы !')
      else
      if (mpbIn[wSize-4]*$100 + mpbIn[wSize-3] <> wLabel) then ErrBox('Ошибка кода запроса !')
      else
      if not MultiBox(wSize) then OtherActionsCRC(wSize);
    end;
  end;
end;

procedure PostInputSocket(s: string);
 var
   i,wSize: word;
 begin
   with frmMain do
   begin
     wSize := Length(s);
     AddTerminal('// принято с сокета: ' + IntToStr(wSize) + ' байт',clGray);

     if wSize = 0 then exit;
     for i := 0 to Length(s) - 1 do  mpbIn[i] := Ord(s[i+1]);

     ShowInData(wSize);
     ShowTimeout;

     if queQuery.Action = acNone then
     begin
     end

     else if (wSize = 0) and (cbCurRepeat < cbMaxRepeat) then
     begin
       Inc(cbCurRepeat);
       Inc(cbIncRepeat);
       ShowRepeat;
       AddInfo('Нет ответа от устройства, повтор: ' + IntToStr(cbCurRepeat) + ' из ' + IntToStr(cbMaxRepeat));
       Query(queQuery, true);
    end
    else if (CRC16(mpbIn,wSize) <> 0) and (cbCurRepeat < cbMaxRepeat) then begin
      Inc(cbCurRepeat);
      Inc(cbIncRepeat); ShowRepeat;

      if Sem3 and (queQuery.Action = acGetMaxCanMon) then begin
        AddTerm('Ошибка контрольной суммы, запрос не поддерживается');
        Delay(updTimeoutSocket.Position);
        // ClientSocket.Socket.ReceiveBuf(mpbIn, wSize);
        DeleteInfo(9);
        GetMaxCanMon0.Run;
      end
      else if Sem3 and (queQuery.Action = acGetMaxGrpMon) then begin
        AddTerm('Ошибка контрольной суммы, запрос не поддерживается');
        Delay(updTimeoutSocket.Position);
        // ClientSocket.Socket.ReceiveBuf(mpbIn, wSize);
        DeleteInfo(9);
        GetMaxGrpMon0.Run;
      end
      else begin
        AddInfo('Ошибка контрольной суммы, повтор: ' + IntToStr(cbCurRepeat) + ' из ' + IntToStr(cbMaxRepeat));
        Query(queQuery, true);
      end;
    end

    else begin
      if wSize = 0 then ErrBox('Нет ответа от устройства !')
      else
      if (CRC16(mpbIn,wSize) <> 0) then ErrBox('Ошибка контрольной суммы !')
      else
      if (mpbIn[wSize-4]*$100 + mpbIn[wSize-3] <> wLabel) then ErrBox('Ошибка кода запроса !')
      else
      if not MultiBox(wSize) then OtherActionsCRC(wSize);
    end;
  end;
end;

end.
