unit get_events_counts;

interface

uses Generics.Collections;

type
  event_stat = record
    wEvents: word;
    bDay:   byte;
    bMonth: byte;
  end;

var
  mpEventsStat: TList<event_stat>;
  wTotalEvents: word;
  bJournal:     byte;

function GetJournalNumber: byte;
function InfoGetEventsCounts: string;
procedure BoxGetEventsCounts;
procedure ShowGetEventsCounts;

implementation

uses SysUtils, output, support, box, kernel, main, get_events;

const
  quGetEventsCount:   querys = (Action: acGetEventsCount; cwOut: 6+6+4; cwIn: 0; wNumber: $C2);

var
  stEventStat:  event_stat;

function GetJournalNumber: byte;
begin
  Result := bJournal;
end;

function InfoGetEventsCounts: string;
begin
  Result := 'Журнал событий';
end;

procedure QueryGetEventsCount;
begin
  with frmMain do
  begin
    InitPush(6);
    PushInt(GetJournalNumber);
    PushInt(updDaysMin.Position);
    PushInt(updDaysCount.Position);
    Query(quGetEventsCount);
  end;
end;

procedure BoxGetEventsCounts;
begin
  bJournal := frmMain.cmbJournal.ItemIndex + 1;
  mpEventsStat := TList<event_stat>.Create;
  wTotalEvents := 0;

  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetEventsCounts);
  AddInfo('');
  QueryGetEventsCount;
end;

procedure ShowGetEventsCounts;
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
    BoxGetEvents;
  end;
end;

end.

