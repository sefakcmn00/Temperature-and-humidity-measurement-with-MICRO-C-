#line 1 "C:/Users/ASUS/Desktop/MicroProje_Sefa Kocaman_174209006_1.ö/YAZILIM DOSYALARI/MÝKRO KODLARI/MyProject.c"




sbit Mmc_Chip_Select at RC2_bit;
sbit Mmc_Chip_Select_Direction at TRISC2_bit;






sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/uses/p18/ds3231.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 38 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/uses/p18/ds3231.c"
typedef enum
{
 SUNDAY = 1,
 MONDAY,
 TUESDAY,
 WEDNESDAY,
 THURSDAY,
 FRIDAY,
 SATURDAY
} RTC_DOW;

typedef enum
{
 JANUARY = 1,
 FEBRUARY,
 MARCH,
 APRIL,
 MAY,
 JUNE,
 JULY,
 AUGUST,
 SEPTEMBER,
 OCTOBER,
 NOVEMBER,
 DECEMBER
} RTC_Month;

typedef struct rtc_tm
{
 uint8_t seconds;
 uint8_t minutes;
 uint8_t hours;
 RTC_DOW dow;
 uint8_t day;
 RTC_Month month;
 uint8_t year;
} RTC_Time;

typedef enum
{
 ONCE_PER_SECOND = 0x0F,
 SECONDS_MATCH = 0x0E,
 MINUTES_SECONDS_MATCH = 0x0C,
 HOURS_MINUTES_SECONDS_MATCH = 0x08,
 DATE_HOURS_MINUTES_SECONDS_MATCH = 0x0,
 DAY_HOURS_MINUTES_SECONDS_MATCH = 0x10
} al1;

typedef enum
{
 ONCE_PER_MINUTE = 0x0E,
 MINUTES_MATCH = 0x0C,
 HOURS_MINUTES_MATCH = 0x08,
 DATE_HOURS_MINUTES_MATCH = 0x0,
 DAY_HOURS_MINUTES_MATCH = 0x10
} al2;

typedef enum
{
 OUT_OFF = 0x00,
 OUT_INT = 0x04,
 OUT_1Hz = 0x40,
 OUT_1024Hz = 0x48,
 OUT_4096Hz = 0x50,
 OUT_8192Hz = 0x58
} INT_SQW;

RTC_Time c_time, c_alarm1, c_alarm2;



uint8_t bcd_to_decimal(uint8_t number);
uint8_t decimal_to_bcd(uint8_t number);
uint8_t alarm_cfg(uint8_t n, uint8_t i);
void RTC_Set(RTC_Time *time_t);
RTC_Time *RTC_Get();
void Alarm1_Set(RTC_Time *time_t, al1 _config);
RTC_Time *Alarm1_Get();
void Alarm1_Enable();
void Alarm1_Disable();
uint8_t Alarm1_IF_Check();
void Alarm1_IF_Reset();
uint8_t Alarm1_Status();
void Alarm2_Set(RTC_Time *time_t, al2 _config);
RTC_Time *Alarm2_Get();
void Alarm2_Enable();
void Alarm2_Disable();
uint8_t Alarm2_IF_Check();
void Alarm2_IF_Reset();
uint8_t Alarm2_Status();
void IntSqw_Set(INT_SQW _config);
void Enable_32kHZ();
void Disable_32kHZ();
void OSC_Start();
void OSC_Stop();
int16_t Get_Temperature();
uint8_t RTC_Read_Reg(uint8_t reg_address);
void RTC_Write_Reg(uint8_t reg_address, uint8_t reg_value);




uint8_t bcd_to_decimal(uint8_t number)
{
 return ( (number >> 4) * 10 + (number & 0x0F) );
}


uint8_t decimal_to_bcd(uint8_t number)
{
 return ( ((number / 10) << 4) + (number % 10) );
}


uint8_t alarm_cfg(uint8_t n, uint8_t i)
{
 if( n & (1 << i) )
 return 0x80;
 else
 return 0;
}


void RTC_Set(RTC_Time *time_t)
{

 time_t->day = decimal_to_bcd(time_t->day);
 time_t->month = decimal_to_bcd(time_t->month);
 time_t->year = decimal_to_bcd(time_t->year);
 time_t->hours = decimal_to_bcd(time_t->hours);
 time_t->minutes = decimal_to_bcd(time_t->minutes);
 time_t->seconds = decimal_to_bcd(time_t->seconds);



  I2C2_Start ();
  I2C2_Wr ( 0xD0 );
  I2C2_Wr ( 0x00 );
  I2C2_Wr (time_t->seconds);
  I2C2_Wr (time_t->minutes);
  I2C2_Wr (time_t->hours);
  I2C2_Wr (time_t->dow);
  I2C2_Wr (time_t->day);
  I2C2_Wr (time_t->month);
  I2C2_Wr (time_t->year);
  I2C2_Stop ();
}


RTC_Time *RTC_Get()
{
  I2C2_Start ();
  I2C2_Wr ( 0xD0 );
  I2C2_Wr ( 0x00 );
  I2C2_Repeated_Start ();
  I2C2_Wr ( 0xD0  | 0x01);
 c_time.seconds =  I2C2_Rd (1);
 c_time.minutes =  I2C2_Rd (1);
 c_time.hours =  I2C2_Rd (1);
 c_time.dow =  I2C2_Rd (1);
 c_time.day =  I2C2_Rd (1);
 c_time.month =  I2C2_Rd (1);
 c_time.year =  I2C2_Rd (0);
  I2C2_Stop ();


 c_time.seconds = bcd_to_decimal(c_time.seconds);
 c_time.minutes = bcd_to_decimal(c_time.minutes);
 c_time.hours = bcd_to_decimal(c_time.hours);
 c_time.day = bcd_to_decimal(c_time.day);
 c_time.month = bcd_to_decimal(c_time.month);
 c_time.year = bcd_to_decimal(c_time.year);


 return &c_time;
}


void Alarm1_Set(RTC_Time *time_t, al1 _config)
{

 time_t->day = decimal_to_bcd(time_t->day);
 time_t->hours = decimal_to_bcd(time_t->hours);
 time_t->minutes = decimal_to_bcd(time_t->minutes);
 time_t->seconds = decimal_to_bcd(time_t->seconds);



  I2C2_Start ();
  I2C2_Wr ( 0xD0 );
  I2C2_Wr ( 0x07 );
  I2C2_Wr ( time_t->seconds | alarm_cfg(_config, 0) );
  I2C2_Wr ( time_t->minutes | alarm_cfg(_config, 1) );
  I2C2_Wr ( time_t->hours | alarm_cfg(_config, 2) );
 if ( _config & 0x10 )
  I2C2_Wr ( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
 else
  I2C2_Wr ( time_t->day | alarm_cfg(_config, 3) );
  I2C2_Stop ();
}


RTC_Time *Alarm1_Get()
{
  I2C2_Start ();
  I2C2_Wr ( 0xD0 );
  I2C2_Wr ( 0x07 );
  I2C2_Repeated_Start ();
  I2C2_Wr ( 0xD0  | 0x01);
 c_alarm1.seconds =  I2C2_Rd (1) & 0x7F;
 c_alarm1.minutes =  I2C2_Rd (1) & 0x7F;
 c_alarm1.hours =  I2C2_Rd (1) & 0x3F;
 c_alarm1.dow = c_alarm1.day =  I2C2_Rd (0) & 0x3F;
  I2C2_Stop ();


 c_alarm1.seconds = bcd_to_decimal(c_alarm1.seconds);
 c_alarm1.minutes = bcd_to_decimal(c_alarm1.minutes);
 c_alarm1.hours = bcd_to_decimal(c_alarm1.hours);
 c_alarm1.day = bcd_to_decimal(c_alarm1.day);


 return &c_alarm1;
}


void Alarm1_Enable()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg |= 0x01;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


void Alarm1_Disable()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg &= 0xFE;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


uint8_t Alarm1_IF_Check()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 if(stat_reg & 0x01)
 return 1;
 else
 return 0;
}


void Alarm1_IF_Reset()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 stat_reg &= 0xFE;
 RTC_Write_Reg( 0x0F , stat_reg);
}


uint8_t Alarm1_Status()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 if(ctrl_reg & 0x01)
 return 1;
 else
 return 0;
}


void Alarm2_Set(RTC_Time *time_t, al2 _config)
{

 time_t->day = decimal_to_bcd(time_t->day);
 time_t->hours = decimal_to_bcd(time_t->hours);
 time_t->minutes = decimal_to_bcd(time_t->minutes);



  I2C2_Start ();
  I2C2_Wr ( 0xD0 );
  I2C2_Wr ( 0x0B );
  I2C2_Wr ( (time_t->minutes) | alarm_cfg(_config, 1) );
  I2C2_Wr ( (time_t->hours) | alarm_cfg(_config, 2) );
 if ( _config & 0x10 )
  I2C2_Wr ( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
 else
  I2C2_Wr ( time_t->day | alarm_cfg(_config, 3) );
  I2C2_Stop ();
}


RTC_Time *Alarm2_Get()
{
  I2C2_Start ();
  I2C2_Wr ( 0xD0 );
  I2C2_Wr ( 0x0B );
  I2C2_Repeated_Start ();
  I2C2_Wr ( 0xD0  | 0x01);
 c_alarm2.minutes =  I2C2_Rd (1) & 0x7F;
 c_alarm2.hours =  I2C2_Rd (1) & 0x3F;
 c_alarm2.dow = c_alarm2.day =  I2C2_Rd (0) & 0x3F;
  I2C2_Stop ();


 c_alarm2.minutes = bcd_to_decimal(c_alarm2.minutes);
 c_alarm2.hours = bcd_to_decimal(c_alarm2.hours);
 c_alarm2.day = bcd_to_decimal(c_alarm2.day);

 c_alarm2.seconds = 0;
 return &c_alarm2;
}


void Alarm2_Enable()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg |= 0x02;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


void Alarm2_Disable()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg &= 0xFD;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


uint8_t Alarm2_IF_Check()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 if(stat_reg & 0x02)
 return 1;
 else
 return 0;
}


void Alarm2_IF_Reset()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 stat_reg &= 0xFD;
 RTC_Write_Reg( 0x0F , stat_reg);
}


uint8_t Alarm2_Status()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 if(ctrl_reg & 0x02)
 return 1;
 else
 return 0;
}


void RTC_Write_Reg(uint8_t reg_address, uint8_t reg_value)
{
  I2C2_Start ();
  I2C2_Wr ( 0xD0 );
  I2C2_Wr (reg_address);
  I2C2_Wr (reg_value);
  I2C2_Stop ();
}


uint8_t RTC_Read_Reg(uint8_t reg_address)
{
 uint8_t reg_data;

  I2C2_Start ();
  I2C2_Wr ( 0xD0 );
  I2C2_Wr (reg_address);
  I2C2_Repeated_Start ();
  I2C2_Wr ( 0xD0  | 0x01);
 reg_data =  I2C2_Rd (0);
  I2C2_Stop ();

 return reg_data;
}


void IntSqw_Set(INT_SQW _config)
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg &= 0xA3;
 ctrl_reg |= _config;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


void Enable_32kHZ()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 stat_reg |= 0x08;
 RTC_Write_Reg( 0x0F , stat_reg);
}


void Disable_32kHZ()
{
 uint8_t stat_reg = RTC_Read_Reg( 0x0F );
 stat_reg &= 0xF7;
 RTC_Write_Reg( 0x0F , stat_reg);
}


void OSC_Start()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg &= 0x7F;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}


void OSC_Stop()
{
 uint8_t ctrl_reg = RTC_Read_Reg( 0x0E );
 ctrl_reg |= 0x80;
 RTC_Write_Reg( 0x0E , ctrl_reg);
}



int16_t Get_Temperature()
{
 uint8_t t_msb, t_lsb;
 uint16_t c_temp;
  I2C2_Start ();
  I2C2_Wr ( 0xD0 );
  I2C2_Wr ( 0x11 );
  I2C2_Repeated_Start ();
  I2C2_Wr ( 0xD0  | 0x01);
 t_msb =  I2C2_Rd (1);
 t_lsb =  I2C2_Rd (0);
  I2C2_Stop ();

 c_temp = (uint16_t)t_msb << 2 | t_lsb >> 6;

 if(t_msb & 0x80)
 c_temp |= 0xFC00;

 return c_temp * 25;
}
#line 33 "C:/Users/ASUS/Desktop/MicroProje_Sefa Kocaman_174209006_1.ö/YAZILIM DOSYALARI/MÝKRO KODLARI/MyProject.c"
RTC_Time *mytime;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/fat32 library/uses/__lib_fat32.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"
#line 30 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/fat32 library/uses/__lib_fat32.h"
static const uint16_t SECTOR_SIZE = 512;









static const uint8_t
 FILE_READ = 0x01,
 FILE_WRITE = 0x02,
 FILE_APPEND = 0x04;






static const uint8_t
 ATTR_NONE = 0x00,
 ATTR_READ_ONLY = 0x01,
 ATTR_HIDDEN = 0x02,
 ATTR_SYSTEM = 0x04,
 ATTR_VOLUME_ID = 0x08,
 ATTR_DIRECTORY = 0x10,
 ATTR_ARCHIVE = 0x20,
 ATTR_DEVICE = 0x40,

 ATTR_RESERVED = 0x80;

static const uint8_t
 ATTR_LONG_NAME = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_VOLUME_ID;

static const uint8_t
 ATTR_FILE_MASK = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_ARCHIVE,

 ATTR_LONG_NAME_MASK = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_VOLUME_ID |
 ATTR_DIRECTORY |
 ATTR_ARCHIVE;






static const int8_t



 OK = 0,
 ERROR = -1,
 FOUND = 1,



 E_READ = -1,
 E_WRITE = -2,
 E_INIT_CARD = -3,
 E_BOOT_SIGN = -4,
 E_BOOT_REC = -5,
 E_FILE_SYS_INFO = -6,
 E_DEVICE_SIZE = -7,
 E_FAT_TYPE = -8,
 E_VOLUME_LABEL = -9,



 E_LAST_ENTRY = -10,
 E_FREE_ENTRY = -11,
 E_CLUST_NUM = -12,
 E_NO_SWAP_SPACE = -13,
 E_NO_SPACE = -14,
 E_LAST_CLUST = -15,



 E_DIR_NAME = -20,
 E_ISNT_DIR = -21,
 E_DIR_EXISTS = -22,
 E_DIR_NOTFOUND = -23,
 E_DIR_NOTEMPTY = -24,
 E_DIR_SIZE = -25,



 E_FILE_NAME = -30,
 E_ISNT_FILE = -31,
 E_FILE_EXISTS = -32,
 E_FILE_NOTFOUND = -33,
 E_FILE_NOTEMPTY = -34,
 E_MAX_FILES = -35,
 E_FILE_NOTOPENED = -36,
 E_FILE_EOF = -37,
 E_FILE_READ = -38,
 E_FILE_WRITE = -39,
 E_FILE_HANDLE = -40,
 E_FILE_READ_ONLY = -41,
 E_FILE_OPENED = -42,



 E_TIME_YEAR = -50,
 E_TIME_MONTH = -51,
 E_TIME_DAY = -52,
 E_TIME_HOUR = -53,
 E_TIME_MINUTE = -54,
 E_TIME_SECOND = -55,



 E_NAME_NULL = -60,
 E_CHAR_UNALLOWED = -61,
 E_LFN_ORD = -62,
 E_LFN_CHK = -63,
 E_LFN_ATTR = -64,
 E_LFN_MAX_SINONIM = -65,
 E_NAME_TOLONG = -66,
 E_NAME_EXIST = -67,



 E_PARAM = -80,
 E_REAPCK = -81,
 E_DELETE = -82,
 E_DELETE_NUM = -83,
 E_ATTR = -84;



typedef struct
{
 uint8_t State[1];
 uint8_t __1[3];
 uint8_t Type[1];
 uint8_t __2[3];
 uint8_t Boot[4];
 uint8_t Size[4];
}
FAT32_PART;



typedef struct
{
 uint8_t __1[446];
 FAT32_PART Part[4];
 uint8_t BootSign[2];
}
FAT32_MBR;



typedef struct
{
 uint8_t JmpCode[3];
 uint8_t __1[8];
 uint8_t BytesPSect[2];
 uint8_t SectsPClust[1];
 uint8_t Reserved[2];
 uint8_t FATCopies[1];
 uint8_t RootEntries[2];
 uint8_t __2[2];
 uint8_t MediaDesc[1];
 uint8_t __3[10];
 uint8_t Sects[4];
 uint8_t SectsPFAT[4];
 uint8_t Flags[2];
 uint8_t __4[2];
 uint8_t RootClust[4];
 uint8_t FSISect[2];
 uint8_t BootBackup[2];
 uint8_t __5[14];
 uint8_t ExtSign[1];
 uint8_t __6[4];
 uint8_t VolName[11];
 uint8_t FATName[8];
 uint8_t __7[420];
 uint8_t BootSign[2];
}
FAT32_BR;



typedef struct
{
 uint8_t LeadSig[4];
 uint8_t __1[480];
 uint8_t StrucSig[4];
 uint8_t FreeCount[4];
 uint8_t NextFree[4];
 uint8_t __2[14];
 uint8_t TrailSig[2];
}
FAT32_FSI;


typedef struct
{
 uint8_t Entry[4];
}
FAT32_FATENT;



typedef struct
{
 uint8_t NameExt[11];
 uint8_t Attrib[1];
 uint8_t NT[1];
 uint8_t __1[1];
 uint8_t CTime[2];
 uint8_t CDate[2];
 uint8_t ATime[2];
 uint8_t HiClust[2];
 uint8_t MTime[2];
 uint8_t MDate[2];
 uint8_t LoClust[2];
 uint8_t Size[4];
}
FAT32_DIRENT;



typedef struct
{
 uint8_t OrdField[1];
 uint8_t UC0[2];
 uint8_t UC1[2];
 uint8_t UC2[2];
 uint8_t UC3[2];
 uint8_t UC4[2];
 uint8_t Attrib[1];
 uint8_t __1[1];
 uint8_t Checksum[1];
 uint8_t UC5[2];
 uint8_t UC6[2];
 uint8_t UC7[2];
 uint8_t UC8[2];
 uint8_t UC9[2];
 uint8_t UC10[2];
 uint8_t __2[2];
 uint8_t UC11[2];
 uint8_t UC12[2];
}
FAT32_LFNENT;



typedef uint32_t __CLUSTER;
typedef uint32_t __SECTOR;
typedef uint32_t __ENTRY;

typedef int8_t __HANDLE;



typedef struct
{
 uint16_t Year;
 uint8_t Month;
 uint8_t Day;
 uint8_t Hour;
 uint8_t Minute;
 uint8_t Second;
}
__TIME;



typedef struct
{
 uint8_t State;
 uint8_t Type;
 __SECTOR Boot;
 uint32_t Size;
}
__PART;



typedef struct
{
 __PART Part[1];
 uint16_t BytesPSect;
 uint8_t SectsPClust;
 uint16_t Reserved;
 uint8_t FATCopies;
 uint32_t SectsPFAT;
 uint16_t Flags;
 __SECTOR FAT;
 __CLUSTER Root;
 uint16_t RootEntries;
 __SECTOR Data;
 __SECTOR FSI;
 uint32_t ClFreeCount;
 __CLUSTER ClNextFree;
}
__INFO;

typedef struct
{
 char Path[270];
 uint16_t Length;
}
__PATH;


typedef struct
{
 char NameExt[255];
 uint8_t Attrib;

 uint32_t Size;
 __CLUSTER _1stClust;

 __CLUSTER EntryClust;
 __ENTRY Entry;
}
__DIR;


typedef struct
{
 __CLUSTER _1stClust;
 __CLUSTER CurrClust;

 __CLUSTER EntryClust;
 __ENTRY Entry;

 uint32_t Cursor;
 uint32_t Length;

 uint8_t Mode;
 uint8_t Attr;
}
__FILE;
#line 381 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/fat32 library/uses/__lib_fat32.h"
typedef struct
{
 __SECTOR fSectNum;
 char fSect[SECTOR_SIZE];
}
__RAW_SECTOR;


extern const char CRLF_F32[];
extern const uint8_t FAT32_MAX_FILES;
extern const uint8_t f32_fsi_template[SECTOR_SIZE];
extern const uint8_t f32_br_template[SECTOR_SIZE];
extern __FILE fat32_fdesc[];
extern __RAW_SECTOR f32_sector;


extern int8_t FAT32_Dev_Init (void);
extern int8_t FAT32_Dev_Read_Sector (__SECTOR sc, char* buf);
extern int8_t FAT32_Dev_Write_Sector (__SECTOR sc, char* buf);
extern int8_t FAT32_Dev_Multi_Read_Stop();
extern int8_t FAT32_Dev_Multi_Read_Sector(char* buf);
extern int8_t FAT32_Dev_Multi_Read_Start(__SECTOR sc);
extern int8_t FAT32_Put_Char (char ch);


int8_t FAT32_Init (void);
int8_t FAT32_Format (char *devLabel);
int8_t FAT32_ScanDisk (uint32_t *totClust, uint32_t *freeClust, uint32_t *badClust);
int8_t FAT32_GetFreeSpace(uint32_t *freeClusts, uint16_t *bytesPerClust);

int8_t FAT32_ChangeDir (char *dname);
int8_t FAT32_MakeDir (char *dname);
int8_t FAT32_Dir (void);
int8_t FAT32_FindFirst (__DIR *pDE);
int8_t FAT32_FindNext (__DIR *pDE);
int8_t FAT32_Delete (char *fn);
int8_t FAT32_DeleteRec (char *fn);
int8_t FAT32_Exists (char *name);
int8_t FAT32_Rename (char *oldName, char *newName);
int8_t FAT32_Open (char *fn, uint8_t mode);
int8_t FAT32_Eof (__HANDLE fHandle);
int8_t FAT32_Read (__HANDLE fHandle, char* rdBuf, uint16_t len);
int8_t FAT32_Write (__HANDLE fHandle, char* wrBuf, uint16_t len);
int8_t FAT32_Seek (__HANDLE fHandle, uint32_t pos);
int8_t FAT32_Tell (__HANDLE fHandle, uint32_t *pPos);
int8_t FAT32_Close (__HANDLE fHandle);
int8_t FAT32_Size (char *fname, uint32_t *pSize);
int8_t FAT32_GetFileHandle(char *fname, __HANDLE *handle);

int8_t FAT32_SetTime (__TIME *pTM);
int8_t FAT32_IncTime (uint32_t Sec);

int8_t FAT32_GetCTime (char *fname, __TIME *pTM);
int8_t FAT32_GetMTime (char *fname, __TIME *pTM);

int8_t FAT32_SetAttr (char *fname, uint8_t attr);
int8_t FAT32_GetAttr (char *fname, uint8_t* attr);

int8_t FAT32_GetError (void);

int8_t FAT32_MakeSwap (char *name, __SECTOR nSc, __CLUSTER *pCl);
int8_t FAT32_ReadSwap (__HANDLE fHandle, char* rdBuf, uint16_t len);
int8_t FAT32_WriteSwap (__HANDLE fHandle, char* wrBuf, uint16_t len);
int8_t FAT32_SeekSwap (__HANDLE fHandle, uint32_t pos);

const char* FAT32_getVersion();
uint8_t* FAT32_GetCurrentPath( void );

__CLUSTER FAT32_SectToClust(__SECTOR sc);
__SECTOR FAT32_ClustToSect(__CLUSTER cl);
#line 37 "C:/Users/ASUS/Desktop/MicroProje_Sefa Kocaman_174209006_1.ö/YAZILIM DOSYALARI/MÝKRO KODLARI/MyProject.c"
__HANDLE fileHandle;


short fat_err;
short i, p_second = 1;


char debounce()
{
 char m, count = 0;
 for(m = 0; m < 5; m++)
 {
 if ( ! RB0_bit  )
 count++;
 delay_ms(10);
 }

 if(count > 2) return 1;
 else return 0;
}


void wait()
{
 unsigned int TMR0_value = 0;
 TMR0L = TMR0H = 0;
 while( (TMR0_value < 62500L) &&  RB0_bit  &&  RB1_bit  )
 TMR0_value = (TMR0H << 8) | TMR0L;
}

char edit(char x_pos, char y_pos, char parameter)
{
 char buffer[3];
 while(debounce());
 sprinti(buffer, "%02u", (int)parameter);

 while(1)
 {
 while( ! RB1_bit  )
 {
 parameter++;
 if(i == 0 && parameter > 23)
 parameter = 0;
 if(i == 1 && parameter > 59)
 parameter = 0;
 if(i == 2 && parameter > 31)
 parameter = 1;
 if(i == 3 && parameter > 12)
 parameter = 1;
 if(i == 4 && parameter > 99)
 parameter = 0;

 sprinti(buffer, "%02u", (int)parameter);
 LCD_Out(y_pos, x_pos, buffer);
 delay_ms(200);
 }

 LCD_Out(y_pos, x_pos, "  ");
 wait();
 LCD_Out(y_pos, x_pos, buffer);
 wait();

 if(! RB0_bit )
 {
 i++;
 return parameter;
 }
 }
}

void dow_print()
{
 switch(mytime->dow)
 {
 case SUNDAY : LCD_Out(2, 7, "PZR"); break;
 case MONDAY : LCD_Out(2, 7, "PZT"); break;
 case TUESDAY : LCD_Out(2, 7, "SAL"); break;
 case WEDNESDAY: LCD_Out(2, 7, "CAR"); break;
 case THURSDAY : LCD_Out(2, 7, "PER"); break;
 case FRIDAY : LCD_Out(2, 7, "CUM"); break;
 default : LCD_Out(2, 7, "CMR");
 }
}

void rtc_print()
{
 char buffer[17];

 dow_print();

 sprinti(buffer, "%02u:%02u:%02u", (int)mytime->hours, (int)mytime->minutes, (int)mytime->seconds);
 LCD_Out(1, 11, buffer);

 sprinti(buffer, "-%02u-%02u-20%02u", (int)mytime->day, (int)mytime->month, (int)mytime->year);
 LCD_Out(2, 10, buffer);
}




void Start_Signal(void)
{
  RB2_bit  = 0;
  TRISB2_bit  = 0;
 delay_ms(25);
  RB2_bit  = 1;
 delay_us(30);
  TRISB2_bit  = 1;
}


char Check_Response()
{
 TMR0L = TMR0H = 0;


 while(! RB2_bit  && TMR0L < 100) ;

 if(TMR0L >= 100)
 return 0;

 TMR0L = TMR0H = 0;


 while( RB2_bit  && TMR0L < 100) ;

 if(TMR0L >= 100)
 return 0;

 return 1;
}


void Read_Data(unsigned short* dht_data)
{
 *dht_data = 0;
 for(i = 0; i < 8; i++)
 {
 TMR0L = TMR0H = 0;

 while(! RB2_bit )
 {
 if(TMR0L > 80);
 }

 TMR0L = TMR0H = 0;

 while( RB2_bit )
 {
 if(TMR0L > 80)
 return;
 }
 if(TMR0L > 40)
 {
 *dht_data |= (1 << (7 - i));
 }
 }


 return;
}




void main()
{
 OSCCON = 0x70;
 ANSELB = 0;
 ANSELC = 0;
 ANSELD = 0;

 RBPU_bit = 0;
 WPUB = 0x03;

 delay_ms(1000);
 Lcd_Init();
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Cmd(_LCD_CLEAR);
 LCD_Out(1, 1, "ZAMAN:");
 LCD_Out(2, 1, "TARIH:");
 LCD_Out(3, 1, "SICAK:");
 LCD_Out(4, 1, "NEM:");


 I2C2_Init(100000);

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

 UART1_Init(9600);
 UART1_Write_Text("\r\n\nFat Kutuphanesi Baslatildi ... ");

 fat_err = FAT32_Init();
 if(fat_err != 0)
 {
 UART1_Write_Text("Fat Kutuphanesi Baslatilamadi!");
 }

 else
 {

 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 UART1_Write_Text("FAT Kutuphanesi Bulundu");
 if(FAT32_Exists("DHT22Log.txt") == 0)
 {

 UART1_Write_Text("\r\n\r\nCreate 'DHT22Log.txt' file ... ");
 fileHandle = FAT32_Open("DHT22Log.txt", FILE_WRITE);
 if(fileHandle == 0){
 UART1_Write_Text("OK");

 FAT32_Write(fileHandle, "    TARIH    |    ZAMAN  | SICAKLIK | NEM\r\n", 49);
 FAT32_Write(fileHandle, "(dd-mm-yyyy)|(hh:mm:ss)|             |\r\n", 40);
 FAT32_Write(fileHandle, "            |          |             |\r\n", 40);

 FAT32_Close(fileHandle);
 }
 else
 UART1_Write_Text("DOSYA HATASI.");
 }
 }

 while(1)
 {

 mytime = RTC_Get();

 rtc_print();

 if( ! RB0_bit  )
 if( debounce() )
 {
 i = 0;
 while( debounce() );
 T0CON = 0x84;

 mytime->hours = edit(11, 1, mytime->hours);
 mytime->minutes = edit(14, 1, mytime->minutes);
 mytime->seconds = 0;

 while(debounce());
 while(1)
 {
 while( ! RB1_bit  )
 {
 mytime->dow++;
 if(mytime->dow > SATURDAY)
 mytime->dow = SUNDAY;
 dow_print();
 delay_ms(500);
 }
 LCD_Out(2, 7, "   ");
 wait();
 dow_print();
 wait();
 if( ! RB0_bit  )
 break;
 }

 mytime->day = edit(11, 2, mytime->day);
 mytime->month = edit(14, 2, mytime->month);
 mytime->year = edit(19, 2, mytime->year);

 TMR0ON_bit = 0;
 while(debounce());

 RTC_Set(mytime);
 }

 if( mytime->seconds != p_second )
 {
 char T_Byte1, T_Byte2, RH_Byte1, RH_Byte2, CheckSum;
 unsigned int Temp, Humi;
 char temp_a[9], humi_a[8];
 bit read_ok;
 p_second = mytime->seconds;
 T0CON = 0x81;

 Start_Signal();
 if(Check_Response())
 {
 Read_Data(&RH_Byte1);
 Read_Data(&RH_Byte2);
 Read_Data(&T_Byte1);
 Read_Data(&T_Byte2);
 Read_Data(&CheckSum);


 if(CheckSum == ((RH_Byte1 + RH_Byte2 + T_Byte1 + T_Byte2) & 0xFF))
 {
 read_ok = 1;
 Humi = (RH_Byte1 << 8) | RH_Byte2;
 Temp = (T_Byte1 << 8) | T_Byte2;

 if(Temp & 0x8000) {
 Temp = Temp & 0x7FFF;
 sprinti(temp_a, "-%02u.%01u%cC ", (Temp/10)%100, Temp % 10, (int)223);
 }
 else
 sprinti(temp_a, " %02u.%01u%cC ", (Temp/10)%100, Temp % 10, (int)223);

 if(humi >= 1000)
 sprinti(humi_a, "1%02u.%01u %%", (humi/10)%100, humi % 10);
 else
 sprinti(humi_a, " %02u.%01u %%", (humi/10)%100, humi % 10);

 }
 else
 {
 read_ok = 0;
 sprinti(temp_a, "Checksum");
 sprinti(humi_a, " Error ");
 }
 }

 else
 {
 read_ok = 0;
 sprinti(temp_a, " Sensor ");
 sprinti(humi_a, " Error ");
 }

 TMR0ON_bit = 0;

 LCD_Out(3, 7, temp_a);
 LCD_Out(4, 7, humi_a);


 if(fat_err == 0)
 {
 char buffer[28];
 sprinti(buffer, " %02u-%02u-20%02u | %02u:%02u:%02u |   ", (int)mytime->day, (int)mytime->month, (int)mytime->year,
 (int)mytime->hours, (int)mytime->minutes, (int)mytime->seconds);

 fileHandle = FAT32_Open("DHT22Log.txt", FILE_APPEND);
 if(fileHandle == 0)
 {
 FAT32_Write(fileHandle, buffer, 27);
 if(read_ok == 1)
 temp_a[5] = '°';
 FAT32_Write(fileHandle, temp_a, 8);
 FAT32_Write(fileHandle, "  | ", 5);
 FAT32_Write(fileHandle, humi_a, 7);
 FAT32_Write(fileHandle, "\r\n", 2);

 FAT32_Close(fileHandle);
 }
 }

 }

 delay_ms(100);

 }

}
