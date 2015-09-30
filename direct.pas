unit direct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, yesno, StdCtrls, Buttons, ExtCtrls, Mask;

type
  TfrmDirect = class(TfrmYesNo)
    lblInfo: TLabel;
    imgInfo: TImage;
    memDirect: TMemo;
    chbCRC: TCheckBox;
    procedure btbOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDirect: TfrmDirect;

implementation

uses output;

{$R *.dfm}

procedure TfrmDirect.btbOKClick(Sender: TObject);
begin
  inherited;
  QueryDirect(Trim(memDirect.Text), chbCRC.Checked);
end;

end.
