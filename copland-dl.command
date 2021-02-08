#!/bin/bash
export TERM=xterm
RENK='\033[0;31m' #kırmızı renk
RENKX='\033[0m' #renksiz
#script boyunca renkli mesaj yazarken kolay kullanım için iki değişken belirler.

clear
printf "${RENK}New York Philarmonic Archive indiriciye (v2) hoş geldiniz!${RENKX}\nEserin adı ne?: "
read ESER
mkdir "$ESER"
#Eserin ismiyle bir klasör yaratır.

printf "Eserin ID kodu: "
read ID
#ID koduna değişken atar.

printf "Birinci sayfa numarası: "
read ILK_SAYFA
printf "Sonuncu sayfa numarası: "
read SON_SAYFA
#seçilen sayfalara değişken atar.


echo "İndirme işlemi sayfa $ILK_SAYFA ile $SON_SAYFA arasında olacaktır."
while true; do
    read -p "Doğru mudur? (Y veya N): " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Y veya N ile yanıtlayınız.";;
    esac
done
#doğrulama amaçlı evet hayır promptu verir.

mkdir ${ESER}/jpg

for ((i = $ILK_SAYFA; i < $((SON_SAYFA+1)); ++i)); do
#Belirlenmiş aralığın sonuna gelene dek "i" değişkenine 1 ekler.
  printf -v NUMBER '%03d' $i;
  #"i" değişkenini 3 adet sıfır kullanarak "NUMBER" adlı yeni değişkene yazar. Bunun sebebi NyPhil'in URL'sinin 3 adet sıfırlı sayı beklemesidir.
  printf "${RENK}Sayfa #$i indiriliyor... ${RENKX}"
  #indirilen sayfayı gösterir.
  DOSYA=${ESER}/jpg/${NUMBER}.jpg
  if [ -f "$DOSYA" ]; then
  #İndirmeden önce dosyanın varlığını kontrol eder.
      echo "Bu sayfa zaten mevcut."
      #İndirme komutunu atlayıp loop'un başına döner.
    else
      echo " "
      curl "https://archives.nyphil.org/index.php/jp2/|MS|1|${ID}|MS_${ID}_${NUMBER}.jp2/portrait/3000" --output ${ESER}/jpg/${NUMBER}.jpg
      #Adrese ID'yi ve sayfa sayısını yerleştirip sonunu curl ile indirir. --output komutu ile jpg klasörüne jpg olarak kaydeder. Kaydedilen dosyanın ismini sayfa sayısı koyar.
  fi
done

#PDF YAPMA KISMI
echo "İndirme tamamlandı."
while true; do
    read -p "PDF yapayım mı? (Y veya N): " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Y veya N ile yanıtlayınız.";;
    esac
done
#doğrulama amaçlı evet hayır promptu verir.

printf "${RENK}PDF'e çevirme dosyanın boyutuna göre uzun sürebilir.${RENKX}\n$ESER.pdf oluşturuluyor..."
BASLA=$SECONDS
#geçen zamanı ölçmek için değişken.

convert `ls -v ${ESER}/jpg/*.jpg` ${ESER}/${ESER}.pdf
#ImageMagick paketi ile gelen convert'i kullanarak photos klasöründeki tüm jpgleri pdf'e dönüştürür.

BITTI=$SECONDS
ZAMAN=$(( BITTI - BASLA ))
#geçen zamanı ölçüp ZAMAN değişkenine saniye biçiminde koyar.

printf " $ZAMAN saniyede bitti. Oha!\nFotoğrafları kendin silersin, bana bırakma böyle şeyleri.\nBen sadece bir bilgisayarım. Beep boop!\n"
read -n 1 -s -r -p "Kapatmak için bir tuşa bas"
#klasik komik not. read'den sonra gelen argümanlar herhangi bir tuş ile programı kapattırıyor.
