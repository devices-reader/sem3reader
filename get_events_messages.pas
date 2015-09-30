unit get_events_messages;

interface

procedure BoxGetEventsMessages;
procedure ShowGetEventsMessages;

var
  mpEventsMessages: array[0..255] of string;

implementation

uses SysUtils, Generics.Collections, kernel, output, support, box, progress, timez, calendar, get_events_counts, get_events;

var
  iwEvent:  word;
  mpMessages: TList<String>;

const
  quGetEventsMessage:   querys = (Action: acGetEventsMessage; cwOut: 6+4+4; cwIn: 0; wNumber: $C1);

procedure QueryGetEventsMessage;
begin
  with mpEvents.Items[iwEvent] do begin
    InitPush(6);
    PushInt(GetJournalNumber);
    PushByte(bCode);
    PushByte(1);
    Query(quGetEventsMessage);
  end;
end;

procedure BoxGetEventsMessages;
var
  i:  byte;
begin
  iwEvent := 0;
  for i := 0 to 255 do mpEventsMessages[i] := '';
  mpMessages := TList<String>.Create;

  QueryGetEventsMessage;
end;

procedure InfoEventsMessage(evT: event; z: string);
var
  s,f:  string;
  i:    integer;
  ti:   times;
begin
   with evT, evT.tiTime do begin
     s := Int2Str(bHour)+ ':' + Int2Str(bMinute)+ ' ' + Int2Str(bDay)+ '.' + Int2Str(bMonth)+ '.' + Int2Str(bYear) + '  ';
     s := s + PackStrR(IntToStr(bCode), 4);
     s := s + PackStrR(IntToHex(word(wParam1),4), 6);
     s := s + PackStrR(IntToHex(word(wParam2),4), 6);
     f := Format(z, [evT.wParam1, evT.wParam2]);

     i := Pos('#t4', f);
     if i > 0 then begin
        ti := SecIndexToDate(word(wParam1) shl 16 + word(wParam2));
        f := StringReplace(f,'#t4',Times2Str(ti),[]);
     end;

     i := Pos('#bd[0]', f);
     if i > 0 then begin
        f := StringReplace(f,'#bd[0]',IntToStr(word(wParam1) div $100),[]);
     end;

     i := Pos('#bd[1]', f);
     if i > 0 then begin
        f := StringReplace(f,'#bd[1]',IntToStr(word(wParam1) mod $100),[]);
     end;

     i := Pos('#bd[2]', f);
     if i > 0 then begin
        f := StringReplace(f,'#bd[2]',IntToStr(word(wParam2) div $100),[]);
     end;

     i := Pos('#bd[3]', f);
     if i > 0 then begin
        f := StringReplace(f,'#bd[3]',IntToStr(word(wParam2) mod $100),[]);
     end;

     i := Pos('#bh[0]', f);
     if i > 0 then begin
        f := StringReplace(f,'#bh[0]',IntToHex(word(wParam1) div $100,2),[]);
     end;

     i := Pos('#bh[1]', f);
     if i > 0 then begin
        f := StringReplace(f,'#bh[1]',IntToHex(word(wParam1) mod $100,2),[]);
     end;

     i := Pos('#bh[2]', f);
     if i > 0 then begin
        f := StringReplace(f,'#bh[2]',IntToHex(word(wParam2) div $100,2),[]);
     end;

     i := Pos('#bh[3]', f);
     if i > 0 then begin
        f := StringReplace(f,'#bh[3]',IntToHex(word(wParam2) mod $100,2),[]);
     end;

     i := Pos('#id[0]', f);
     if i > 0 then begin
        f := StringReplace(f,'#id[0]',IntToStr(word(wParam1)),[]);
     end;

     i := Pos('#id[1]', f);
     if i > 0 then begin
        f := StringReplace(f,'#id[1]',IntToStr(word(wParam2)),[]);
     end;

     i := Pos('#ih[0]', f);
     if i > 0 then begin
        f := StringReplace(f,'#ih[0]',IntToHex(word(wParam1),4),[]);
     end;

     i := Pos('#ih[1]', f);
     if i > 0 then begin
        f := StringReplace(f,'#ih[1]',IntToHex(word(wParam2),4),[]);
     end;

     s := s + f;
     AddInfo(s);
     mpMessages.Add(s);
   end;
end;

procedure ShowGetEventsMessages;
var
  s,z:  string;
  i:  word;
  j:  byte;
  c:  byte;
begin
  Stop;
  InitPop(6);

  AddTerm('журнал:              ' + IntToStr(PopByte));
  AddTerm('количество описаний: ' + IntToStr(PopByte));
  c := PopByte;
  AddTerm('тип события:         ' + IntToStr(c));

  s := '';
  for i := 1 to 63 do begin
    j := PopByte;
    if j = 0 then break;
    s := s + AnsiChar(j);
  end;

  mpEventsMessages[c] := s;
  InfoEventsMessage(mpEvents.Items[iwEvent], s);

  while iwEvent < mpEvents.Count-1 do begin
    ShowProgress(iwEvent, mpEvents.Count);

    Inc(iwEvent);
    AddTerm('индекс ' + IntToStr(iwEvent) + ' из ' + IntToStr(mpEvents.Count-1));
    z := mpEventsMessages[mpEvents.Items[iwEvent].bCode];
    if z = '' then begin
      AddTerm('запрос сообщения ' + IntToStr(mpEvents.Items[iwEvent].bCode));
      QueryGetEventsMessage;
      exit;
    end
    else begin
      AddTerm('сообщение в буфере ' + IntToStr(mpEvents.Items[iwEvent].bCode));
      InfoEventsMessage(mpEvents.Items[iwEvent], z);
    end;
  end;

  if iwEvent >= mpEvents.Count-1 then begin
    AddTerm('опрос завершен');
    mpEvents.Free;

    AddInfo('');
    AddInfo('');
    AddInfo(InfoGetEventsCounts);
    AddInfo('');
    for i := 0 to mpMessages.Count-1 do AddInfo(mpMessages.Items[i]);
    mpMessages.Free;

    RunBox;
  end;
end;

end.

