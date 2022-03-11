Akıllı ev sistemleri uygulamasında sıcaklığın takibi, analizi ve sonuçlandırılması çok önemlidir.
Sıcaklık verisi kullanıcıya nasıl bir yol izlemesi gerektiğini ve nasıl tasarruf yapmasını gerektiği konusunda rehber niteliğindedir.
Bu projede ısının takibi, grafiksel olarak verilmiştir. Proje tasarı durumunda olduğu için sadece bir hard disk üzerinde bilgisayar verileri aktarılarak işlem gösterilmiştir.
Amaçlanan; proje kapsamını genişletip kullanıcıya sms veya akıllı bir uygulama (app) üzerinden verilerin gösterilmiştir.
Ama şu durumda sadece projede veriler, bilgisayar ortamında izlenilmiştir. Projede DHT22(Sıcaklık ve Nem) Sensorü  ve Clock(DS3232) modülü ile eş zamanlı çalışarak PIC18F46K22 
mikroişlemcisine veriyi yollanmıştır. Alınan veri RBO çıkış pini ile SD-CARD aktarılmaktadır. SD-CARD modülü içinde bir  “ .ima” uzantılı dosyaya yazılmıştır. 
WinImage programı sayesinde alınan veriler “.text” uzantısına dönüştürülmektedir. Slave  işlemci  olan(PİC18F26K20) RS232 haberleşme ile bu veriler, 
C#’da GUİ uygulaması üzerinde olarak görülmüştür.

Anahtar Kelimeler: Microişlemci, Micro-C Pro,PIC18F46K22,C# GUİ,Akıllı ev sistemleri, sıcaklık,Nem,Proteus,DS3232,DHT22,RS232 Haberleşme

Sistemin Çalışma Mantığı

![image](https://user-images.githubusercontent.com/67556543/157967945-6226297b-3cf4-4b41-8f22-e1e314094cc6.png)

Sistem Görüntüleri

Micro-c ve Proteus 

![image](https://user-images.githubusercontent.com/67556543/157969574-8d485202-302c-4631-b567-eacb44b9a428.png)


Sistemin Çektiği Veriler

![image](https://user-images.githubusercontent.com/67556543/157968474-07a8338e-4d94-43b1-8203-604b916711e5.png)

C# Bağlantıları ve Arayüzü

![image](https://user-images.githubusercontent.com/67556543/157968817-511b3a13-a573-4dcc-9086-5a434d32c57d.png)


![image](https://user-images.githubusercontent.com/67556543/157968914-df0528a0-a72b-4bcc-b1e3-8e98b0d4160e.png)

Projenin Bütün Yazılımlarının Birlikte Çalıştığı Hali

![image](https://user-images.githubusercontent.com/67556543/157969269-3deecba7-5c36-4b09-95dc-be6841807298.png)




