unit get_currents1;

interface

function InfoGetCurrents1: string;
procedure BoxGetCurrents1;
procedure ShowGetCurrents1;

implementation

uses SysUtils, output, support, box, kernel, main, progress, borders, realz, get_devices, get_digitals;

const
  quGetCurrents1: querys = (Action: acGetCurrents1; cwOut: 6 + 14 + 4; cwIn: 0; wNumber: $F1);

var
  cwInterval:       word;

function InfoGetCurrents1: string;
begin
  Result := 'Мгновенные параметры №1';
end;

procedure QueryGetCurrents1;
begin
  with frmMain do begin
    InitPush(6);
    PushInt(GetDigitalsMin);
    PushInt(GetDigitalsCount);
    PushInt(updIntervalMin.Position + cwInterval);
    PushCurrentsMask;
    Query(quGetCurrents1);

    AddInfo('');
  end;
end;

procedure BoxGetCurrents1;
begin
  if TestCurrents then begin
    cwInterval := 0;

    AddInfo('');
    AddInfo('');
    AddInfo(InfoGetCurrents1);
    AddInfo('');
    QueryGetCurrents1;
  end;
end;

procedure ShowGetCurrents1;
var
  i: byte;
  d: word;
  s: string;
begin
  Stop;
  InitPop(6);

  with frmMain do begin
    s := 'интервал -' + IntToStr(cwInterval);
    AddInfo(s);
    AddInfo('');

    for d := GetDigitalsMin to GetDigitalsMin+GetDigitalsCount-1 do begin
      s := PackStrR('устройство ' + IntToStr(d), GetColWidth);
      s := s + Trim(mpDevices[mpDigitals[d].iwDevice]);
      s := s + ' №' + IntToStr(mpDigitals[d].wNumber);
      AddInfo(s);

      for i := 0 to CURRENTS_COUNT-1 do begin
        if clbCurrents.Checked[i] then begin
          s := PackStrR(clbCurrents.Items.Strings[i], GetColWidth);
          s := s + FloatRaw2StrR(PopFloatRaw);
          AddInfo(s);
        end;
      end;
      AddInfo('');
    end;

    ShowProgress(cwInterval, updIntervalCount.Position);
    Inc(cwInterval);

    if (cwInterval < updIntervalCount.Position) then
      QueryGetCurrents1
    else
      RunBox;
  end;
end;

end.
