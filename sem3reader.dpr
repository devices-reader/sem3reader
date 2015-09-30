{?}program sem3reader;



uses
  Forms,
  Windows,
  basic in 'basic.pas' {frmBasic},
  main in 'main.pas' {frmMain},
  box in 'box.pas',
  calendar in 'calendar.pas',
  crc in 'crc.pas',
  get_time in 'get_time.pas',
  kernel in 'kernel.pas',
  ports in 'ports.pas',
  progress in 'progress.pas',
  realz in 'realz.pas',
  input in 'input.pas',
  output in 'output.pas',
  support in 'support.pas',
  terminal in 'terminal.pas',
  timez in 'timez.pas',
  ok in 'ok.pas' {frmOK},
  yesno in 'yesno.pas' {frmYesNo},
  get_open in 'get_open.pas',
  get_config in 'get_config.pas',
  get_devices in 'get_devices.pas',
  get_groups in 'get_groups.pas',
  get_digitals in 'get_digitals.pas',
  get_canals in 'get_canals.pas',
  setup2 in 'setup2.pas' {frmSetup2},
  get_open2 in 'get_open2.pas',
  get_time20 in 'get_time20.pas',
  get_time21 in 'get_time21.pas',
  get_time22 in 'get_time22.pas',
  get_setup2 in 'get_setup2.pas',
  get_correction in 'get_correction.pas',
  get_powcanmnt in 'get_powcanmnt.pas',
  borders in 'borders.pas',
  get_powgrpmnt in 'get_powgrpmnt.pas',
  get_powcanhou48 in 'get_powcanhou48.pas',
  profile in 'profile.pas',
  get_powgrphou48 in 'get_powgrphou48.pas',
  get_powcanhou in 'get_powcanhou.pas',
  get_powgrphou in 'get_powgrphou.pas',
  get_defcanday in 'get_defcanday.pas',
  get_defgrpday in 'get_defgrpday.pas',
  get_engcanday in 'get_engcanday.pas',
  get_enggrpday in 'get_enggrpday.pas',
  get_enggrpmon in 'get_enggrpmon.pas',
  get_maxcanday in 'get_maxcanday.pas',
  get_maxgrpday in 'get_maxgrpday.pas',
  get_maxgrpmon in 'get_maxgrpmon.pas',
  get_cntcanmontar in 'get_cntcanmontar.pas',
  get_cntcanmon in 'get_cntcanmon.pas',
  get_cntcantar in 'get_cntcantar.pas',
  get_cntcan in 'get_cntcan.pas',
  get_currents1 in 'get_currents1.pas',
  get_currents2 in 'get_currents2.pas',
  get_transit in 'get_transit.pas',
  get_events_counts in 'get_events_counts.pas',
  get_events in 'get_events.pas',
  get_events_messages in 'get_events_messages.pas',
  pipeline in 'pipeline.pas',
  get in 'get.pas',
  reguest_pipeline2 in 'reguest_pipeline2.pas',
  request_pipeline in 'request_pipeline.pas',
  get_max in 'get_max.pas',
  period in 'period.pas',
  get_eng in 'get_eng.pas',
  get_itmper in 'get_itmper.pas',
  get_itmpertar in 'get_itmpertar.pas',
  get_maxcanmon0 in 'get_maxcanmon0.pas',
  get_maxgrpmon0 in 'get_maxgrpmon0.pas',
  direct in 'direct.pas' {frmDirect},
  get_engcanmon in 'get_engcanmon.pas',
  get_eng_x2 in 'get_eng_x2.pas',
  get_engcanday_x2 in 'get_engcanday_x2.pas',
  get_engcanmon_x2 in 'get_engcanmon_x2.pas',
  get_enggrpday_x2 in 'get_enggrpday_x2.pas',
  get_enggrpmon_x2 in 'get_enggrpmon_x2.pas',
  get_events_counts2 in 'get_events_counts2.pas',
  get_events2 in 'get_events2.pas',
  get_cntcanmon_x2 in 'get_cntcanmon_x2.pas',
  get_cntcan_x2 in 'get_cntcan_x2.pas',
  get_cntcantar_x2 in 'get_cntcantar_x2.pas',
  get_cntcanmontar_x2 in 'get_cntcanmontar_x2.pas';

{$R *.RES}

var
  hMutex: THandle;

begin
  hMutex := CreateMutex(nil, True, 'sem3reader');
  if GetLastError <> 0 then
  begin
    WrnBox('Программа ''sem3reader'' уже запущена !');
    ReleaseMutex(hMutex);
    Exit;
  end;

  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

  ReleaseMutex(hMutex);
  if GetLastError <> 0 then ;
end.
