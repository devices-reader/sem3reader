{?}unit progress;

interface

//procedure InitProgress;
procedure ShowProgress(i: integer; j: integer);

implementation

uses ComCtrls, main;
{
procedure InitProgress(StatusBar: TStatusBar; ProgressBar: TProgressBar);
var
  ProgressBarStyle: integer;
begin
  // enable status bar 2nd Panel custom drawing
  StatusBar.Panels[5].Style := psOwnerDraw;

  // place the progress bar into the status bar
  ProgressBar.Parent := StatusBar;

  // remove progress bar border
  ProgressBarStyle := GetWindowLong(ProgressBar1.Handle, GWL_EXSTYLE);
  ProgressBarStyle := ProgressBarStyle - WS_EX_STATICEDGE;
  SetWindowLong(ProgressBar1.Handle, GWL_EXSTYLE, ProgressBarStyle);
end;
}
procedure ShowProgress(i: integer; j: integer);
begin
  with frmMain.prbMain do
  begin
    Min := 0;
    Max := j;
    Position := i + 1;
  end;
end;

end.
