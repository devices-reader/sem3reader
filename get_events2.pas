unit get_events2;

interface

uses Generics.Collections;

procedure QueryGetEvents2;
procedure BoxGetEvents2;
procedure ShowGetEvents2;

implementation

uses SysUtils, output, support, box, kernel, progress, get_events, get_events_counts, get_events_counts2, get_events_messages;

var
  wDay:     word;
  wEvent:   word;
  stEvent:  event;
  wReadyEvents: word;

const
  quGetEvents2:  querys = (Action: acGetEvents2; cwOut: 6+8+4; cwIn: 0; wNumber: $10C0);

procedure QueryGetEvents2;
var
  y:  byte;
begin
  InitPush(6);
  PushByte(GetJournalNumber);
  with mpEventsStat.Items[wDay] do begin
    PushByte(bDay);
    PushByte(bMonth);
    if (bMonth > tiCurr.bMonth) then y := tiCurr.bYear-1 else y := tiCurr.bYear;
    PushByte(y);

    AddInfo('cутки: '+Int2Str(bDay)+'.'+Int2Str(bMonth)+', событие: '+IntToStr(wEvent));
  end;
  PushInt(wEvent);
  PushInt(1);
  Query(quGetEvents2);
end;

procedure BoxGetEvents2;
begin
  wDay   := 0;
  wEvent := 1;
  mpEvents := TList<event>.Create;
  wReadyEvents := 0;

  AddInfo('');
  QueryGetEvents2;
end;

procedure ShowGetEvents2;
var
s:  string;
begin
  Stop;
  InitPop(6);

  with stEvent do begin
    bCode := PopByte;
    wParam1 := PopInt;
    wParam2 := PopInt;

    with tiTime do begin
      bMinute := PopByte;
      bHour   := PopByte;
      bDay    := PopByte;
      bMonth  := PopByte;
      bYear   := PopByte;
    end;

    with tiTime do begin
      s := Int2Str(bHour)+ ':' + Int2Str(bMinute)+ ' ' + Int2Str(bDay)+ '.' + Int2Str(bMonth)+ '.' + Int2Str(bYear) + '  ';
      s := s + PackStrR(IntToStr(bCode), 4);
      s := s + PackStrR(IntToHex(word(wParam1),4), 6);
      s := s + PackStrR(IntToHex(word(wParam2),4), 6);
      AddInfo(s);
      AddInfo('');
    end;

  end;

  mpEvents.Add(stEvent);
  Inc(wReadyEvents);
  ShowProgress(wReadyEvents-1, wTotalEvents);

  if wEvent <  mpEventsStat.Items[wDay].wEvents then begin
    Inc(wEvent);
    QueryGetEvents2;
  end
  else if wDay + 1 < mpEventsStat.Count then begin
    wEvent := 1;
    Inc(wDay);
    QueryGetEvents2;
  end
  else begin
    mpEventsStat.Free;
    BoxGetEventsMessages;
  end;
end;

end.

