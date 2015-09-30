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
    0: Result := '���������� ����������';
    1: Result := '�������� ������';
    2: Result := '������ �� ������';
    3: Result := '������� �� ��������������';
    4: Result := '���������� �������� ������';
    5: Result := '���������� ������';
    6: Result := '������ ������';
    7: Result := '������ �� ������: �������� ������';
    8: Result := '������������ ���������';
    9: Result := '������� ������';
    10: Result := '������� ����������: ���������� ������';
    11: Result := '����������� ������ �� ����������';
    12: Result := '������������ ��������� ������';
    13: Result := '���������� ��������������� �����: ������� ����� ������� ��������';
    14: Result := '���������� ��������������� �����: ������� ������� ������';

    $fc: Result := '���������� ��������� � ������ ���������������';
    $fd: Result := '���������� ������';
    $fe: Result := '���������� ������';
    $ff: Result := '���������� ������: ���������� ����� ������ �������';

    else Result := '����������� ������: ��� '+IntToStr(bT);
  end;
end;

function MultiBox(wSize: word): boolean;
begin
  Result := False;

  if wSize = 16 then begin
    if (mpbIn[6] = 0) then begin
      Stop;
      InfBox('�������� ��������� �������');
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
 ErrBox('������������ ����� ������: ' +
         IntToStr(wSize1) + ' ������ ' + IntToStr(wSize2) + ' ����');
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
       AddInfo('�������������: ' + Int2Str(bHour) + ':' + Int2Str(bMinute) + ' ' + Int2Str(bDay) + '.' + Int2Str(bMonth) + '.' + Int2Str(bYear) + '; ' + GetErrorMessage(mpbIn[cwIn-10]));
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
     AddTerminal('// ������� � �����: ' + IntToStr(wSize) + ' ����',clGray);
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
       AddInfo('��� ������ �� ����������, ������: ' + IntToStr(cbCurRepeat) + ' �� ' + IntToStr(cbMaxRepeat));
       Query(queQuery, true);
    end
    else if (CRC16(mpbIn,wSize) <> 0) and (cbCurRepeat < cbMaxRepeat) then begin
      Inc(cbCurRepeat);
      Inc(cbIncRepeat); ShowRepeat;

      if Sem3 and (queQuery.Action = acGetMaxCanMon) then begin
        AddTerm('������ ����������� �����, ������ �� ��������������');
        Delay(updTimeoutPort.Position);
        ComPort.GetBlock(mpbIn, wSize);
        DeleteInfo(9);
        GetMaxCanMon0.Run;
      end
      else if Sem3 and (queQuery.Action = acGetMaxGrpMon) then begin
        AddTerm('������ ����������� �����, ������ �� ��������������');
        Delay(updTimeoutPort.Position);
        ComPort.GetBlock(mpbIn, wSize);
        DeleteInfo(9);
        GetMaxGrpMon0.Run;
      end
      else begin
        AddInfo('������ ����������� �����, ������: ' + IntToStr(cbCurRepeat) + ' �� ' + IntToStr(cbMaxRepeat));
        Query(queQuery, true);
      end;
    end

    else begin
      if wSize = 0 then ErrBox('��� ������ �� ���������� !')
      else
      if (CRC16(mpbIn,wSize) <> 0) then ErrBox('������ ����������� ����� !')
      else
      if (mpbIn[wSize-4]*$100 + mpbIn[wSize-3] <> wLabel) then ErrBox('������ ���� ������� !')
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
     AddTerminal('// ������� � ������: ' + IntToStr(wSize) + ' ����',clGray);

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
       AddInfo('��� ������ �� ����������, ������: ' + IntToStr(cbCurRepeat) + ' �� ' + IntToStr(cbMaxRepeat));
       Query(queQuery, true);
    end
    else if (CRC16(mpbIn,wSize) <> 0) and (cbCurRepeat < cbMaxRepeat) then begin
      Inc(cbCurRepeat);
      Inc(cbIncRepeat); ShowRepeat;

      if Sem3 and (queQuery.Action = acGetMaxCanMon) then begin
        AddTerm('������ ����������� �����, ������ �� ��������������');
        Delay(updTimeoutSocket.Position);
        // ClientSocket.Socket.ReceiveBuf(mpbIn, wSize);
        DeleteInfo(9);
        GetMaxCanMon0.Run;
      end
      else if Sem3 and (queQuery.Action = acGetMaxGrpMon) then begin
        AddTerm('������ ����������� �����, ������ �� ��������������');
        Delay(updTimeoutSocket.Position);
        // ClientSocket.Socket.ReceiveBuf(mpbIn, wSize);
        DeleteInfo(9);
        GetMaxGrpMon0.Run;
      end
      else begin
        AddInfo('������ ����������� �����, ������: ' + IntToStr(cbCurRepeat) + ' �� ' + IntToStr(cbMaxRepeat));
        Query(queQuery, true);
      end;
    end

    else begin
      if wSize = 0 then ErrBox('��� ������ �� ���������� !')
      else
      if (CRC16(mpbIn,wSize) <> 0) then ErrBox('������ ����������� ����� !')
      else
      if (mpbIn[wSize-4]*$100 + mpbIn[wSize-3] <> wLabel) then ErrBox('������ ���� ������� !')
      else
      if not MultiBox(wSize) then OtherActionsCRC(wSize);
    end;
  end;
end;

end.
