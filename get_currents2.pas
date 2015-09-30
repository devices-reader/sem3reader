unit get_currents2;

interface

const
  CURRENTS2_SIZE = 2;

function InfoGetCurrents2: string;
procedure BoxGetCurrents2;
procedure ShowGetCurrents2;

implementation

uses SysUtils, output, support, box, kernel, main, progress, borders, realz, timez, get_devices, get_digitals;

const
  quGetCurrents2: querys = (Action: acGetCurrents2; cwOut: 6 + 12 + 4; cwIn: 0; wNumber: $80F1);

var
  cwInterval:       word;

function InfoGetCurrents2: string;
begin
  Result := 'Мгновенные параметры №2';
end;


procedure QueryGetCurrents2;
begin
  with frmMain do begin
    InitPush(6);
    PushInt(updIntervalMin.Position + cwInterval);
    PushInt(CURRENTS2_SIZE);
    PushCurrentsMask;
    Query(quGetCurrents2);

    AddInfo('');
  end;
end;

procedure BoxGetCurrents2;
begin
  if TestCurrents then begin
    cwInterval := 1;

    AddInfo('');
    AddInfo('');
    AddInfo(InfoGetCurrents2);
    AddInfo('');
    QueryGetCurrents2;
  end;
end;

procedure ShowGetCurrents2;
var
  i,j: byte;
  t: word;
  d: word;
  s: string;
begin
  Stop;
  InitPop(6);

  t := PopInt();
  if (cwInterval = 1) then begin
    AddInfo(PackStrR('Всего записей', GetColWidth) + IntToStr(t));
    AddInfo('');
  end;

  with frmMain do begin
    for j := 1 to CURRENTS2_SIZE do begin

      d := PopInt();
      s := PackStrR('устройство ' + IntToStr(d), GetColWidth);
      s := s + Trim(mpDevices[mpDigitals[d].iwDevice]);
      s := s + ' №' + IntToStr(mpDigitals[d].wNumber);
      AddInfo(s);
      AddInfo(PackStrR('время', GetColWidth) + PopTimes2Str);

        for i := 0 to CURRENTS_COUNT-1 do begin
          if clbCurrents.Checked[i] then begin
            s := PackStrR(clbCurrents.Items.Strings[i], GetColWidth);
            s := s + FloatRaw2StrR(PopFloatRaw);
            AddInfo(s);
          end;
        end;

        ShowProgress(cwInterval-1, updIntervalCount.Position);
        Inc(cwInterval);
    end;

    if (cwInterval-1 < updIntervalCount.Position) then
      QueryGetCurrents2
    else
      RunBox;
  end;
end;

end.
