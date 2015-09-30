unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  basic, ComCtrls, ToolWin, StdCtrls, IniFiles, ExtCtrls, Math,
  Buttons, Mask, Grids, Menus, FileCtrl, OoMisc, AdPort, ImgList, CheckLst,
  AdTapi, AdTStat, System.Win.ScktComp, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdGlobal;

type
  TfrmMain = class(TfrmBasic)
    ComPort: TApdComPort;
    timTimeout: TTimer;
    timNow: TTimer;
    sd_RichToFile: TSaveDialog;
    stbMain: TStatusBar;
    panClient: TPanel;
    TapiDevice: TApdTapiDevice;
    TapiLog: TApdTapiLog;
    pgcMain: TPageControl;
    tbsFirst: TTabSheet;
    tbsLast: TTabSheet;
    panTop3: TPanel;
    panRight3: TPanel;
    btbClearTerminal: TBitBtn;
    btbSaveTerminal: TBitBtn;
    chbTerminal: TCheckBox;
    lblDevice: TLabel;
    lblAddress: TLabel;
    edtAddress: TEdit;
    updAddress: TUpDown;
    tbsParams: TTabSheet;
    panBottom2: TPanel;
    panRigth2: TPanel;
    btbCrealInfo: TBitBtn;
    btbSaveInfo: TBitBtn;
    btbStopInfo: TBitBtn;
    btbStopTerminal: TBitBtn;
    prbMain: TProgressBar;
    clbMain: TCheckListBox;
    panClient2: TPanel;
    memInfo: TMemo;
    ppmMain: TPopupMenu;
    mitVersion: TMenuItem;
    ppmList: TPopupMenu;
    mitSetItems: TMenuItem;
    mitClearItems: TMenuItem;
    splMain: TSplitter;
    lblColWidth: TLabel;
    lblDigits: TLabel;
    edtColWidth: TEdit;
    updColWidth: TUpDown;
    edtDigits: TEdit;
    updDigits: TUpDown;
    lblSetting: TLabel;
    redTerminal: TMemo;
    pgcTop2: TPageControl;
    chbBulk: TCheckBox;
    lblDevicePass: TLabel;
    medDevicePass: TMaskEdit;
    pgcParams: TPageControl;
    tbsParamsRead: TTabSheet;
    tbsParamsWrite: TTabSheet;
    btbCorrectTime: TBitBtn;
    btbSetTime: TBitBtn;
    tbsMain: TTabSheet;
    clbCurrents: TCheckListBox;
    edtlblIntervalCMin: TEdit;
    updIntervalMin: TUpDown;
    edtIntervalCCount: TEdit;
    updIntervalCount: TUpDown;
    lblIntervalC: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblDigitalsMin: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    lblDigitalsCount: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    edtMinutesMin: TEdit;
    updMinutesMin: TUpDown;
    updHoursMin: TUpDown;
    edtHoursMin: TEdit;
    edtDaysMin: TEdit;
    updDaysMin: TUpDown;
    updMonthsMin: TUpDown;
    edtMonthsMin: TEdit;
    edtMonthsCount: TEdit;
    updMonthsCount: TUpDown;
    updDaysCount: TUpDown;
    edtDaysCount: TEdit;
    edtHoursCount: TEdit;
    updHoursCount: TUpDown;
    updMinutesCount: TUpDown;
    edtMinutesCount: TEdit;
    edtDigitalsMin: TEdit;
    updDigitalsMin: TUpDown;
    updTariffsMin: TUpDown;
    edtTariffsMin: TEdit;
    edtGroupsMin: TEdit;
    updGroupsMin: TUpDown;
    updCanalsMin: TUpDown;
    edtCanalsMin: TEdit;
    edtCanalsCount: TEdit;
    updCanalsCount: TUpDown;
    updGroupsCount: TUpDown;
    edtGroupsCount: TEdit;
    edtTariffsCount: TEdit;
    updTariffsCount: TUpDown;
    updDigitalsCount: TUpDown;
    edtDigitalsCount: TEdit;
    btbRun: TBitBtn;
    chbDigitals: TCheckBox;
    ppmCurrents: TPopupMenu;
    mniSetCurrents: TMenuItem;
    mniClearCurrents: TMenuItem;
    updTransitDevice: TUpDown;
    edtTransitDevice: TEdit;
    btbTransit: TBitBtn;
    lblTransitDevice: TLabel;
    lblTransitTimeout: TLabel;
    edtTransitTimeout: TEdit;
    updTransitTimeout: TUpDown;
    cmbJournal: TComboBox;
    lbllJournal: TLabel;
    panTAPI: TPanel;
    memDial: TMemo;
    pgcMode: TPageControl;
    tbsPort: TTabSheet;
    tbsModem: TTabSheet;
    lblSelectedDevice: TLabel;
    lblTimeoutModem: TLabel;
    btbSelectDevice: TBitBtn;
    btbShowConfigDialog: TBitBtn;
    btbDial: TBitBtn;
    btbCancelCall: TBitBtn;
    edtDial: TEdit;
    edtTimeoutModem: TEdit;
    updTimeoutModem: TUpDown;
    tbsSocket: TTabSheet;
    lblTimeoutSocket: TLabel;
    lblSocketHost: TLabel;
    lblSocketPort: TLabel;
    btbSocketOpen: TBitBtn;
    edtSocketHost: TEdit;
    btbSocketClose: TBitBtn;
    edtSocketPort: TEdit;
    edtTimeoutSocket: TEdit;
    updTimeoutSocket: TUpDown;
    lblComNumber: TLabel;
    cmbComNumber: TComboBox;
    lblBaud: TLabel;
    cmbBaud: TComboBox;
    lblParity: TLabel;
    cmbParity: TComboBox;
    lblTimeoutPort: TLabel;
    edtTimeoutPort: TEdit;
    updTimeoutPort: TUpDown;
    btbDirect: TBitBtn;
    IdTCPClient: TIdTCPClient;
    procedure ShowConnect;
    procedure SetBaud(dwBaud: longword);
    procedure SetComNumber(wComNumber: word);
    procedure cmbComNumberChange(Sender: TObject);
    procedure cmbBaudChange(Sender: TObject);
    procedure SetParity(ibParity: byte);
    function GetParity: byte;
    function GetParityStr: string;
    function GetTimeout: word;
    procedure FormShow(Sender: TObject);
    procedure ComPortTriggerAvail(CP: TObject; Count: Word);
    procedure timTimeoutTimer(Sender: TObject);
    procedure timNowTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cmbParityChange(Sender: TObject);
    procedure FocusTerminal;
    procedure ClearTerminal;
    procedure AddTerminal(stT: string; clOut: TColor);
    procedure AddTerminalTime(stT: string; clOut: TColor);
    procedure ComTerminal(stT: string);
    procedure AddInfo(stT: string);
    procedure AddInfoAll(stT: TStrings);
    procedure ClearInfo;
    procedure ClearDial;
    procedure AddDial(stT: string);
    procedure ShowSelectedDevice;
    procedure TAPIoff;
    procedure TAPIon;
    procedure TapiDeviceTapiStatus(CP: TObject; First, Last: Boolean;
      Device, Message, Param1, Param2, Param3: Integer);
    procedure TapiDeviceTapiLog(CP: TObject; Log: TTapiLogCode);
    procedure TapiDeviceTapiPortOpen(Sender: TObject);
    procedure TapiDeviceTapiPortClose(Sender: TObject);
    procedure TapiDeviceTapiConnect(Sender: TObject);
    procedure TapiDeviceTapiFail(Sender: TObject);
    procedure btbClearTerminalClick(Sender: TObject);
    procedure btbSelectDeviceClick(Sender: TObject);
    procedure btbShowConfigDialogClick(Sender: TObject);
    procedure btbDialClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btbCancelCallClick(Sender: TObject);
    procedure btbStopInfoClick(Sender: TObject);
    procedure btbSaveTerminalClick(Sender: TObject);
    procedure SaveRich(Rich: TRichEdit; stName: string);
    procedure SaveMemo(Memo: TMemo; stName: string);
    procedure SaveLog(Memo: TMemo; stName: string);
    procedure ShowRepeat;
    procedure btbCrealInfoClick(Sender: TObject);
    procedure btbSaveInfoClick(Sender: TObject);
    procedure btbRunClick(Sender: TObject);
    procedure mitSetItemsClick(Sender: TObject);
    procedure mitClearItesClick(Sender: TObject);
    procedure clbMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure stbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure pgcParamsChange(Sender: TObject);
    procedure btbSetTimeClick(Sender: TObject);
    procedure btbCorrectTimeClick(Sender: TObject);
    procedure mniSetCurrentsClick(Sender: TObject);
    procedure mniClearCurrentsClick(Sender: TObject);
    procedure ShowDigitals(Flag: boolean);
    procedure chbDigitalsClick(Sender: TObject);
    procedure btbTransitClick(Sender: TObject);
    procedure IdTCPClientAfterBind(Sender: TObject);
    procedure IdTCPClientBeforeBind(Sender: TObject);
    procedure IdTCPClientSocketAllocated(Sender: TObject);
    procedure IdTCPClientConnected(Sender: TObject);
    procedure IdTCPClientDisconnected(Sender: TObject);
    procedure IdTCPClientStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    procedure IdTCPClientWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure IdTCPClientWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure IdTCPClientWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure pgcModeChange(Sender: TObject);
    procedure btbSocketOpenClick(Sender: TObject);
    procedure btbSocketCloseClick(Sender: TObject);
    procedure btbDirectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSocketInputThread = class(TThread)
  private
    sBuff:    string;
    sCurr:    string;
    procedure HandleInput;
  protected
    procedure Execute; override;
  public
    function Data: string;
  end;

var
  frmMain:      TfrmMain;
  SocketInputThread: TSocketInputThread;

implementation

{$R *.DFM}

uses support, kernel, output, input, ports, box, progress, setup2, get_time22, get_open2,
  direct;

var
  FIni:         TIniFile;
  stIni:        string;

procedure TSocketInputThread.HandleInput;
var
  cwIn: word;
begin
  with frmMain do begin
    timTimeout.Enabled := False;    // перезапуск таймера
    timTimeout.Enabled := True;

    cwIn := Length(sBuff);
    sCurr := sCurr + sBuff;

    AddTerminalTime('// принято ' + IntToStr(cwIn) + ' байт (доступно ' + IntToStr(Length(sCurr)) + ' из ' + IntToStr(queQuery.cwIn) + ' байт)',clGray);

    if Length(sCurr) >= queQuery.cwIn  then begin
      PostInputSocket(sCurr);
      sCurr := '';
    end;
  end;
end;

procedure TSocketInputThread.Execute;
begin
  with frmMain do begin
    while not Terminated do begin
        if not frmMain.IdTCPClient.Connected then
          Terminate
        else
          try
            if not IdTCPClient.IOHandler.InputBufferIsEmpty then begin
              sBuff := IdTCPClient.IOHandler.InputBufferAsString(Indy8BitEncoding);
              Synchronize(HandleInput);
            end;
          except
        end;
    end;
  end;
end;

function TSocketInputThread.Data: string;
begin
  Result := sCurr;
end;

procedure TfrmMain.ShowConnect;
begin
  with ComPort do
    stbMain.Panels[panCOMPORT].Text :=
      ' COM' + IntToStr(ComNumber) + ': ' + IntToStr(Baud) + ', ' + GetParityStr;
end;

procedure TfrmMain.SetComNumber(wComNumber: word);
begin
  try
    with ComPort do ComNumber := wComNumber;
    ShowConnect;
  except
    ErrBox('Ошибка при изменении номера порта: COM' + IntToStr(wComNumber));
  end;
end;

procedure TfrmMain.SetBaud(dwBaud: longword);
begin
  try
    with ComPort do begin
//      AutoOpen := False;

      Baud := dwBaud;
//      Open := True;
    end;

    ShowConnect;
  except
    ErrBox('Ошибка при изменении скорости обмена: ' + IntToStr(dwBaud) + ' бод');
  end;
end;

procedure TfrmMain.SetParity(ibParity: byte);
begin
  try
    with ComPort do case ibParity of
      1:   Parity := pEven;
      2:   Parity := pOdd;
      3:   Parity := pMark;
      4:   Parity := pSpace;
      else Parity := pNone;
    end;

    ShowConnect;
  except
    ErrBox('Ошибка при изменениии контроля чётности: ' + GetParityStr);
  end;
end;

function TfrmMain.GetParity: byte;
begin
  with ComPort do case Parity of
    pEven:  Result := 1;
    pOdd:   Result := 2;
    pMark:  Result := 3;
    pSpace: Result := 4;
    else    Result := 0;
  end;
end;

function TfrmMain.GetParityStr: string;
begin
  with ComPort do case Parity of
    pEven:  Result := 'even';
    pOdd:   Result := 'odd';
    pMark:  Result := 'mark';
    pSpace: Result := 'space';
    else    Result := 'none';
  end;
end;

function TfrmMain.GetTimeout: word;
begin
  if (pgcMode.ActivePage = tbsPort) then
    Result := updTimeoutPort.Position
  else if (pgcMode.ActivePage = tbsModem) then
    Result := updTimeoutModem.Position
  else begin
    Result := updTimeoutSocket.Position;
  end;
end;

procedure TfrmMain.cmbComNumberChange(Sender: TObject);
begin
  inherited;
  try
    with cmbComNumber do SetComNumber(ItemIndex+1);
  except
    ErrBox('Фатальная ошибка при изменении номера порта !');
  end;
end;

procedure TfrmMain.cmbBaudChange(Sender: TObject);
begin
  inherited;
  try
    with cmbBaud do SetBaud( GetBaudSize(ItemIndex) );
  except
    ErrBox('Фатальная ошибка при изменении скорости обмена !');
  end;
end;

procedure TfrmMain.cmbParityChange(Sender: TObject);
begin
  inherited;
  try
    with cmbParity do SetParity(ItemIndex);
  except
    ErrBox('Фатальная ошибка при изменении контроля чётности !');
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i:  word;
  ProgressBarStyle: integer;
begin
  inherited;
  LoadCmbBauds(cmbBaud.Items);
  LoadCmbParitys(cmbParity.Items);

  for i := 0 to CURRENTS_COUNT-1 do
    clbCurrents.AddItem(CURRENTS[i].sName + ', '+CURRENTS[i].sValue, nil);

  try
    stIni := ChangeFileExt(ParamStr(0),'.ini');
    FileSetAttr(stIni, FileGetAttr(stIni) and not faReadOnly);
  except
  end;

  try
    FIni := TIniFile.Create(ChangeFileExt(ParamStr(0),'.ini'));

    with FIni do begin
      SetComNumber(ReadInteger(COM_PORT, NUMBER, 1));
      SetBaud(ReadInteger(COM_PORT, BAUD, 9600));
      SetParity(ReadInteger(COM_PORT, PARITY, 0)    );
      updTimeoutPort.Position:= ReadInteger(COM_PORT, TIMEOUT, 2000);

      edtDial.Text := ReadString(MODEM, DIAL, '');
      TapiDevice.SelectedDevice := ReadString(MODEM, DEVICE, '');
      ShowSelectedDevice;
      updTimeoutModem.Position := ReadInteger(MODEM, TIMEOUT, 4000);

      edtSocketHost.Text := ReadString(SOCKET, HOST, '');
      edtSocketPort.Text := ReadString(SOCKET, PORT, '');
      updTimeoutSocket.Position := ReadInteger(SOCKET, TIMEOUT, 5000);

      updAddress.Position := FIni.ReadInteger(SETTING, ADDRESS, 0);
      medDevicePass.Text := FIni.ReadString(SETTING, PASSWORD, '00000000');

      updDigits.Position := FIni.ReadInteger(PARAMS, DIGITS, 4);
      updColWidth.Position := FIni.ReadInteger(PARAMS, COLWIDTH, 14);

      pgcMode.TabIndex := FIni.ReadInteger(SETTING, MODE, 0);
      pgcModeChange(nil);

      Stop;

      updMinutesMin.Position    := ReadInteger(PARAMS, MINUTES_MIN,   0);
      updMinutesCount.Position  := ReadInteger(PARAMS, MINUTES_COUNT, 1);
      updHoursMin.Position      := ReadInteger(PARAMS, HOURS_MIN,   0);
      updHoursCount.Position    := ReadInteger(PARAMS, HOURS_COUNT, 1);
      updDaysMin.Position       := ReadInteger(PARAMS, DAYS_MIN,   0);
      updDaysCount.Position     := ReadInteger(PARAMS, DAYS_COUNT, 1);
      updMonthsMin.Position     := ReadInteger(PARAMS, MONTHS_MIN,   0);
      updMonthsCount.Position   := ReadInteger(PARAMS, MONTHS_COUNT, 1);
      updCanalsMin.Position     := ReadInteger(PARAMS, CANALS_MIN,   1);
      updCanalsCount.Position   := ReadInteger(PARAMS, CANALS_COUNT, 1);
      updGroupsMin.Position     := ReadInteger(PARAMS, GROUPS_MIN,   1);
      updGroupsCount.Position   := ReadInteger(PARAMS, GROUPS_COUNT, 1);
      updTariffsMin.Position    := ReadInteger(PARAMS, TARIFFS_MIN, 1);
      updTariffsCount.Position  := ReadInteger(PARAMS, TARIFFS_COUNT, 4);

      updDigitalsMin.Position    := ReadInteger(PARAMS, DIGITALS_MIN, 1);
      updDigitalsCount.Position  := ReadInteger(PARAMS, DIGITALS_COUNT, 512);
      chbDigitals.Checked   := ReadBool(PARAMS, DIGITALS_LIMIT, false);
      ShowDigitals(chbDigitals.Checked);

      updIntervalMin.Position    := ReadInteger(PARAMS, INTERVAL_MIN, 0);
      updIntervalCount.Position  := ReadInteger(PARAMS, INTERVAL_COUNT, 1);

      cmbJournal.ItemIndex       := ReadInteger(PARAMS, JOURNAL, 0);

      BoxCreate;

      for i := 0 to clbMain.Count-1 do
        clbMain.Checked[i] := ReadBool(OPTIONS, INQUIRY+IntTOStr(i), False);

      for i := 0 to clbCurrents.Count-1 do
        clbCurrents.Checked[i] := ReadBool(CURRENTS2, INQUIRY+IntTOStr(i), False);

    end;
  except
    ErrBox('Ошибка при чтении настроек программы !');
  end;

  with ComPort do begin
    if (ComNumber < 1) or (ComNumber > 16) then begin
      ErrBox('Ошибочный номер порта: COM' + IntToStr(ComNumber));
      ComNumber := 0;
    end;
    cmbComNumber.ItemIndex := ComNumber-1;

    if cmbBaud.Items.IndexOf( IntToStr(Baud) ) = -1 then begin
      ErrBox('Ошибочная скорость обмена: ' + IntToStr(Baud)  + ' бод');
      Baud := 9600;
    end;
    cmbBaud.ItemIndex := cmbBaud.Items.IndexOf( IntToStr(Baud) );
  end;

  cmbParity.ItemIndex := GetParity;

  stbMain.Panels[5].Style := psOwnerDraw;
  prbMain.Parent := stbMain;

  ProgressBarStyle := GetWindowLong(prbMain.Handle, GWL_EXSTYLE);
  ProgressBarStyle := ProgressBarStyle - WS_EX_STATICEDGE;
  SetWindowLong(prbMain.Handle, GWL_EXSTYLE, ProgressBarStyle);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
  pgcMain.ActivePage := tbsFirst;
  pgcParams.ActivePage := tbsParamsRead;
  Application.Title := Caption;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  i:  word;
begin
  inherited;
  Stop;

  try
    with FIni do begin
      WriteInteger(COM_PORT, NUMBER, ComPort.ComNumber);
      WriteInteger(COM_PORT, BAUD, ComPort.Baud);
      WriteInteger(COM_PORT, PARITY, GetParity);
      WriteInteger(COM_PORT, TIMEOUT, updTimeoutPort.Position);

      WriteString(MODEM, DIAL, edtDial.Text);
      WriteString(MODEM, DEVICE, TapiDevice.SelectedDevice);
      WriteInteger(MODEM, TIMEOUT, updTimeoutModem.Position);

      WriteString(SOCKET, HOST, edtSocketHost.Text);
      WriteString(SOCKET, PORT, edtSocketPort.Text);
      WriteInteger(SOCKET, TIMEOUT, updTimeoutSocket.Position);
      WriteString(SOCKET, VERSION, '2');

      WriteInteger(SETTING, ADDRESS, updAddress.Position);
      WriteString(SETTING, PASSWORD, medDevicePass.Text);
      WriteInteger(SETTING, MODE, pgcMode.TabIndex);

      WriteInteger(PARAMS, DIGITS, updDigits.Position);
      WriteInteger(PARAMS, COLWIDTH, updColWidth.Position);

      WriteInteger(PARAMS, MINUTES_MIN, updMinutesMin.Position);
      WriteInteger(PARAMS, MINUTES_COUNT, updMinutesCount.Position);
      WriteInteger(PARAMS, HOURS_MIN, updHoursMin.Position);
      WriteInteger(PARAMS, HOURS_COUNT, updHoursCount.Position);
      WriteInteger(PARAMS, DAYS_MIN, updDaysMin.Position);
      WriteInteger(PARAMS, DAYS_COUNT, updDaysCount.Position);
      WriteInteger(PARAMS, MONTHS_MIN, updMonthsMin.Position);
      WriteInteger(PARAMS, MONTHS_COUNT, updMonthsCount.Position);
      WriteInteger(PARAMS, CANALS_MIN, updCanalsMin.Position);
      WriteInteger(PARAMS, CANALS_COUNT, updCanalsCount.Position);
      WriteInteger(PARAMS, GROUPS_MIN, updGroupsMin.Position);
      WriteInteger(PARAMS, GROUPS_COUNT, updGroupsCount.Position);
      WriteInteger(PARAMS, TARIFFS_MIN, updTariffsMin.Position);
      WriteInteger(PARAMS, TARIFFS_COUNT, updTariffsCount.Position);

      WriteInteger(PARAMS, DIGITALS_MIN, updDigitalsMin.Position);
      WriteInteger(PARAMS, DIGITALS_COUNT, updDigitalsCount.Position);
      WriteBool(PARAMS, DIGITALS_LIMIT, chbDigitals.Checked);

      WriteInteger(PARAMS, INTERVAL_MIN, updIntervalMin.Position);
      WriteInteger(PARAMS, INTERVAL_COUNT, updIntervalCount.Position);

      for i := 0 to clbMain.Count - 1 do
        WriteBool(OPTIONS, INQUIRY + IntToStr(i), clbMain.Checked[i]);

      for i := 0 to clbCurrents.Count - 1 do
        WriteBool(CURRENTS2, INQUIRY + IntToStr(i), clbCurrents.Checked[i]);

      WriteInteger(PARAMS, JOURNAL, cmbJournal.ItemIndex);
    end;
  except
    ErrBox('Ошибка при записи настроек программы !');
  end;
end;

procedure TfrmMain.ComPortTriggerAvail(CP: TObject; Count: word);
begin
  inherited;
  //ShowProgress(ComPort.InBuffUsed, queQueryCRC.cwIn);
  stbMain.Panels[panNOW].Text := ' ' + IntToStr(ComPort.InBuffUsed) + ' из ' + IntToStr(queQuery.cwIn) + ' байт';

  if chbBulk.Checked then
    ComTerminal('// доступно ' + IntToStr(ComPort.InBuffUsed) + ' байт; ' + FormatDateTime('hh:mm:ss:zzz',Now));

  timTimeout.Enabled := False;    // перезапуск таймера
  timTimeout.Enabled := True;

  with ComPort do if InBuffUsed >= queQuery.cwIn then begin
    ComTerminal('// приём по количеству байт: ' + IntToStr(InBuffUsed) + ' из ' + IntToStr(queQuery.cwIn));
    PostInputComPort;
  end;
end;

procedure TfrmMain.timTimeoutTimer(Sender: TObject);
begin
  inherited;
  timTimeout.Enabled := False;

  ComTerminal('// приём по таймауту: ' + IntToStr(GetTimeout) + ' мс');

  if (pgcMode.ActivePage = tbsPort) or (pgcMode.ActivePage = tbsModem) then
    PostInputComPort
  else begin
    if SocketInputThread <> nil then PostInputSocket(SocketInputThread.Data);
  end;
end;


procedure TfrmMain.timNowTimer(Sender: TObject);
begin
  inherited;
//  stbMain.Panels[panNOW].Text := ' ' + FormatDateTime('hh:mm:ss dd.mm.yyyy',Now);

  if TapiDevice.TapiState = tsConnected then begin
    Inc(cwConnect);
    stbMain.Panels[panCONNECT].Text := ' соединение: ' + IntToStr(timNow.Interval * cwConnect div 1000) + ' сек';
  end;
end;

procedure TfrmMain.FormResize(Sender: TObject);
var
  i,j:  word;
begin
  inherited;
  with prbMain do begin
    Top := stbMain.Top;

    j := 0;
    for i := 0 to panPROGRESS-1 do j := j + stbMain.Panels[i].Width;

    Left := j;
    Width := stbMain.Width - j;
  end;
end;

procedure TfrmMain.FocusTerminal;
begin
  if chbTerminal.Checked then begin
    try
      with redTerminal do if CanFocus and Visible then SetFocus;
    except
    end;
  end;
end;

procedure TfrmMain.ClearTerminal;
begin
  redTerminal.Clear;
end;

procedure TfrmMain.IdTCPClientBeforeBind(Sender: TObject);
begin
  inherited;
  AddTerminalTime('IdTCPClient - BeforeBind',clGray);
end;

procedure TfrmMain.IdTCPClientAfterBind(Sender: TObject);
begin
  inherited;
  AddTerminalTime('IdTCPClient - AfterBind',clGray);
end;

procedure TfrmMain.IdTCPClientSocketAllocated(Sender: TObject);
begin
  inherited;
  AddTerminalTime('IdTCPClient - SocketAllocated',clGray);
end;

procedure TfrmMain.IdTCPClientConnected(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := 'Установлено соединение c сокетом: ' + IdTCPClient.Host + ':' + IntToStr(IdTCPClient.Port);

  AddTerminalTime(s,clGray);
  AddDial(s);
  InfBox(s);
end;

procedure TfrmMain.IdTCPClientDisconnected(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := 'Отсоединение';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
var
  s: string;
begin
  inherited;
  s := 'Событие: ' + AStatusText;

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
var
  s: string;
begin
  inherited;
  if AWorkMode = wmRead then
    s := 'чтение: ' + IntToStr(AWorkCount) + ' байт'
  else
    s := 'запись: ' + IntToStr(AWorkCount) + ' байт';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
var
  s: string;
begin
  inherited;
  if AWorkMode = wmRead then
    s := 'чтение начато: максимум ' + IntToStr(AWorkCountMax) + ' байт'
  else
    s := 'запись начата: максимум ' + IntToStr(AWorkCountMax) + ' байт';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.IdTCPClientWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
var
  s: string;
begin
  inherited;
  if AWorkMode = wmRead then
    s := 'чтение закончено'
  else
    s := 'запись закончена';

  AddTerminalTime(s,clGray);
  AddDial(s);
end;

procedure TfrmMain.AddTerminal(stT: string; clOut: TColor);
begin
  if chbTerminal.Checked then begin
    try
//      FocusTerminal;
      with redTerminal do begin
        Lines.Append(stT);
      end;
    except
    end;
  end;
end;

procedure TfrmMain.AddTerminalTime(stT: string; clOut: TColor);
begin
  AddTerminal(stT + '   // ' + FormatDateTime('hh:mm:ss:zzz',Now), clOut);
end;

procedure TfrmMain.btbTransitClick(Sender: TObject);
begin
  inherited;
  BoxGetOpen2(acGetTransit);
end;

procedure TfrmMain.ComTerminal(stT: string);
begin
  if chbTerminal.Checked then begin
    try
      FocusTerminal;
      with redTerminal do begin
        Lines.Append(stT);
      end;
    except
    end;
  end;
end;

procedure TfrmMain.AddInfo(stT: string);
begin
  try
    memInfo.Lines.Append(stT);
    AddTerminal(stT, clGray);
  except
  end
end;

procedure TfrmMain.AddInfoAll(stT: TStrings);
begin
  try
    memInfo.Lines.AddStrings(stT);
    memInfo.Lines.Append(' ');
    redTerminal.Lines.AddStrings(stT);
    redTerminal.Lines.Append(' ');
    stT.Free;
  except
  end
end;

procedure TfrmMain.ClearInfo;
begin
  memInfo.Clear;
end;

procedure TfrmMain.ClearDial;
begin
  memDial.Clear;
end;

procedure TfrmMain.AddDial(stT: string);
begin
  try
    memDial.Lines.Append(stT);
  except
  end
end;

procedure TfrmMain.ShowSelectedDevice;
begin
  lblSelectedDevice.Caption := TapiDevice.SelectedDevice;
end;

procedure TfrmMain.stbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
  inherited;
  if Panel = StatusBar.Panels[5] then
  with prbMain do begin
    Top := Rect.Top;
    Left := Rect.Left;
    Width := Rect.Right - Rect.Left;
    Height := Rect.Bottom - Rect.Top;
  end;
end;

procedure TfrmMain.TAPIoff;
begin
  inherited;
  try
    with ComPort do begin
      TapiMode := tmOff;

      AutoOpen := False;
      Open := True;
    end;
    ShowSelectedDevice;
  except
    ErrBox('Ошибка при открытии порта COM' + IntToStr(ComPort.ComNumber));
  end;
end;

procedure TfrmMain.TAPIon;
begin
  inherited;
  with ComPort do begin
    TapiMode := tmOn;

    AutoOpen := False;
    Open := False;
  end;
  ShowSelectedDevice;
end;

procedure TfrmMain.TapiDeviceTapiStatus(CP: TObject; First,
  Last: Boolean; Device, Message, Param1, Param2, Param3: Integer);
begin
  inherited;
  AddTerminal('OnTapiStatus event',clGray);

  if First then
    AddTerminal('First event',clGray)
  else if Last then
    AddTerminal('Last event',clGray)
  else with TapiDevice do begin
    AddTerminal('событие: ' + TapiStatusMsg(Message,Param1,Param2) + ' ' + Number,clGray);
    AddDial('событие: ' + TapiStatusMsg(Message,Param1,Param2) + ' ' + Number);
  end;
end;

procedure TfrmMain.TapiDeviceTapiLog(CP: TObject; Log: TTapiLogCode);
begin
  inherited;
//  AddTerminal('OnTapiLog event',clGray);
end;

procedure TfrmMain.TapiDeviceTapiPortOpen(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiPortOpen event',clGray);
  AddDial('порт открыт');
end;

procedure TfrmMain.TapiDeviceTapiPortClose(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiPortClose event',clGray);
  AddDial('порт закрыт');
end;

procedure TfrmMain.TapiDeviceTapiConnect(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiConnect event',clGray);

  with TapiDevice do begin
    AddTerminal('connect at ' + IntToStr(BPSRate),clGray);
    AddDial('установлено соединение с ' + edtDial.Text + ' на скорости ' + IntToStr(BPSRate) + ' бод');
    InfBox('Установлено соединение с ' + edtDial.Text + ' на скорости ' + IntToStr(BPSRate) + ' бод');
  end;
end;

procedure TfrmMain.TapiDeviceTapiFail(Sender: TObject);
begin
  inherited;
  AddTerminal('OnTapiFail event',clGray);

  with TapiDevice do begin
    AddTerminal('fail: ' + FailureCodeMsg(FailureCode),clGray);
    AddDial('ошибка: ' + FailureCodeMsg(FailureCode));
    InfBox('Ошибка: ' + FailureCodeMsg(FailureCode));
  end;
end;

procedure TfrmMain.btbClearTerminalClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, 'Терминал ' + DateTime2Str + ' ');
  ClearTerminal;
end;

procedure TfrmMain.btbCorrectTimeClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmSetup2) then frmSetup2 := TfrmSetup2.Create(Self);
  frmSetup2.ShowModal;
end;

procedure TfrmMain.btbSelectDeviceClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.SelectDevice;
    ClearDial;
  except
    on e: Exception do ErrBox('Ошибка при выборе модема: ' + e.Message);
  end;

  ShowSelectedDevice;
end;

procedure TfrmMain.btbSetTimeClick(Sender: TObject);
begin
  inherited;
  BoxGetTime22;
end;

procedure TfrmMain.btbShowConfigDialogClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.ShowConfigDialog;
  except
    on e: Exception do ErrBox('Ошибка при настройке модема: ' + e.Message);
  end;
end;

procedure TfrmMain.btbSocketOpenClick(Sender: TObject);
var
  Port: word;
begin
  inherited;
  try
    Port := StrToIntDef(edtSocketPort.Text, 0);

    if (Port = 0) then
      ErrBox('Порт сокета задан неправильно')
    else begin
      IdTCPClient.Host := edtSocketHost.Text;
      IdTCPClient.Port := Port;
      IdTCPClient.Connect;
      IdTCPClient.IOHandler.DefStringEncoding := Indy8BitEncoding;

      SocketInputThread := TSocketInputThread.Create(True);
      SocketInputThread.FreeOnTerminate := True;
      SocketInputThread.Resume;
    end;
  except
    on e: Exception do ErrBox('Ошибка при открытии сокета: ' + e.Message);
  end;
end;

//http://stackoverflow.com/questions/12507677/terminate-a-thread-and-disconnect-an-indy-client
procedure TfrmMain.btbSocketCloseClick(Sender: TObject);
begin
  inherited;
  try
    if SocketInputThread <> nil then SocketInputThread.Terminate;
    try
      if IdTCPClient.Connected then IdTCPClient.Disconnect;
    finally
      if SocketInputThread <> nil then
      begin
        SocketInputThread.WaitFor;
        SocketInputThread.Free;
        SocketInputThread := nil;
      end;
    end;
  except
    on e: Exception do AddTerminalTime('Ошибка при закрытии сокета: ' + e.Message,clGray);
  end;
end;

procedure TfrmMain.btbDialClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.Dial(edtDial.Text);
  except
    on e: Exception do ErrBox('Ошибка при установлении соединения: ' + e.Message);
  end;
end;

procedure TfrmMain.btbDirectClick(Sender: TObject);
begin
  inherited;
  if not Assigned(frmDirect) then frmDirect := TfrmDirect.Create(Self);
  frmDirect.ShowModal;
end;

procedure TfrmMain.btbCancelCallClick(Sender: TObject);
begin
  inherited;
  try
    TapiDevice.CancelCall;
    AddDial('отбой !');
  except
    on e: Exception do ErrBox('Ошибка при разрыве связи: ' + e.Message);
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if IdTCPClient.Connected = True then btbSocketCloseClick(nil);

  if TapiDevice.TapiState = tsConnected then begin
    WrnBox('Модем находится в состоянии соединения.'+ #10#13 +
           'Перед выходом из программы необходимо разорвать связь !');
    Abort;
  end;

  timNow.Enabled := False;
  Stop;

  btbClearTerminalClick(nil);
end;

procedure TfrmMain.btbStopInfoClick(Sender: TObject);
begin
  inherited;
  Stop;
end;

procedure TfrmMain.SaveRich(Rich: TRichEdit; stName: string);
begin
  with sd_RichToFile,Rich do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0));

      SysUtils.ForceDirectories(InitialDir);
      FileName := stName + '.rtf';

      if Execute then Rich.Lines.SaveToFile(FileName);
    except
      ErrBox('Ошибка при сохранении отчёта !')
    end;
  end;
end;

procedure TfrmMain.SaveMemo(Memo: TMemo; stName: string);
begin
  with sd_RichToFile,Memo do begin
    try
      InitialDir := ExtractFileDir(ParamStr(0));

      SysUtils.ForceDirectories(InitialDir);
      FileName := stName + '.txt';

      if Execute then Memo.Lines.SaveToFile(FileName);
    except
      ErrBox('Ошибка при сохранении отчёта !')
    end;
  end;
end;

procedure TfrmMain.SaveLog(Memo: TMemo; stName: string);
var
  s: string;
begin
  with Memo do if Lines.Count > 0 then begin
    try
      s := ExtractFileDir(ParamStr(0)) + '\'+ LOGS_DIR + '\'+ FormatDateTime('dd_mm_yyyy',Now) + '\';
      SysUtils.ForceDirectories(s);

      Memo.Lines.Append('');
      Memo.Lines.Append('// '+mitVersion.Caption);

      Memo.Lines.SaveToFile(s + stName + '.log');
    except
      ErrBox('Ошибка при сохранении отчёта !')
    end;
  end;
end;

procedure TfrmMain.btbSaveTerminalClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, 'Терминал ' + DateTime2Str + ' ');
  SaveMemo(redTerminal, 'Терминал ' + DateTime2Str + ' ');
end;

procedure TfrmMain.ShowRepeat;
begin
  inherited;
  stbMain.Panels[panREPEATS].Text := ' повтор: ' + IntToStr(cbIncRepeat) + '  ' + IntToStr(100*cbIncRepeat div cwIncTotal)+'%';
end;

procedure TfrmMain.btbCrealInfoClick(Sender: TObject);
begin
  inherited;
  SaveLog(redTerminal, 'Терминал ' + DateTime2Str + ' ');
  ClearInfo;
end;

procedure TfrmMain.btbSaveInfoClick(Sender: TObject);
begin
  inherited;
  SaveMemo(memInfo, 'Отчет ' + DateTime2Str + ' ');
end;

procedure TfrmMain.btbRunClick(Sender: TObject);
begin
  inherited;
  BoxRead;
end;

procedure TfrmMain.mitSetItemsClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbMain do for i := 0 to Count-1 do Checked[i] := True;
end;

procedure TfrmMain.mitClearItesClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbMain do for i := 0 to Count-1 do Checked[i] := False;
end;

procedure TfrmMain.pgcModeChange(Sender: TObject);
begin
  inherited;
  if pgcMode.ActivePage = tbsPort then begin
    TAPIoff;
  end
  else if pgcMode.ActivePage = tbsModem then begin
    TAPIon;
  end
  else if pgcMode.ActivePage = tbsSocket then begin
  end
end;

procedure TfrmMain.pgcParamsChange(Sender: TObject);
begin
  inherited;
  btbRun.Enabled := pgcParams.ActivePage = tbsParamsRead;
end;

procedure TfrmMain.chbDigitalsClick(Sender: TObject);
begin
  inherited;
  ShowDigitals(chbDigitals.Checked);
end;

procedure TfrmMain.clbMainMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  a: Longint = -1;
var
  b: Longint;
begin
  inherited;
  with Sender as TCheckListBox do begin
    b := ItemAtPos(Point(x,y),True);
    if (b < 0) or (b = a) then Exit;
    Application.ProcessMessages;
    Application.CancelHint;
    a := b;
    Hint := '';
    //if Canvas.TextWidth(Items[b]) > Width - 4 then
      Hint := Items[b];
  end;
end;

procedure TfrmMain.mniSetCurrentsClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbCurrents do for i := 0 to Count-1 do Checked[i] := True;
end;

procedure TfrmMain.mniClearCurrentsClick(Sender: TObject);
var
  i:  byte;
begin
  inherited;
  with clbCurrents do for i := 0 to Count-1 do Checked[i] := False;
end;

procedure TfrmMain.ShowDigitals(Flag: boolean);
begin
  lblDigitalsMin.Enabled   := Flag;
  edtDigitalsMin.Enabled   := Flag;
  updDigitalsMin.Enabled   := Flag;

  lblDigitalsCount.Enabled := Flag;
  edtDigitalsCount.Enabled := Flag;
  updDigitalsCount.Enabled := Flag;
end;

end.
