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

    if (updMinutesCount.Position = 0) then begin ErrBox('���������� ��������� ������ ���� ������ ���� !'); exit; end;

    Result := True;
  end;
end;

function TestDays: boolean;
begin
  with frmMain do begin
    Result := False;

    if (updDaysCount.Position = 0) then begin ErrBox('���������� ����� ������ ���� ������ ���� !'); exit; end;

    Result := True;
  end;
end;

function TestCanals: boolean;
var
  c:  word;
begin
  with frmMain do begin
    Result := False;

    if (updCanalsMin.Position = 0) then begin ErrBox('��������� ����� ������ ������ ���� ������ ���� !'); exit; end;
    if (updCanalsCount.Position = 0) then begin ErrBox('���������� ������� ������ ���� ������ ���� !'); exit; end;

    c := updCanalsMin.Position + updCanalsCount.Position - 1;
    if (c > wCanals) then begin
      ErrBox('�������� ����� ������ (' + IntToStr(c) + ') ������ ���������� ������� � ��������� (' + IntToStr(wCanals) + ')');
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

    if (updGroupsMin.Position = 0) then begin ErrBox('��������� ����� ������ ������ ���� ������ ���� !'); exit; end;
    if (updGroupsCount.Position = 0) then begin ErrBox('���������� ������ ������ ���� ������ ���� !'); exit; end;

    g := updGroupsMin.Position + updGroupsCount.Position - 1;
    if (g > wGroups) then begin
      ErrBox('�������� ����� ������ (' + IntToStr(g) + ') ������ ���������� ����� � ��������� (' + IntToStr(wGroups) + ')');
      exit;
    end;

    Result := True;
  end;
end;

function TestCurrents: boolean;
begin
  with frmMain do begin
    Result := False;

    if (updCanalsMin.Position = 0) then begin ErrBox('��������� ����� ����������� ��������� ������ ���� ������ ���� !'); exit; end;
    if (updCanalsCount.Position = 0) then begin ErrBox('���������� ���������� ���������� ������ ���� ������ ���� !'); exit; end;

    if (GetCurrentsCount = 0) then begin ErrBox('�� ����� �� ���� ���������� �������� !'); exit; end;

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
