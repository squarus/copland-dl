# copland-dl
New York Filarmoni arşivinden nota indirmeye yarayan ufak program.
***
Bash'te yazılmıştır. Mac'te kodlanıp Windows'ta denenmemiştir fakat çalışıyor olması gerekiyor. PowerShell x64 kullanmanızı tavsiye ediyorum.

* [ÖZELLİKLER](https://github.com/squarus/copland-dl#özellikler)
* [GEREKSİNİMLER](https://github.com/squarus/copland-dl#gereksinimler)
* [AYARLAR](https://github.com/squarus/copland-dl#ayarlar)

## Özellikler
* **ID numarası ile indirme** - New York Filarmoni arşivi sitesinden indirmek istediğiniz eserin ID numarasını (birkaç rakamdan oluşan bir kod) vermeniz yeterli, gerisini copland-dl halleder.
* **Sayfa aralığı seçme** - İlk ve son sayfayı belirleyip sadece istediğiniz kısmı indirerek veri ve depolama tasarrufu yapabilirsiniz.
* **Otomatik PDF yaratma** - İndirme bittikten sonra isteğe bağlı olarak otomatik PDF yaratma seçeneği sunulmaktadır.
* **Yüksek kalite** - Varsayılan ayarlar ile copland-dl mevcut eserin en kaliteli halini indirecektir.
* **Otomatik organizasyon** - Dağınıklığa son! İndirmeyi başlatmadan önce girdiğiniz eser ismi ile copland-dl size otomatik klasör yaratır, indirilen görselleri bu klasörün içinde "jpg" adlı klasörde depolar ve yarattığınız PDF'e de eserin ismini koyar.

## Gereksinimler
**ImageMagick** - PDF'e çevirme özelliği için gereklidir. Kodun 76. satırındaki `convert` komutunu sağlamaktadır. Bu olmadan da çalışıyor; ancak JPG - PDF çevirme işini elle yapmanız gerekir.

## Ayarlar
### Kalite ayarı
Programda DPI (Dots Per Inch) ayarı yapma bulunmaktadır. Kodun en başında, 7. satırda `DPI=300` bulunuyor. Bu ayarı azaltabilirsiniz; direkt olarak siteden belirlediğiniz kalitede indireceği için depolama yanında internet kullanımını da azaltacaktır. Kanımca kalite ve tasarruf arasındaki en uygun nokta `DPI=150`'dir, en yüksek kalite indirmek istiyorsanız ayarı ellemeyin. **300'den yükseğe ayarlarsanız indirme hata verecektir.** Bunun sebebi NYP arşivinin dosyalarını en yüksek 300 DPI olarak sunuyor olmasıdır.

### İndirme konumu
Normalde program, size sorduğu eser ismiyle bir klasör açıp tüm işlemleri bu klasör üzerinden yürütecektir. Bunu değiştirmek istiyorsanız kodun 13. satırındaki `KLASOR=$ESER` komutunu comment'layıp (başına # koyup) 14. satırdaki komutun comment'ını kaldırarak (başından #'yi silerek) istediğiniz bir isimde klasör açabilirsiniz. **Bunu yaparsanız her işlem sonrası "jpg" klasörünü boşaltmanız gerekecektir.** Aksi takdirde yeni eser indirmeye kalkıştığınızda "zaten mevcut" hatası vererek eksik sayfalara yol açabilir.
