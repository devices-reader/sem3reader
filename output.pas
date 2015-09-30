{?}
unit output;

interface

uses System.Types, SysUtils, Classes, Graphics, StdCtrls, Windows, StrUtils, IdGlobal, box;

var
  queQuery:  querys;
  wLabel:    word;

procedure Stop;

procedure InitPush(i: word);
procedure InitPushZero;
procedure InitPushCRC;
procedure PushByte(bT: byte);
procedure PushInt(wT: word);
procedure PushCurrentsMask;

procedure InitPopZero;
procedure InitPopCRC;
procedure InitPop(i: word);
function PopByte: byte;
function PopWord: word;
function PopInt: smallint;
function PopLong: longword;
function Bit2Str(i: byte): string;
function Bool2Str(i: byte): string;
function PopBool2Str: string;
function PopSwitch2Str: string;
function PopBits2Str: string;
function PopStr(bSize: byte): string;

procedure Query(quT: querys; boRepeat: boolean = false);
procedure QueryDirect(s: string; boCRC: boolean);

implementation

uses main, support, terminal, crc, kernel, input, borders, pipeline, get_config, get_currents2;

procedure Stop;
begin
  with frmMain do begin
    timTimeout.Enabled := False;

    queQuery.Action := acNone;
    queQuery.cwIn := 0;

    wLabel := 0;
  end;
end;

procedure InitPush(i: word);
begin
  iwOut := i;
end;

procedure InitPushZero;
begin
  iwOut := 0;
end;

procedure InitPushCRC;
begin
  iwOut := 5;
end;

procedure PushByte(bT: byte);
begin
  mpbOut[iwOut] := bT;
  Inc(iwOut);
end;

procedure PushInt(wT: word);
begin
  PushByte(wT div $100);
  PushByte(wT mod $100);
end;

procedure PushCurrentsMask;
var
  i,a,b: byte;
  mpbCurrentsMask:  array[0..7] of byte;
begin
  with frmMain do begin
    for i := 0 to 7 do mpbCurrentsMask[i] := 0;

    for i := 0 to CURRENTS_COUNT-1 do begin
       a := 7-(i div 8);
       b := $01 shl (i mod 8);

       if clbCurrents.Checked[i] then
         mpbCurrentsMask[a] := mpbCurrentsMask[a] or b;
    end;

    for i := 0 to 7 do PushByte(mpbCurrentsMask[i]);
  end;
end;

procedure InitPopZero;
begin
  iwIn := 0;
end;

procedure InitPopCRC;
begin
  iwIn := 5;
end;

procedure InitPop(i: word);
begin
  iwIn := i;
end;

function PopByte: byte;
begin
  Result := mpbIn[iwIn];
  Inc(iwIn);
end;

function PopWord: word;
begin
  Result := PopByte*$100 + PopByte;
end;

function PopInt: smallint;
var
  w: word;
  i: smallint absolute w;
begin
  w := PopWord();
  Result := i;
end;

function PopLong: longword;
begin
  Result := PopByte*$1000000 + PopByte*$10000 + PopByte*$100 + PopByte;
end;

function Bool2Str(i: byte): string;
begin
  case i of
    0:    Result := 'нет';
    255:  Result := 'да';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

function Bit2Str(i: byte): string;
begin
  case i of
    0:    Result := 'нет';
    else  Result := 'да';
  end;
end;

function PopBool2Str: string;
begin
  Result := Bool2Str(PopByte);
end;

function PopSwitch2Str: string;
var
  i:  byte;
begin
  i := PopByte();
  case i of
    0:    Result := 'выкл.';
    255:  Result := 'вкл.';
    else  Result := '?';
  end;
  Result := IntToStr(i) + ' - ' + Result;
end;

function PopBits2Str: string;
var
  i:  byte;
begin
  i := PopByte();

  Result := '';
  
  if (i and $80 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $40 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $20 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $10 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $08 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $04 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $02 <> 0) then Result := Result + '1' else Result := Result + '0';
  if (i and $01 <> 0) then Result := Result + '1' else Result := Result + '0';

  Result := IntToHex(i,2) + '  ' + Result;
end;

function PopStr(bSize: byte): string;
var
  i,j:  byte;
  b:    boolean;
begin
  Result := '';
  b := true;
  for i := 1 to bSize do begin
    j := PopByte;
    if j = 0 then b := false;
    if b then Result := Result + AnsiChar(j);
  end;
end;

procedure Query(quT: querys; boRepeat: boolean = false);
var
  i:  word;
begin
  try
    with frmMain,ComPort do begin
      if quT.Action = acGetDevices     then quT.cwIn := 6+bDevices*18+10;
      if quT.Action = acGetGroups      then quT.cwIn := 6+wGroupsCount*162+10;
      if quT.Action = acGetDigitals    then quT.cwIn := 6+GetDigitalsCount*64+10;
      if quT.Action = acGetCanals      then quT.cwIn := 6+wCanalsCount*52+10;
      if quT.Action = acGetPowCanMnt   then quT.cwIn := 6+4*wCanalsCount*updMinutesCount.Position+10;
      if quT.Action = acGetPowGrpMnt   then quT.cwIn := 6+4*wGroupsCount*updMinutesCount.Position+10;
      if quT.Action = acGetPowCanHou   then quT.cwIn := 6+4*wCanalsCount*updHoursCount.Position+10;
      if quT.Action = acGetPowGrpHou   then quT.cwIn := 6+4*wGroupsCount*updHoursCount.Position+10;
      if quT.Action = acGetPowCanHou48 then quT.cwIn := 6+48*4*wCanalsCount+10;
      if quT.Action = acGetPowGrpHou48 then quT.cwIn := 6+48*4*wGroupsCount+10;
      if quT.Action = acGetDefCanDay   then quT.cwIn := 6+(((updCanalsCount.Position-1) div 16)+1)*2*updDaysCount.Position+10;
      if quT.Action = acGetDefGrpDay   then quT.cwIn := 6+(((updGroupsCount.Position-1) div 16)+1)*2*updDaysCount.Position+10;

      if quT.Action = acGetEngCanDay   then quT.cwIn := GetEngCanDay.GetInSize;
      if quT.Action = acGetEngCanDayX2 then quT.cwIn := GetEngCanDayX2.GetInSize;
      if quT.Action = acGetEngGrpDay   then quT.cwIn := GetEngGrpDay.GetInSize;
      if quT.Action = acGetEngGrpDayX2 then quT.cwIn := GetEngGrpDayX2.GetInSize;
      if quT.Action = acGetEngCanMon   then quT.cwIn := GetEngCanMon.GetInSize;
      if quT.Action = acGetEngCanMonX2 then quT.cwIn := GetEngCanMonX2.GetInSize;
      if quT.Action = acGetEngGrpMon   then quT.cwIn := GetEngGrpMon.GetInSize;
      if quT.Action = acGetEngGrpMonX2 then quT.cwIn := GetEngGrpMonX2.GetInSize;

      if quT.Action = acGetMaxCanDay   then quT.cwIn := GetMaxCanDay.GetInSize;
      if quT.Action = acGetMaxGrpDay   then quT.cwIn := GetMaxGrpDay.GetInSize;
      if quT.Action = acGetMaxCanMon   then quT.cwIn := GetMaxCanMon.GetInSize;
      if quT.Action = acGetMaxCanMon0  then quT.cwIn := GetMaxCanMon0.GetInSize;
      if quT.Action = acGetMaxGrpMon   then quT.cwIn := GetMaxGrpMon.GetInSize;
      if quT.Action = acGetMaxGrpMon0  then quT.cwIn := GetMaxGrpMon0.GetInSize;

      if quT.Action = acGetCntCan then quT.cwIn := 6+(6+4)*wCanalsCount+10;
      if quT.Action = acGetCntCanTar then quT.cwIn := 6+(6+4)*wCanalsCount*updTariffsCount.Position+10;
      if quT.Action = acGetCntCanMon then quT.cwIn := GetCntCanMon.GetInSize;
      if quT.Action = acGetCntCanMonTar then quT.cwIn := GetCntCanMonTar.GetInSize;

      if quT.Action = acGetCntCanX2 then quT.cwIn := 6+(6+8)*wCanalsCount+10;
      if quT.Action = acGetCntCanTarX2 then quT.cwIn := 6+(6+8)*wCanalsCount*updTariffsCount.Position+10;
      if quT.Action = acGetCntCanMonX2 then quT.cwIn := GetCntCanMonX2.GetInSize;
      if quT.Action = acGetCntCanMonTarX2 then quT.cwIn := GetCntCanMonTarX2.GetInSize;

      if quT.Action = acGetCurrents1   then quT.cwIn := 6+GetDigitalsCount*GetCurrentsCount*4+10;
      if quT.Action = acGetCurrents2   then quT.cwIn := 6+2+(8+GetCurrentsCount*4)*CURRENTS2_SIZE+10;
      if quT.Action = acGetEventsCount then quT.cwIn := 6+5+updDaysCount.Position*4+10;
      if quT.Action = acGetEventsCount2 then quT.cwIn := 6+5+updDaysCount.Position*4+10;
      if quT.Action = acGetEvents      then quT.cwIn := 6+10+10;
      if quT.Action = acGetEvents2      then quT.cwIn := 6+10+10;
      if quT.Action = acGetEventsMessage then quT.cwIn := 6+2+64+10;

      queQuery := quT;

      InitPushZero;
      PushByte($55);
      PushByte(updAddress.Position);

      PushByte(quT.cwOut div $100);
      PushByte(quT.cwOut mod $100);

      PushByte(quT.wNumber div $100);
      PushByte(quT.wNumber mod $100);

      if not boRepeat then Inc(wLabel);
      mpbOut[quT.cwOut-4] := wLabel div $100;
      mpbOut[quT.cwOut-3] := wLabel mod $100;

      i := CRC16(mpbOut, quT.cwOut-2);
      mpbOut[quT.cwOut-2] := i div $100;
      mpbOut[quT.cwOut-1] := i mod $100;

      with timTimeout do begin
        Enabled  := False;
        Interval := GetTimeout;
        Enabled  := True;
      end;

      if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then begin
        //ComPort.FlushInBuffer;
        //ComPort.FlushOutBuffer;
        ComPort.PutBlock(mpbOut, queQuery.cwOut);
      end
      else begin
        IdTCPClient.IOHandler.Write(IdGlobal.RawToBytes(mpbOut, queQuery.cwOut));
      end;

      ShowOutData(queQuery.cwOut);
      Inc(cwIncTotal);
    end;
  except
    ErrBox('Ошибка при передаче !');
  end;
end;

procedure QueryDirect(s: string; boCRC: boolean);
var
  z: string;
  i,j: word;
  cwOut: word;
  a: TStringDynArray;
begin
  try
    with frmMain,ComPort do begin
      queQuery.Action := acNone;
      queQuery.cwIn := $4000;

      AddTerm('Строка для отправки: ' + s);
      a := SplitString(s, ' ');
      cwOut := Length(a);

      InitPushZero;
      for i := 0 to cwOut - 1 do begin
        z := Trim(a[i]);
        AddTerm('Байт для отправки: ' + z);
        PushByte(StrToInt('$' + z));
      end;

      if boCRC then begin
        AddTerm('Добавление CRC');
        j := CRC16(mpbOut, cwOut);

        AddTerm('Байт для отправки: ' + IntToHex(j div $100, 2));
        PushByte(j div $100);

        AddTerm('Байт для отправки: ' + IntToHex(j mod $100, 2));
        PushByte(j mod $100);

        cwOut := cwOut + 2;
      end;

      if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then begin
        //ComPort.FlushInBuffer;
        //ComPort.FlushOutBuffer;
        ComPort.PutBlock(mpbOut, cwOut);
      end
      else begin
        IdTCPClient.IOHandler.Write(IdGlobal.RawToBytes(mpbOut, cwOut));
      end;

      ShowOutData(cwOut);
    end;
  except
    ErrBox('Ошибка при передаче !');
  end;
end;

end.

