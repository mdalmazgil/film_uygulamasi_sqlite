import 'package:filmler_uygulamasi/DetaySayfa.dart';
import 'package:filmler_uygulamasi/Filmler.dart';
import 'package:filmler_uygulamasi/Filmlerdao.dart';
import 'package:filmler_uygulamasi/Kategoriler.dart';
import 'package:filmler_uygulamasi/Yonetmenler.dart';
import 'package:flutter/material.dart';

class FilmlerSayfa extends StatefulWidget {

  Kategoriler kategori; // anasayfadan tıklanılan kategori bilgimizi film sayfasına alıyoruz.
  FilmlerSayfa({required this.kategori});

  @override
  State<FilmlerSayfa> createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {


  Future<List<Filmler>> filmleriGoster(int kategori_id) async { // Filmler bilgisini almak için oluşturduğumuz fonksiyon.

    /*var filmlerListesi = <Filmler>[];

    var k1 = Kategoriler(1, "Komedi");
    var y1 = Yonetmenler(1, "Quentin Tarantino");

    var f1 = Filmler(1, "Anadoluda", "2008", "anadoluda.png", k1, y1);
    var f2 = Filmler(2, "Django", "2009", "django.png", k1, y1);
    var f3 = Filmler(3, "Inception", "2010", "inception.png", k1, y1);

    filmlerListesi.add(f1);
    filmlerListesi.add(f2);
    filmlerListesi.add(f3);*/

    var filmlerListesi = await Filmlerdao().tumFilmlerByKategoriId(kategori_id);
    return filmlerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filmler : ${widget.kategori.kategori_ad}"), // widget.title (bir üst sınıfın title'ı gelmiş)
        ),
        body: FutureBuilder<List<Filmler>>(
          future: filmleriGoster(widget.kategori.kategori_id),
          builder: (context,snapshot){
            if(snapshot.hasData){ // Gelen liste dolu mu boş mu kontolü yapıyoruz.
              var filmlerListesi = snapshot.data;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3.5,
                ),
                itemCount: filmlerListesi!.length,
                itemBuilder: (context,indeks){ // film listesinde bulunan nesne sayısı kadar çalışır, sırayla nesne indeks numaralarını aktarır.
                  var film = filmlerListesi[indeks];
                  return GestureDetector( // Karta tıklanılma özelliği veriyoruz.
                    onTap: (){ // Tıklamayla beraber detay sayfasına yönlendirme yapılmaktadır.
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(film: film,)));
                    },
                    child: Card(
                      child: Column( // Kart içeriğini oluşturuyoruz.
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("resimler/${film.film_resim}"),
                          ),
                          Text(film.film_ad, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center();
            }
          },
        ),


    );
  }
}
