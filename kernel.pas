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

  SETTING:    string  = 'Настройки';
  COM_PORT:   string  = 'COM_порт';
  MODEM:      string  = 'Модем';
  SOCKET:     string  = 'Сокет';
  PARAMS:     string  = 'Параметры';

  NUMBER:     string  = 'Порт';
  BAUD:       string  = 'Скорость';
  PARITY:     string  = 'Чётность';
  TIMEOUT:    string  = 'Таймаут';
  DIAL:       string  = 'Номер';
  DEVICE:     string  = 'Устройство';
  HOST:       string  = 'Хост';
  PORT:       string  = 'Порт';
  ADDRESS:    string  = 'Адрес';
  PASSWORD:   string  = 'Пароль';
  MODE:       string  = 'Режим';
  VERSION:    string  = 'Версия';

  MINUTES_MIN:    string  = 'Техминуты_от';
  MINUTES_COUNT:  string  = 'Техминуты_всего';
  HOURS_MIN:      string  = 'Получасы_от';
  HOURS_COUNT:    string  = 'Получасы_всего';
  DAYS_MIN:       string  = 'Сутки_от';
  DAYS_COUNT:     string  = 'Сутки_всего';
  MONTHS_MIN:     string  = 'Месяцы_от';
  MONTHS_COUNT:   string  = 'Месяцы_всего';
  CANALS_MIN:     string  = 'Каналы_от';
  CANALS_COUNT:   string  = 'Каналы_всего';
  GROUPS_MIN:     string  = 'Группы_от';
  GROUPS_COUNT:   string  = 'Группы_всего';
  TARIFFS_MIN:    string  = 'Тарифы_от';
  TARIFFS_COUNT:  string  = 'Тарифы_всего';
  DIGITALS_MIN:   string  = 'Устройства_от';
  DIGITALS_COUNT: string  = 'Устройства_всего';
  DIGITALS_LIMIT: string  = 'Устройства_лимит';
  INTERVAL_MIN:   string  = 'Интервал_от';
  INTERVAL_COUNT: string  = 'Интервал_всего';
  JOURNAL:        string  = 'Журнал';

  DIGITS:     string  = 'Знаков_после_запятой';
  COLWIDTH:   string  = 'Ширина_столбца';

  OPTIONS:    string  = 'Опции';
  CURRENTS2:  string  = 'Мгновнные_параметры';
  INQUIRY:    string  = 'Запрос_';

  LOGS_DIR:   string  = 'log';

  CURRENTS_COUNT = 23;
  CURRENTS:   array[0..CURRENTS_COUNT-1] of current = (
    (sName:'P1';sValue:'Вт'),
    (sName:'P2';sValue:'Вт'),
    (sName:'P3';sValue:'Вт'),
    (sName:'P';sValue:'Вт'),
    (sName:'Q1';sValue:'ВАР'),
    (sName:'Q2';sValue:'ВАР'),
    (sName:'Q3';sValue:'ВАР'),
    (sName:'Q';sValue:'ВАР'),
    (sName:'S1';sValue:'ВА'),
    (sName:'S2';sValue:'ВА'),
    (sName:'S3';sValue:'ВА'),
    (sName:'S';sValue:'ВА'),
    (sName:'cosФ1';sValue:''),
    (sName:'cosФ2';sValue:''),
    (sName:'cosФ3';sValue:''),
    (sName:'cosФ';sValue:''),
    (sName:'U1';sValue:'В'),
    (sName:'U2';sValue:'В'),
    (sName:'U3';sValue:'В'),
    (sName:'I1';sValue:'А'),
    (sName:'I2';sValue:'А'),
    (sName:'I3';sValue:'А'),
    (sName:'f';sValue:'Гц')
  );

  CANAL_NAMES: names = (
    Singular:(Nominative:'канал'; Dative: 'каналу');
    Plural:(Nominative:'каналы'; Dative: 'каналам')
  );

  GROUP_NAMES: names = (
    Singular:(Nominative:'группа'; Dative: 'группе');
    Plural:(Nominative:'группы'; Dative: 'группам')
  );

  DAY_NAMES: names = (
    Singular:(Nominative:'сутки'; Dative: 'суткам');
    Plural:(Nominative:'сутки'; Dative: 'суткам')
  );

  MONTH_NAMES: names = (
    Singular:(Nominative:'месяц'; Dative: 'месяцу');
    Plural:(Nominative:'месяцы'; Dative: 'месяцам')
  );

implementation

end.
