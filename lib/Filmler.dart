import 'package:filmler_uygulamasi/Kategoriler.dart';
import 'package:filmler_uygulamasi/Yonetmenler.dart';

class Filmler {
  int film_id;
  String film_ad;
  String film_yil;
  String film_resim;
  Kategoriler kategori;
  Yonetmenler yonetmen;

  Filmler(this.film_id, this.film_ad, this.film_yil, this.film_resim,
      this.kategori, this.yonetmen);
}