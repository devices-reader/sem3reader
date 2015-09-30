{?}unit box;

interface

uses SysUtils, AdTapi, timez, get;

type
  actions =
  (
    acGetOpen = 0,
    acGetTime,
    acGetCorrection,
    acGetConfig,
    acGetDevices,
    acGetDigitals,
    acGetCanals,
    acGetGroups,

    acGetPowCanMnt,
    acGetPowGrpMnt,

    acGetPowCanHou,
    acGetPowGrpHou,
    acGetPowCanHou48,
    acGetPowGrpHou48,

    acGetDefCanDay,
    acGetDefGrpDay,

    acGetEngCanDay,
    acGetEngCanDayX2,
    acGetEngGrpDay,
    acGetEngGrpDayX2,
    acGetEngCanMon,
    acGetEngCanMonX2,
    acGetEngGrpMon,
    acGetEngGrpMonX2,

    acGetMaxCanDay,
    acGetMaxGrpDay,
    acGetMaxCanMon,
    acGetMaxGrpMon,

    acGetCntCan,
    acGetCntCanX2,
    acGetCntCanTar,
    acGetCntCanTarX2,
    acGetCntCanMon,
    acGetCntCanMonX2,
    acGetCntCanMonTar,
    acGetCntCanMonTarX2,

    acGetCurrents1,
    acGetCurrents2,

    acGetEventsCount,
    acGetEventsCount2,

    acNone,

    acGetOpen2,
    acGetTime20,
    acGetSetup2,
    acGetTime21,

    acGetTime22,

    acGetTransit,

    acGetEvents,
    acGetEvents2,
    acGetEventsMessage,

    acGetMaxCanMon0,
    acGetMaxGrpMon0,

    acGet8282
  );

  querys = record
    Action:     actions;
    cwOut:      word;
    cwIn:       word;
    wNumber:    word;
  end;

procedure BoxCreate;
procedure BoxInit;
procedure RunBox;
procedure BoxRead;
procedure BoxShow(Action:  actions);

var
  cwConnect:  longword;
  tiCurr:     times;

  GetTime,
  GetEngCanDay,
  GetEngGrpDay,
  GetEngCanMon,
  GetEngGrpMon,
  GetEngCanDayX2,
  GetEngGrpDayX2,
  GetEngCanMonX2,
  GetEngGrpMonX2,
  GetMaxCanDay,
  GetMaxGrpDay,
  GetMaxCanMon,
  GetMaxCanMon0,
  GetMaxGrpMon,
  GetMaxGrpMon0,
  GetCntCanMon,
  GetCntCanMonTar,
  GetCntCanMonX2,
  GetCntCanMonTarX2
  : TGet;

implementation

uses main, support, output, progress,
get_open, get_time, get_correction, get_config, get_devices, get_digitals, get_canals, get_groups,
get_open2, get_time20, get_setup2, get_time21, get_time22,
get_powcanmnt, get_powgrpmnt,
get_powcanhou, get_powgrphou, get_powcanhou48, get_powgrphou48,
get_defcanday, get_defgrpday,
get_engcanday, get_enggrpday, get_engcanmon, get_enggrpmon,
get_engcanday_x2, get_enggrpday_x2, get_engcanmon_x2, get_enggrpmon_x2,
get_maxcanday, get_maxgrpday, get_maxcanmon, get_maxcanmon0, get_maxgrpmon, get_maxgrpmon0,
get_cntcan, get_cntcantar, get_cntcanmon, get_cntcanmontar,
get_cntcan_x2, get_cntcantar_x2, get_cntcanmon_x2, get_cntcanmontar_x2,
get_currents1, get_currents2,
get_transit, 
get_events_counts, get_events, get_events_messages, get_events_counts2, get_events2
;

var
  BoxStart:     TDateTime;
  iwBox:        word;

procedure BoxInit;
begin
  GetTime := TGetTime.Create;

  GetEngCanDay := TGetEngCanDay.Create;
  GetEngGrpDay := TGetEngGrpDay.Create;
  GetEngCanMon := TGetEngCanMon.Create;
  GetEngGrpMon := TGetEngGrpMon.Create;

  GetEngCanDayX2 := TGetEngCanDayX2.Create;
  GetEngGrpDayX2 := TGetEngGrpDayX2.Create;
  GetEngCanMonX2 := TGetEngCanMonX2.Create;
  GetEngGrpMonX2 := TGetEngGrpMonX2.Create;

  GetMaxCanDay := TGetMaxCanDay.Create;
  GetMaxGrpDay := TGetMaxGrpDay.Create;
  GetMaxCanMon := TGetMaxCanMon.Create;
  GetMaxCanMon0 := TGetMaxCanMon0.Create;
  GetMaxGrpMon := TGetMaxGrpMon.Create;
  GetMaxGrpMon0 := TGetMaxGrpMon0.Create;

  GetCntCanMon := TGetCntCanMon.Create;
  GetCntCanMonTar := TGetCntCanMonTar.Create;

  GetCntCanMonX2 := TGetCntCanMonX2.Create;
  GetCntCanMonTarX2 := TGetCntCanMonTarX2.Create;
end;

procedure BoxCreate;
var
  i:  word;
begin
  BoxInit;

  with frmMain.clbMain do begin
    for i := 1 to Ord(acNone) do Items.Add('?');

    Items[Ord(acGetOpen)]          := InfoGetOpen;
    Items[Ord(acGetTime)]          := GetTime.GetInfo;
    Items[Ord(acGetCorrection)]    := InfoGetCorrection;
    Items[Ord(acGetConfig)]        := InfoGetConfig;
    Items[Ord(acGetDevices)]       := InfoGetDevices;
    Items[Ord(acGetDigitals)]      := InfoGetDigitals;
    Items[Ord(acGetCanals)]        := InfoGetCanals;
    Items[Ord(acGetGroups)]        := InfoGetGroups;

    Items[Ord(acGetPowCanMnt)]     := InfoGetPowCanMnt;
    Items[Ord(acGetPowGrpMnt)]     := InfoGetPowGrpMnt;

    Items[Ord(acGetPowCanHou)]     := InfoGetPowCanHou;
    Items[Ord(acGetPowGrpHou)]     := InfoGetPowGrpHou;
    Items[Ord(acGetPowCanHou48)]   := InfoGetPowCanHou48;
    Items[Ord(acGetPowGrpHou48)]   := InfoGetPowGrpHou48;

    Items[Ord(acGetDefCanDay)]     := InfoGetDefCanDay;
    Items[Ord(acGetDefGrpDay)]     := InfoGetDefGrpDay;

    Items[Ord(acGetEngCanDay)]     := GetEngCanDay.GetInfo;
    Items[Ord(acGetEngGrpDay)]     := GetEngGrpDay.GetInfo;
    Items[Ord(acGetEngCanMon)]     := GetEngCanMon.GetInfo;
    Items[Ord(acGetEngGrpMon)]     := GetEngGrpMon.GetInfo;

    Items[Ord(acGetEngCanDayX2)]   := GetEngCanDayX2.GetInfo;
    Items[Ord(acGetEngGrpDayX2)]   := GetEngGrpDayX2.GetInfo;
    Items[Ord(acGetEngCanMonX2)]   := GetEngCanMonX2.GetInfo;
    Items[Ord(acGetEngGrpMonX2)]   := GetEngGrpMonX2.GetInfo;

    Items[Ord(acGetMaxCanDay)]     := GetMaxCanDay.GetInfo;
    Items[Ord(acGetMaxGrpDay)]     := GetMaxGrpDay.GetInfo;
    Items[Ord(acGetMaxCanMon)]     := GetMaxCanMon.GetInfo;
    Items[Ord(acGetMaxGrpMon)]     := GetMaxGrpMon.GetInfo;

    Items[Ord(acGetCntCan)]        := InfoGetCntCan;
    Items[Ord(acGetCntCanTar)]     := InfoGetCntCanTar;
    Items[Ord(acGetCntCanMon)]     := GetCntCanMon.GetInfo;
    Items[Ord(acGetCntCanMonTar)]  := GetCntCanMonTar.GetInfo;

    Items[Ord(acGetCntCanX2)]        := InfoGetCntCanX2;
    Items[Ord(acGetCntCanTarX2)]     := InfoGetCntCanTarX2;
    Items[Ord(acGetCntCanMonX2)]     := GetCntCanMonX2.GetInfo;
    Items[Ord(acGetCntCanMonTarX2)]  := GetCntCanMonTarX2.GetInfo;

    Items[Ord(acGetCurrents1)]     := InfoGetCurrents1;
    Items[Ord(acGetCurrents2)]     := InfoGetCurrents2;

    Items[Ord(acGetEventsCount)]   := InfoGetEventsCounts;
    Items[Ord(acGetEventsCount2)]  := InfoGetEventsCounts2;

    for i := 1 to Ord(acNone) do Items.Strings[i-1] := Items.Strings[i-1];
  end;

//  InitGetRecords;
end;

procedure RunBox;
var
  b:  boolean;
begin
 with frmMain do begin
  with clbMain do  while (iwBox < Items.Count) do begin
    if Checked[iwBox] then begin
      case iwBox of
        Ord(acGetOpen):       begin BoxGetOpen;       Inc(iwBox); exit; end;
        Ord(acGetTIME):       begin GetTime.Run;      Inc(iwBox); exit; end;
        Ord(acGetCorrection): begin BoxGetCorrection; Inc(iwBox); exit; end;
        Ord(acGetConfig):     begin BoxGetConfig;     Inc(iwBox); exit; end;
        Ord(acGetDevices):    begin BoxGetDevices;    Inc(iwBox); exit; end;
        Ord(acGetDigitals):   begin BoxGetDigitals;   Inc(iwBox); exit; end;
        Ord(acGetCanals):     begin BoxGetCanals;     Inc(iwBox); exit; end;
        Ord(acGetGroups):     begin BoxGetGroups;     Inc(iwBox); exit; end;

        Ord(acGetPowCanMnt):  begin BoxGetPowCanMnt;  Inc(iwBox); exit; end;
        Ord(acGetPowGrpMnt):  begin BoxGetPowGrpMnt;  Inc(iwBox); exit; end;

        Ord(acGetPowCanHou):  begin BoxGetPowCanHou;  Inc(iwBox); exit; end;
        Ord(acGetPowGrpHou):  begin BoxGetPowGrpHou;  Inc(iwBox); exit; end;
        Ord(acGetPowCanHou48):  begin BoxGetPowCanHou48;  Inc(iwBox); exit; end;
        Ord(acGetPowGrpHou48):  begin BoxGetPowGrpHou48;  Inc(iwBox); exit; end;

        Ord(acGetDefCanDay):  begin BoxGetDefCanDay;  Inc(iwBox); exit; end;
        Ord(acGetDefGrpDay):  begin BoxGetDefGrpDay;  Inc(iwBox); exit; end;

        Ord(acGetEngCanDay):  begin GetEngCanDay.Run; Inc(iwBox); exit; end;
        Ord(acGetEngGrpDay):  begin GetEngGrpDay.Run; Inc(iwBox); exit; end;
        Ord(acGetEngCanMon):  begin GetEngCanMon.Run; Inc(iwBox); exit; end;
        Ord(acGetEngGrpMon):  begin GetEngGrpMon.Run; Inc(iwBox); exit; end;

        Ord(acGetEngCanDayX2):  begin GetEngCanDayX2.Run; Inc(iwBox); exit; end;
        Ord(acGetEngGrpDayX2):  begin GetEngGrpDayX2.Run; Inc(iwBox); exit; end;
        Ord(acGetEngCanMonX2):  begin GetEngCanMonX2.Run; Inc(iwBox); exit; end;
        Ord(acGetEngGrpMonX2):  begin GetEngGrpMonX2.Run; Inc(iwBox); exit; end;

        Ord(acGetMaxCanDay):  begin GetMaxCanDay.Run; Inc(iwBox); exit; end;
        Ord(acGetMaxGrpDay):  begin GetMaxGrpDay.Run; Inc(iwBox); exit; end;
        Ord(acGetMaxCanMon):  begin GetMaxCanMon.Run; Inc(iwBox); exit; end;
        Ord(acGetMaxGrpMon):  begin GetMaxGrpMon.Run; Inc(iwBox); exit; end;

        Ord(acGetCntCan):        begin BoxGetCntCan;        Inc(iwBox); exit; end;
        Ord(acGetCntCanTar):     begin BoxGetCntCanTar;     Inc(iwBox); exit; end;
        Ord(acGetCntCanMon):     begin GetCntCanMon.Run;    Inc(iwBox); exit; end;
        Ord(acGetCntCanMonTar):  begin GetCntCanMonTar.Run; Inc(iwBox); exit; end;

        Ord(acGetCntCanX2):        begin BoxGetCntCanX2;        Inc(iwBox); exit; end;
        Ord(acGetCntCanTarX2):     begin BoxGetCntCanTarX2;     Inc(iwBox); exit; end;
        Ord(acGetCntCanMonX2):     begin GetCntCanMonX2.Run;    Inc(iwBox); exit; end;
        Ord(acGetCntCanMonTarX2):  begin GetCntCanMonTarX2.Run; Inc(iwBox); exit; end;

        Ord(acGetCurrents1):  begin BoxGetCurrents1;  Inc(iwBox); exit; end;
        Ord(acGetCurrents2):  begin BoxGetCurrents2;  Inc(iwBox); exit; end;

        Ord(acGetEventsCount):   begin BoxGetEventsCounts;   Inc(iwBox); exit; end;
        Ord(acGetEventsCount2):  begin BoxGetEventsCounts2;  Inc(iwBox); exit; end;

        else ErrBox('Ошибка при задании списка запросов !');
      end;
    end;
    Inc(iwBox);
  end;

    AddInfo('');
    AddInfo('');
    AddInfo('начало опроса: '+Times2Str(ToTimes(BoxStart)));
    AddInfo('конец опроса:  '+Times2Str(ToTimes(Now)));
    AddInfo(DeltaTimes2Str(ToTimes(BoxStart),ToTimes(Now)));
{
    b := False;
    if (TapiDevice.TapiState = tsConnected) and (chbCancelCall.Checked) then begin
      b := True;
      btbCancelCallClick(nil);
    end;

    if b then begin
      AddInfo(' ');
      AddInfo('Cоединение: ' + IntToStr(timNow.Interval * cwConnect div 1000) + ' секунд');
    end;
}
    AddInfo(' ');
    AddInfo('Опрос успешно завершен: '+mitVersion.Caption);

    ShowProgress(-1, 1);
  end;
end;

procedure BoxRead;
begin
  with frmMain do begin
    with clbMain do begin

      if Checked[Ord(acGetCorrection)] or
         Checked[Ord(acGetEventsCount)]
      then begin
        Checked[Ord(acGetTime)] := True;
      end;

      if Checked[Ord(acGetCanals)] or
         Checked[Ord(acGetCurrents1)] or
         Checked[Ord(acGetCurrents2)]
      then begin
        Checked[Ord(acGetDigitals)] := True;
      end;

      if Checked[Ord(acGetDigitals)]
      then begin
        Checked[Ord(acGetDevices)] := True;
      end;

      if Checked[Ord(acGetDevices)] or
         Checked[Ord(acGetGroups)]
      then begin
        Checked[Ord(acGetConfig)] := True;
      end;

      if Checked[Ord(acGetPowCanMnt)] or
         Checked[Ord(acGetPowGrpMnt)] or
         Checked[Ord(acGetPowCanHou)] or
         Checked[Ord(acGetPowGrpHou)] or
         Checked[Ord(acGetPowCanHou48)] or
         Checked[Ord(acGetPowGrpHou48)] or

         Checked[Ord(acGetDefCanDay)] or
         Checked[Ord(acGetDefGrpDay)] or

         Checked[Ord(acGetEngCanDay)] or
         Checked[Ord(acGetEngGrpDay)] or
         Checked[Ord(acGetEngCanMon)] or
         Checked[Ord(acGetEngGrpMon)] or

         Checked[Ord(acGetEngCanDayX2)] or
         Checked[Ord(acGetEngGrpDayX2)] or
         Checked[Ord(acGetEngCanMonX2)] or
         Checked[Ord(acGetEngGrpMonX2)] or

         Checked[Ord(acGetMaxCanDay)] or
         Checked[Ord(acGetMaxGrpDay)] or
         Checked[Ord(acGetMaxCanMon)] or
         Checked[Ord(acGetMaxGrpMon)] or

         Checked[Ord(acGetCntCan)] or
         Checked[Ord(acGetCntCanTar)] or
         Checked[Ord(acGetCntCanMon)] or
         Checked[Ord(acGetCntCanMonTar)] or

         Checked[Ord(acGetCntCanX2)] or
         Checked[Ord(acGetCntCanTarX2)] or
         Checked[Ord(acGetCntCanMonX2)] or
         Checked[Ord(acGetCntCanMonTarX2)]
      then begin
        Checked[Ord(acGetTime)] := True;
        Checked[Ord(acGetConfig)] := True;
      end;

  end;

  BoxStart := Now;
//  NormalMode;

  iwBox := 0;
  ShowProgress(-1, 1);
  BoxInit;
  RunBox;
  end;
end;

procedure BoxShow(Action: actions);
begin


    case Action of

      acGetOpen:     ShowGetOpen;
      acGetTime:     GetTime.Show;
      acGetCorrection:     ShowGetCorrection;
      acGetConfig:   ShowGetConfig;
      acGetDevices:  ShowGetDevices;
      acGetDigitals: ShowGetDigitals;
      acGetCanals:   ShowGetCanals;
      acGetGroups:   ShowGetGroups;

      acGetPowCanMnt:   ShowGetPowCanMnt;
      acGetPowGrpMnt:   ShowGetPowGrpMnt;

      acGetPowCanHou:   ShowGetPowCanHou;
      acGetPowGrpHou:   ShowGetPowGrpHou;
      acGetPowCanHou48: ShowGetPowCanHou48;
      acGetPowGrpHou48: ShowGetPowGrpHou48;

      acGetDefCanDay:   ShowGetDefCanDay;
      acGetDefGrpDay:   ShowGetDefGrpDay;

      acGetEngCanDay:   GetEngCanDay.Show;
      acGetEngGrpDay:   GetEngGrpDay.Show;
      acGetEngCanMon:   GetEngCanMon.Show;
      acGetEngGrpMon:   GetEngGrpMon.Show;

      acGetEngCanDayX2: GetEngCanDayX2.Show;
      acGetEngGrpDayX2: GetEngGrpDayX2.Show;
      acGetEngCanMonX2: GetEngCanMonX2.Show;
      acGetEngGrpMonX2: GetEngGrpMonX2.Show;

      acGetMaxCanDay:   GetMaxCanDay.Show;
      acGetMaxGrpDay:   GetMaxGrpDay.Show;
      acGetMaxCanMon:   GetMaxCanMon.Show;
      acGetMaxCanMon0:  GetMaxCanMon0.Show;
      acGetMaxGrpMon:   GetMaxGrpMon.Show;
      acGetMaxGrpMon0:  GetMaxGrpMon0.Show;

      acGetCntCan:      ShowGetCntCan;
      acGetCntCanTar:   ShowGetCntCanTar;
      acGetCntCanMon:   GetCntCanMon.Show;
      acGetCntCanMonTar:GetCntCanMonTar.Show;

      acGetCntCanX2:      ShowGetCntCanX2;
      acGetCntCanTarX2:   ShowGetCntCanTarX2;
      acGetCntCanMonX2:   GetCntCanMonX2.Show;
      acGetCntCanMonTarX2:GetCntCanMonTarX2.Show;

      acGetCurrents1:   ShowGetCurrents1;
      acGetCurrents2:   ShowGetCurrents2;

      acGetEventsCount:   ShowGetEventsCounts;
      acGetEvents:        ShowGetEvents;
      acGetEventsMessage: ShowGetEventsMessages;

      acGetEventsCount2:  ShowGetEventsCounts2;
      acGetEvents2:       ShowGetEvents2;

      acGetOpen2:       ShowGetOpen2;
      acGetTime20:      ShowGetTime20;
      acGetSetup2:      ShowGetSetup2;
      acGetTime21:      ShowGetTime21;

      acGetTime22:      ShowGetTime22;

      acGetTransit:     ShowGetTransit;
    end;
end;

end.
