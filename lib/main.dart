import 'package:filmler_uygulamasi/FilmlerSayfa.dart';
import 'package:filmler_uygulamasi/Kategoriler.dart';
import 'package:filmler_uygulamasi/Kategorilerdao.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // Default sağ çaprazda yazan yazıyı kaldırıyoruz.
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  Future<List<Kategoriler>> tumKategorileriGoster() async { // Kategori bilgisine almak için oluşturduğumuz fonksiyon.

    /*var kategoriListesi = <Kategoriler>[];

    var k1 = Kategoriler(1, "Komedi");
    var k2 = Kategoriler(2, "Bilim Kurgu");

    kategoriListesi.add(k1);
    kategoriListesi.add(k2);*/

    var kategoriListesi = await Kategorilerdao().tumKategoriler();
    return kategoriListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kategoriler"), //widget.title (bir üst sınıfın title'ı gelmiş)
        ),
        body: FutureBuilder<List<Kategoriler>>(
          future: tumKategorileriGoster(),
          builder: (context,snapshot){
            if(snapshot.hasData){ // Gelen liste dolu mu boş mu kontolü yapıyoruz.
              var kategoriListesi = snapshot.data;
              return ListView.builder(
                itemCount: kategoriListesi!.length,
                itemBuilder: (context,indeks){ // kategori listesinde bulunan nesne sayısı kadar çalışır, sırayla nesne indeks numaralarını aktarır.
                  var kategori = kategoriListesi[indeks];
                  return GestureDetector( // Karta tıklanılma özelliği veriyoruz.
                    onTap: (){ // Tıklamayla beraber film sayfasına yönlendirme yapılmaktadır.
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FilmlerSayfa(kategori: kategori,)));
                    },
                    child: Card(
                      child: SizedBox( // Kartın boyutunu ayarlıyoruz.
                        height: 50,
                        child: Row( // Kart içeriğini oluşturuyoruz.
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(kategori.kategori_ad),
                          ],
                        ),
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
