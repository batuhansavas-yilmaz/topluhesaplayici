import 'vucutKitleEndeksi.dart';
yorum(){

  if (KitleEndeksiState.sonuc == 0) {
    KitleEndeksiState.sonucMetin = "";
  } else if (KitleEndeksiState.sonuc < 18.5) {
    KitleEndeksiState.sonucMetin =
    "Zayıfsınız,\nBiraz Kilo Almanızda Fayda Var,\nAma Sağlıklı Bir Şekilde";
  } else if (KitleEndeksiState.sonuc < 24.99) {
    KitleEndeksiState.sonucMetin = "Kilonuz Normal";
  } else if (KitleEndeksiState.sonuc < 29.99) {
    KitleEndeksiState.sonucMetin = "Fazla Kilolarınızdan Kurtulmanız Gerekli";
  } else if (KitleEndeksiState.sonuc < 34.99) {
    KitleEndeksiState.sonucMetin =
    "Birinci Derecede Obezsiniz.\nYediğinize Dikkat Edip \nBir Diyetisyene Başvurmanız Gerekli";
  } else if (KitleEndeksiState.sonuc < 44.99) {
    KitleEndeksiState.sonucMetin =
    "İkinci Derecede Obezsiniz.\nKalp ve Damar Hastalıkları Riskiniz Var\nBir Diyetisyene Başvurmanız Gerekli";
  }else {
    KitleEndeksiState.sonucMetin =
    "İkinci Derecede Obezsiniz.\nKalp ve Damar Hastalıkları Riskiniz Var\nBir Diyetisyene Başvurmanız Gerekli";
  }
}
