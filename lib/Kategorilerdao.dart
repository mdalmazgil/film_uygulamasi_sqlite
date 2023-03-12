//Database Access Object
import 'package:filmler_uygulamasi/Kategoriler.dart';
import 'package:filmler_uygulamasi/VeriTabaniYardimcisi.dart';

class Kategorilerdao{

  // Sqlite üzerinde bulunan Kategoriler tablosu içerisindeki her bir nesneyi alacaktır.
  Future<List<Kategoriler>> tumKategoriler() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    // key string value yani içeriği dinamik yapıdadır(string, integer vb. olabilir)
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kategoriler");

    // database'den gelen tüm kategori değerlerini kategori nesnesine çevirerek gönderiyoruz.
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kategoriler(satir["kategori_id"], satir["kategori_ad"]);
    });
  }
}