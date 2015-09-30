unit borders;

interface

function TestMinutes: boolean;
function TestDays: boolean;

function TestCanals: boolean;
function TestGroups: boolean;

function TestCurrents: boolean;
function GetCurrentsCount: byte;

implementation

uses SysUtils, main, support, kernel, get_config;

function TestMinutes: boolean;
begin
  with frmMain do begin
    Result := False;

    if (updMinutesCount.Position = 0) then begin ErrBox('Количество трехминут должно быть больше нуля !'); exit; end;

    Result := True;
  end;
end;

function TestDays: boolean;
begin
  with frmMain do begin
    Result := False;

    if (updDaysCount.Position = 0) then begin ErrBox('Количество суток должно быть больше нуля !'); exit; end;

    Result := True;
  end;
end;

function TestCanals: boolean;
var
  c:  word;
begin
  with frmMain do begin
    Result := False;

    if (updCanalsMin.Position = 0) then begin ErrBox('Начальный номер канала должен быть больше нуля !'); exit; end;
    if (updCanalsCount.Position = 0) then begin ErrBox('Количество каналов должно быть больше нуля !'); exit; end;

    c := updCanalsMin.Position + updCanalsCount.Position - 1;
    if (c > wCanals) then begin
      ErrBox('Конечный номер канала (' + IntToStr(c) + ') больше количества каналов в сумматоре (' + IntToStr(wCanals) + ')');
      exit;
    end;

    Result := True;
  end;
end;

function TestGroups: boolean;
var
  g:  word;
begin
  with frmMain do begin
    Result := False;

    if (updGroupsMin.Position = 0) then begin ErrBox('Начальный номер группы должен быть больше нуля !'); exit; end;
    if (updGroupsCount.Position = 0) then begin ErrBox('Количество группы должно быть больше нуля !'); exit; end;

    g := updGroupsMin.Position + updGroupsCount.Position - 1;
    if (g > wGroups) then begin
      ErrBox('Конечный номер группы (' + IntToStr(g) + ') больше количества групп в сумматоре (' + IntToStr(wGroups) + ')');
      exit;
    end;

    Result := True;
  end;
end;

function TestCurrents: boolean;
begin
  with frmMain do begin
    Result := False;

    if (updCanalsMin.Position = 0) then begin ErrBox('Начальный номер мгновенного параметра должен быть больше нуля !'); exit; end;
    if (updCanalsCount.Position = 0) then begin ErrBox('Количество мгновенных параметров должно быть больше нуля !'); exit; end;

    if (GetCurrentsCount = 0) then begin ErrBox('Не задан ни один мгновенный параметр !'); exit; end;

    Result := True;
  end;
end;

function GetCurrentsCount: byte;
var
  i:  byte;
begin
  with frmMain do begin
    Result := 0;
    for i := 0 to CURRENTS_COUNT-1 do begin
       if clbCurrents.Checked[i] then
         Inc(Result);
    end;
  end;
end;

end.
