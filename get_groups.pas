unit get_groups;

interface

function InfoGetGroups: string;
procedure BoxGetGroups;
procedure ShowGetGroups;

implementation

uses SysUtils, output, support, box, kernel, progress, pipeline, get_config;

const
  quGetGroups:   querys = (Action: acGetGroups; cwOut: 6+4+4; cwIn: 0; wNumber: $D4);

var
  mpbGroups:  array[0..128-1] of byte;
  mpgrGroups: array[1..GROUPS] of group;

function InfoGetGroups: string;
begin
  Result := 'Группы';
end;

procedure QueryGetGroups;
begin
  ShowGroupsPipeline;

  InitPush(6);
  PushInt(wGroupsMin);
  PushInt(wGroupsCount);
  Query(quGetGroups);
end;

procedure BoxGetGroups;
begin
  InitGroupsPipeline((wSafeBuffSize-16) div 162, 1, wGroups);

  AddInfo('');
  AddInfo('');
  AddInfo(InfoGetGroups);
  AddInfo('');
  QueryGetGroups;
end;

procedure LoadGroup(g: word);
var
  c:  word;
  b:  byte;
begin
  with mpgrGroups[g] do begin
    wSize := 0;
    for c := 0 to CANALS-1 do begin
      b := mpbGroups[128-1 - (c div 4)];

      with mpnoNodes[wSize] do begin
        if (b and ($01 shl ((c mod 4)*2))) <> 0 then begin
          iwCanal := c;

          if (b and ($02 shl ((c mod 4)*2))) <> 0 then
            boPositive := false
          else
            boPositive := true;

          wSize := wSize+1;
        end;
      end;
    end;
  end;
end;

function Group2Str(g: word): string;
var
  c:  word;
begin
  Result := '';
  with mpgrGroups[g] do begin
    if (wSize = 0) then
      Result := Result + 'нет каналов'
    else for c := 0 to wSize-1 do with mpnoNodes[c] do begin
       if boPositive then Result := Result + '+' else Result := Result + '-';
       Result := Result + IntToStr(iwCanal+1);
    end;
  end;
end;

procedure ShowGetGroups;
var
  g:    word;
  i:    byte;
  n:    word;
  s:    string;
begin
  Stop;
  InitPop(6);

  for g := wGroupsMin to wGroupsMin+wGroupsCount-1 do begin
    n := PopWord;
    AddTerm('номер группы: ' + IntToStr(n));

    for i := 0 to 128-1 do mpbGroups[i] := PopByte;
    LoadGroup(g);
    mpgrGroups[g].stName := PopStr(32);
  end;

  ShowProgress(wGroupsMin+wGroupsCount-1, wGroups);

  if wGroupsMin+wGroupsCount-1 >= wGroups then begin
    s := PackStrR('№', 4);
    s := s + PackStrR('название', 32+2);
    s := s + 'каналы';
    AddInfo(s);

    AddInfo(PackLine(4+32+2+GetColWidth));

    for g := 1 to wGroups do begin
      s := PackStrR(IntToStr(g), 4);
      s := s + PackStrR(mpgrGroups[g].stName, 32+2);
      s := s + Group2Str(g);
      AddInfo(s);
    end;

    RunBox;
  end
  else begin
    NextGroupsPipeline(wGroups);
    QueryGetGroups;
  end;
end;

end.
