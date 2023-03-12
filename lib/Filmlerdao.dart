import 'package:filmler_uygulamasi/Filmler.dart';
import 'package:filmler_uygulamasi/Kategoriler.dart';
import 'package:filmler_uygulamasi/VeriTabaniYardimcisi.dart';
import 'package:filmler_uygulamasi/Yonetmenler.dart';

class Filmlerdao {

  // Sqlite üzerinde bulunan Kategoriler tablosu içerisindeki her bir nesneyi alacaktır.
  Future<List<Filmler>> tumFilmlerByKategoriId(int kategori_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    // key string value yani içeriği dinamik yapıdadır(string, integer vb. olabilir)
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM filmler,kategoriler,yonetmenler "
        "WHERE filmler.kategori_id = kategoriler.kategori_id and filmler.yonetmen_id = yonetmenler.yonetmen_id "
        "and filmler.kategori_id = $kategori_id");

    // database'den gelen tüm ilgili film değerlerini film nesnesine çevirerek gönderiyoruz.
    return List.generate(maps.length, (i) {
      var satir = maps[i];

      var k = Kategoriler(satir["kategori_id"], satir["kategori_ad"]);
      var y = Yonetmenler(satir["yonetmen_id"], satir["yonetmen_ad"]);
      var f = Filmler(satir["film_id"], satir["film_ad"], satir["film_yil"], satir["film_resim"], k, y);

      return f;
    });
  }

}