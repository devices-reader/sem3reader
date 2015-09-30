unit kernel;

interface

uses timez;

const
  CANALS        = 512;
  GROUPS        = 64;
  ITEMS         = CANALS;
  MINUTES3      = 60;
  JOURNALS      = 3;
  TARIFFS       = 48;

type
  node = record
    iwCanal:    word;
    boPositive: boolean;
  end;

  group = record
    wSize:      word;
    mpnoNodes:  array[0..CANALS-1] of node;
    stName:     string;
  end;

  digital = record
    n:          word;
    iwDevice:   word;
    dwAddress:  longword;
    wNumber:    word;
    cwCanals:   word;
    wWidth:     word;
    wCanal1:    word;
    mpMask1:    array[0..2-1] of byte;
    mpMask2:    array[0..8-1] of byte;
    sName:      string;
  end;

  canal = record
    iwDigital:  word;
    iwCanal:    word;
    Ktrans:     extended;
    Kpulse:     extended;
    Klosse:     extended;
    bLine:      byte;
    bMask:      byte;
    sName:      string;
  end;

  current = record
    sName:      string;
    sValue:     string;
  end;

  energy = record
    mpeTariff:  array[0..TARIFFS-1] of extended;
    eSum:       extended;
  end;

  maximum = record
    a, b: byte;
    e: extended;
  end;

  maximums = record
    mpTariff:   array[0..TARIFFS-1] of maximum;
  end;

  cnt = record
    eValue: extended;
    tiValue: times;
  end;

  forms = record
    Nominative: string;
    Dative: string;
  end;

  names = record
    Singular: forms;
    Plural: forms;
  end;
const
  panCOMPORT    = 0;
  panREPEATS    = 1;
  panCONNECT    = 2;
  panTIMEOUT    = 3;
  panNOW        = 4;
  panPROGRESS   = 5;

  SETTING:    string  = '���������';
  COM_PORT:   string  = 'COM_����';
  MODEM:      string  = '�����';
  SOCKET:     string  = '�����';
  PARAMS:     string  = '���������';

  NUMBER:     string  = '����';
  BAUD:       string  = '��������';
  PARITY:     string  = '׸������';
  TIMEOUT:    string  = '�������';
  DIAL:       string  = '�����';
  DEVICE:     string  = '����������';
  HOST:       string  = '����';
  PORT:       string  = '����';
  ADDRESS:    string  = '�����';
  PASSWORD:   string  = '������';
  MODE:       string  = '�����';
  VERSION:    string  = '������';

  MINUTES_MIN:    string  = '���������_��';
  MINUTES_COUNT:  string  = '���������_�����';
  HOURS_MIN:      string  = '��������_��';
  HOURS_COUNT:    string  = '��������_�����';
  DAYS_MIN:       string  = '�����_��';
  DAYS_COUNT:     string  = '�����_�����';
  MONTHS_MIN:     string  = '������_��';
  MONTHS_COUNT:   string  = '������_�����';
  CANALS_MIN:     string  = '������_��';
  CANALS_COUNT:   string  = '������_�����';
  GROUPS_MIN:     string  = '������_��';
  GROUPS_COUNT:   string  = '������_�����';
  TARIFFS_MIN:    string  = '������_��';
  TARIFFS_COUNT:  string  = '������_�����';
  DIGITALS_MIN:   string  = '����������_��';
  DIGITALS_COUNT: string  = '����������_�����';
  DIGITALS_LIMIT: string  = '����������_�����';
  INTERVAL_MIN:   string  = '��������_��';
  INTERVAL_COUNT: string  = '��������_�����';
  JOURNAL:        string  = '������';

  DIGITS:     string  = '������_�����_�������';
  COLWIDTH:   string  = '������_�������';

  OPTIONS:    string  = '�����';
  CURRENTS2:  string  = '���������_���������';
  INQUIRY:    string  = '������_';

  LOGS_DIR:   string  = 'log';

  CURRENTS_COUNT = 23;
  CURRENTS:   array[0..CURRENTS_COUNT-1] of current = (
    (sName:'P1';sValue:'��'),
    (sName:'P2';sValue:'��'),
    (sName:'P3';sValue:'��'),
    (sName:'P';sValue:'��'),
    (sName:'Q1';sValue:'���'),
    (sName:'Q2';sValue:'���'),
    (sName:'Q3';sValue:'���'),
    (sName:'Q';sValue:'���'),
    (sName:'S1';sValue:'��'),
    (sName:'S2';sValue:'��'),
    (sName:'S3';sValue:'��'),
    (sName:'S';sValue:'��'),
    (sName:'cos�1';sValue:''),
    (sName:'cos�2';sValue:''),
    (sName:'cos�3';sValue:''),
    (sName:'cos�';sValue:''),
    (sName:'U1';sValue:'�'),
    (sName:'U2';sValue:'�'),
    (sName:'U3';sValue:'�'),
    (sName:'I1';sValue:'�'),
    (sName:'I2';sValue:'�'),
    (sName:'I3';sValue:'�'),
    (sName:'f';sValue:'��')
  );

  CANAL_NAMES: names = (
    Singular:(Nominative:'�����'; Dative: '������');
    Plural:(Nominative:'������'; Dative: '�������')
  );

  GROUP_NAMES: names = (
    Singular:(Nominative:'������'; Dative: '������');
    Plural:(Nominative:'������'; Dative: '�������')
  );

  DAY_NAMES: names = (
    Singular:(Nominative:'�����'; Dative: '������');
    Plural:(Nominative:'�����'; Dative: '������')
  );

  MONTH_NAMES: names = (
    Singular:(Nominative:'�����'; Dative: '������');
    Plural:(Nominative:'������'; Dative: '�������')
  );

implementation

end.
