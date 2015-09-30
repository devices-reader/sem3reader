unit get_events_counts2;

interface

uses Generics.Collections;

function InfoGetEventsCounts2: string;
procedure BoxGetEventsCounts2;
procedure ShowGetEventsCounts2;

implementation

uses SysUtils, output, support, box, kernel, main, get_events2, get_events_counts;

const
  quGetEventsCount2:   querys = (Action: acGetEventsCount2; cwOut: 6+6+4; cwIn: 0; wNumber: $C2);

var
  stEventStat:  event_stat;

function InfoGetEventsCounts2: string;
begin
  Result := 'Журнал событий (версия 2)';
end;

procedure QueryGetEventsCount2;
begin
  with frmMain do
  begin
    InitPush(6);
    PushInt(GetJournalNumber);
    PushInt(updDaysMin.Position);
    PushInt(updDaysCount.Position);
    Query(quGetEventsCount2);
  end;
end;

procedure BoxGetEventsCounts2;
begin
  bJournal := frmMain.cmbJournal.ItemIndex + 1;
  mpEventsStat := TList<event_stat>.Create;
  wTotalEvents := 0;

  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetEventsCounts2);
  AddInfo('');
  QueryGetEventsCount2;
end;

procedure ShowGetEventsCounts2;
var
  i:  word;
begin
  Stop;
  InitPop(6);

  AddInfo('Журнал                        ' + IntToStr(PopByte));
  AddInfo('Максимальное число событий    ' + IntToStr(PopInt));
  AddInfo('Текущее число событий         ' + IntToStr(PopInt));
  AddInfo('');
  AddInfo('Количество событий по суткам');

  with frmMain do begin
    for i := 1 to updDaysCount.Position do begin
      with stEventStat do begin
        wEvents := PopWord;
        bDay    := PopByte;
        bMonth  := PopByte;

        AddInfo(PackStrR(Int2Str(bDay) + '.' + Int2Str(bMonth), GetColWidth) + IntToStr(wEvents));
      end;

      if stEventStat.wEvents > 0 then begin
        mpEventsStat.Add(stEventStat);
        Inc(wTotalEvents, stEventStat.wEvents);
      end;
    end;
  end;

  if mpEventsStat.Count = 0 then begin
    AddInfo('Нет событий за указанные сутки');
    RunBox;
  end
  else begin
    AddInfo('Количество суток с событиями: ' + IntToStr(mpEventsStat.Count));
    AddInfo('Количество событий:           ' + IntToStr(wTotalEvents));
    BoxGetEvents2;
  end;
end;

end.

