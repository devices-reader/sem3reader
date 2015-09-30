unit get;

interface

type

  TGet = class
    function GetInfo: string; virtual; abstract;
    function GetInSize: word; virtual; abstract;
    procedure Run; virtual; abstract;
    procedure Show; virtual; abstract;
  end;

implementation

end.
