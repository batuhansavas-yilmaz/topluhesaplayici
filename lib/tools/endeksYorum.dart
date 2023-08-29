import '../vucutKitleEndeksi.dart';

class Yorum {
  static yorum() {
    if (KitleEndeksiState.sonuc == 0) {
      KitleEndeksiState.sonucMetin = "";
    } else if (KitleEndeksiState.sonuc < 18.5) {
      KitleEndeksiState.sonucMetin =
          "Zayıfsınız. Biraz kilo almanızda fayda var, ama tabii ki de sağlıklı bir şekilde.";
    } else if (KitleEndeksiState.sonuc < 24.99) {
      KitleEndeksiState.sonucMetin =
          "Kilonuz normal. Fakat yine de yediklerinize dikkat etmeyi ihmal etmeyin lütfen. ";
    } else if (KitleEndeksiState.sonuc < 29.99) {
      KitleEndeksiState.sonucMetin =
          "Fazla kilolarınızdan kurtulmanız gerekli. Aksi halde kilolarınız başınıza dert açabilir.";
    } else if (KitleEndeksiState.sonuc < 34.99) {
      KitleEndeksiState.sonucMetin =
          "Birinci derecede obezsiniz. Yediğinize dikkat edip bir diyetisyene başvurmanız gerekli.";
    } else if (KitleEndeksiState.sonuc < 44.99) {
      KitleEndeksiState.sonucMetin =
          "İkinci derecede obezsiniz. Kalp ve damar hastalıkları riskiniz var. Bir diyetisyene başvurmanız gerekli.";
    } else {
      KitleEndeksiState.sonucMetin =
          "Üçüncü derecede obezsiniz. Bu da morbid obezite demek. Acil olarak bir diyetisyene başvurmanız gerekli.";
    }
  }
}
