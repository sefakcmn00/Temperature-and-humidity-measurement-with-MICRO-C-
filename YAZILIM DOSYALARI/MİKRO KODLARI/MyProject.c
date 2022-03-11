


// SD kart çipi pin baðlantýsýný seç
sbit Mmc_Chip_Select           at RC2_bit;
sbit Mmc_Chip_Select_Direction at TRISC2_bit;

// DHT22 sensör baðlantýsý (burada data pini RB2 pinine baðlýdýr)
#define DHT22_PIN         RB2_bit
#define DHT22_PIN_DIR     TRISB2_bit

// LCD module baðlantýsý
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


// button tanýmlarý
#define button1      RB0_bit   // B1 butonu RB0 pinine baðlandý
#define button2      RB1_bit   // B2 butonu RB1 pinine baðlandý

#define DS3231_I2C2    // use hardware I2C2 moodule (MSSP2) for DS3231 RTC
#include <DS3231.c>    //  DS3231 RTC kütüphanesi dahil ediyoruz.
RTC_Time *mytime;      // DS3231 Kütüphanesinin baðlantýsý

//  __Lib_FAT32.h  kütüphanesi dahil ediyoruz
#include "__Lib_FAT32.h"
__HANDLE fileHandle;     // FAT32 kütüphanesinden fileHandle aktif ediyoruz

// Diðer ana deðiþkenler
short fat_err;
short i, p_second = 1;

// B1  butonun lcd ilerlemesi için yazýlmýþ kod blogu
char debounce()
{
  char m, count = 0;
  for(m = 0; m < 5; m++)
  {
    if ( !button1 )
      count++;
    delay_ms(10);
  }

  if(count > 2)  return 1;
  else           return 0;
}

//  Geciklemeli baðlantý saðlýyoruz
void wait()
{
  unsigned int TMR0_value = 0;
  TMR0L = TMR0H = 0;
  while( (TMR0_value < 62500L) && button1 && button2 )
    TMR0_value = (TMR0H << 8) | TMR0L;
}

char edit(char x_pos, char y_pos, char parameter)
{
  char buffer[3];
  while(debounce());  // B1 butonuna basýldýðýnda deðiþmesi için deðiþken
  sprinti(buffer, "%02u", (int)parameter);

  while(1)
  {
    while( !button2 )
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

    if(!button1) // Buton 1 basýldýgýnda döngüye giriyor
    {
      i++;                // Diðer parametreye geçiyor
      return parameter;   // Parametreye dönüyor ve çýkýyor
    }
  }
}

void dow_print()
{
  switch(mytime->dow)
  {
    case SUNDAY   :  LCD_Out(2, 7, "PZR");  break;
    case MONDAY   :  LCD_Out(2, 7, "PZT");  break;
    case TUESDAY  :  LCD_Out(2, 7, "SAL");  break;
    case WEDNESDAY:  LCD_Out(2, 7, "CAR");  break;
    case THURSDAY :  LCD_Out(2, 7, "PER");  break;
    case FRIDAY   :  LCD_Out(2, 7, "CUM");  break;
    default       :  LCD_Out(2, 7, "CMR");
  }
}

void rtc_print()
{
  char buffer[17];
  // hafta ve günün yazdýrýlmasý
  dow_print();
  // zamanýn yazdýrýlmasý
  sprinti(buffer, "%02u:%02u:%02u", (int)mytime->hours, (int)mytime->minutes, (int)mytime->seconds);
  LCD_Out(1, 11, buffer);
  // tarihin yazdýrýlmasý
  sprinti(buffer, "-%02u-%02u-20%02u", (int)mytime->day, (int)mytime->month, (int)mytime->year);
  LCD_Out(2, 10, buffer);
}

//////////////////////////////////////// DHT22 Fonksiyonu ////////////////////////////////////////

// send start signal to the sensor
void Start_Signal(void)
{
  DHT22_PIN     = 0;   // DHT22 pinine 0 volt gönderilmesi
  DHT22_PIN_DIR = 0;   // Çýkýsýnýn ayarlanmasý
  delay_ms(25);        // 25 mikrosaniye bekliyor
  DHT22_PIN     = 1;   // pine 5 volt gönderilmesi
  delay_us(30);        // 30 mikrosaniye bekliyor
  DHT22_PIN_DIR = 1;
}

// Sensörlerin Kontrol edilmesi
char Check_Response()
{
  TMR0L = TMR0H = 0;  // Reseet tuþuna 0 volt gönderilmesi

  // DHT22_PIN yükselene kadar bekleyin (80µs düþük zaman yanýtýnýn kontrolü)
  while(!DHT22_PIN && TMR0L < 100) ;

  if(TMR0L >= 100)  // yanýt süresi > 80µS ==> yanýt hatasý ise
    return 0;       // 0 döndür (cihazýn yanýt vermede bir sorunu var)

  TMR0L = TMR0H = 0;  // dinlenme Timer0 düþük ve yüksek kayýtlar

  // DHT22_PIN düþük olana kadar bekleyin (80µs yüksek zaman yanýtýnýn kontrol edilmesi
  while(DHT22_PIN && TMR0L < 100) ;

  if(TMR0L >= 100)  // yanýt süresi > 80µS ==> yanýt hatasý ise
    return 0;       // 0 döndür (cihazýn yanýt vermede bir sorunu var)

  return 1;   // döngüye tekrar sokuluyor 1 (yanýt tamam)
}

// Veri fonskiyonun okunmasý
void Read_Data(unsigned short* dht_data)
{
  *dht_data = 0;
  for(i = 0; i < 8; i++)
  {
    TMR0L = TMR0H = 0;

    while(!DHT22_PIN)
    {
      if(TMR0L > 80);
    }

    TMR0L = TMR0H = 0;

    while(DHT22_PIN)
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



// Ana fonskiyon
void main()
{
  OSCCON = 0x70;      // dahili osilatörü 16MHz'e ayarlýyoruz
  ANSELB = 0;         // tüm PORTB pinlerini dijital olarak yapýlandýrýyoruz
  ANSELC = 0;         // tüm PORTC pinlerini dijital olarak yapýlandýrýyoruz
  ANSELD = 0;         // tüm PORTD pinlerini dijital olarak yapýlandýrýyoruz
  // RB0 ve RB1 dahili pull-up'larýný etkinleþtirin
  RBPU_bit  = 0;      // RBPU bitini temizle (INTCON2.7)
  WPUB      = 0x03;   // WPUB kaydý = 0b00000011

  delay_ms(1000);           // 1 saniye bekliyoruz
  Lcd_Init();               // LCD modülünü baþlatyoruz
  Lcd_Cmd(_LCD_CURSOR_OFF); // Ýmleci kapatýyoruz
  Lcd_Cmd(_LCD_CLEAR);      // LCD temizleme Komutu
  LCD_Out(1, 1, "ZAMAN:");
  LCD_Out(2, 1, "TARIH:");
  LCD_Out(3, 1, "SICAK:");
  LCD_Out(4, 1, "NEM:");

  // 100KHz saat frekansý ile I2C2 modülünü baþlat
  I2C2_Init(100000);
  // SPI1 modülünü en düþük hýzda baþlat
  SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);

  UART1_Init(9600);   // UART1 modülünü 9600 baud'da baþlat
  UART1_Write_Text("\r\n\nFat Kutuphanesi Baslatildi ... ");

  fat_err = FAT32_Init();
  if(fat_err != 0)
  {  // FAT32 kitaplýðý baþlatýlýrken bir sorun oluþtuysa
    UART1_Write_Text("Fat Kutuphanesi Baslatilamadi!");
  }

  else
  {  // FAT32 kitaplýðý (& SD kart) baþlatýldý (baþlatýldý)
    // SPI1 modülünü en yüksek hýzda yeniden baþlat
    SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
    UART1_Write_Text("FAT Kutuphanesi Bulundu");
    if(FAT32_Exists("DHT22Log.txt") == 0)   // 'DHT22.Log.txt' adlý dosyanýn mevcut olup olmadýðýný test edin
    {
      // 'DHT22Log.txt' adlý bir metin dosyasý oluþturun
      UART1_Write_Text("\r\n\r\nCreate 'DHT22Log.txt' file ... ");
      fileHandle = FAT32_Open("DHT22Log.txt", FILE_WRITE);
      if(fileHandle == 0){
        UART1_Write_Text("OK");
        // 'DHT22Log.txt' dosyasýna bazý metinler yazýn
        FAT32_Write(fileHandle, "    TARIH    |    ZAMAN  | SICAKLIK | NEM\r\n", 49);
        FAT32_Write(fileHandle, "(dd-mm-yyyy)|(hh:mm:ss)|             |\r\n", 40);
        FAT32_Write(fileHandle, "            |          |             |\r\n", 40);
        // þimdi 'DHT22Log.txt' dosyasýný kapatýn
        FAT32_Close(fileHandle);
      }
      else
        UART1_Write_Text("DOSYA HATASI.");
    }
  }

  while(1)
  {
    // RTC çipinden geçerli saati ve tarihi oku
    mytime = RTC_Get();
    // tüm RTC verilerini yazdýr
    rtc_print();

    if( !button1 )    // B1 düðmesine basýlýrsa
    if( debounce() )  // geri dönme iþlevini çaðýr (B1'e basýldýðýndan emin olun) Geri dönme iþlevini çaðýr (B1'e basýldýðýndan emin olun)
    {
      i = 0;
      while( debounce() );  // geri dönme iþlevini çaðýrýn (B1 düðmesinin serbest býrakýlmasýný bekleyin)
      T0CON  = 0x84;        // Timer0 modülünü etkinleþtir (16-bit zamanlayýcý ve ön ölçekleyici = 32)

      mytime->hours   = edit(11, 1, mytime->hours);    // Saati Ayarla
      mytime->minutes = edit(14, 1, mytime->minutes);  // Dakikayý Ayarla
      mytime->seconds = 0;                             // Saniyeyi resetle

      while(debounce());  // geri dönme iþlevini çaðýrýn (B1'in serbest býrakýlmasýný bekleyin)
      while(1)
      {
        while( !button2 )  //  B2 düðmesine basýlýrsa
        {
          mytime->dow++;
          if(mytime->dow > SATURDAY)
            mytime->dow = SUNDAY;
          dow_print();     // haftanýn gününü yazdýr
          delay_ms(500);   // yarým saniye bekle
        }
        LCD_Out(2, 7, "   ");
        wait();         //  wait()    fonsiyonun çaðýr
        dow_print();    // haftanýn gününü yazdýr
        wait();
        if( !button1 )
          break;
      }

      mytime->day     = edit(11, 2, mytime->day);      // günü düzenle (ayýn günü)
      mytime->month   = edit(14, 2, mytime->month);    // ayý düzenle
      mytime->year    = edit(19, 2, mytime->year);     // yýlý düzenle

      TMR0ON_bit = 0;     // Timer0 modülünü devre dýþý býrak
      while(debounce());  //geri dönme iþlevini çaðýrýn (B1 düðmesinin serbest býrakýlmasýný bekleyin)
      // RTC çipine veri yaz
      RTC_Set(mytime);
    }

    if( mytime->seconds != p_second )
    {   // her 1 saniyede bir sensörden sýcaklýk deðerini oku ve yazdýr
      char T_Byte1, T_Byte2, RH_Byte1, RH_Byte2, CheckSum;
      unsigned int Temp, Humi;
      char temp_a[9], humi_a[8];
      bit read_ok;
      p_second = mytime->seconds;  // geçerli saniyeyi kaydet
      T0CON  = 0x81;   // Timer0 modülünü etkinleþtir (16-bit zamanlayýcý ve ön ölçekleyici = 4)

      Start_Signal();  // sensöre bir baþlangýç ??sinyali gönder
      if(Check_Response())  // sensörden yanýt gelip gelmediðini kontrol edin (Tamam ise nem ve sýcaklýk verilerini okumaya baþlayýn)
      {
        Read_Data(&RH_Byte1);  //  humidity 1st byte okumasý ve kaydedilmesi RH_Byte1
        Read_Data(&RH_Byte2);  //  humidity 2nd byte okunmasý ve kaydedilmesi H_Byte2
        Read_Data(&T_Byte1);   //  sýcaklýk 1st byte okunmasý ve yazýlmasý  T_Byte1
        Read_Data(&T_Byte2);   //  sýcaklýk  2nd byte okunmasý  ve  yazýlmasý T_Byte2
        Read_Data(&CheckSum);  // saðlama toplamýný okuyun ve deðerini CheckSum'a kaydedin

        // tüm verilerin doðru gönderilip gönderilmediðini test edin
        if(CheckSum == ((RH_Byte1 + RH_Byte2 + T_Byte1 + T_Byte2) & 0xFF))
        {
          read_ok = 1;
          Humi = (RH_Byte1 << 8) | RH_Byte2;
          Temp = (T_Byte1  << 8) |  T_Byte2;

          if(Temp & 0x8000) {      //
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

      TMR0ON_bit = 0;     // Timer0 modülünü devre dýþý býrak
      // LCD'de sensör verilerini yazdýr
      LCD_Out(3, 7, temp_a);
      LCD_Out(4, 7, humi_a);

      // sensör verilerini SD karta kaydedin (DHT22Log.txt dosyasý)
      if(fat_err == 0)
      { // FAT32 kitaplýðý baþarýyla baþlatýldýysa
        char buffer[28];
        sprinti(buffer, " %02u-%02u-20%02u | %02u:%02u:%02u |   ", (int)mytime->day, (int)mytime->month, (int)mytime->year,
                       (int)mytime->hours, (int)mytime->minutes, (int)mytime->seconds);
        // 'DHT22Log.txt' dosyasýný ekleme izniyle açýn
        fileHandle = FAT32_Open("DHT22Log.txt", FILE_APPEND);
        if(fileHandle == 0)
        {
        FAT32_Write(fileHandle, buffer, 27);
        if(read_ok == 1)      // saðlama toplamý veya sensör hatasý yoksa
          temp_a[5] = '°';    // put degree symbol
          FAT32_Write(fileHandle, temp_a, 8);
          FAT32_Write(fileHandle, "  | ", 5);
          FAT32_Write(fileHandle, humi_a, 7);
          FAT32_Write(fileHandle, "\r\n", 2);     // start a new line
          // þimdi dosyayý kapatýn (DHT22Log.txt)
          FAT32_Close(fileHandle);
        }
      }

    }

    delay_ms(100);

  }

}