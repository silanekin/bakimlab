import 'package:flutter/material.dart';
import 'barkod_sayfasi.dart'; // Barkod Tarama Sayfası
import 'services/api_service.dart'; // API Fonksiyonları
import 'widgets/product_card.dart'; // Ürün Kartı Bileşeni

class AnaSayfaContent extends StatefulWidget {
  @override
  _AnaSayfaContentState createState() => _AnaSayfaContentState();
}

class _AnaSayfaContentState extends State<AnaSayfaContent> {
  late Future<List<dynamic>> _urunler; // API'den gelecek ürün listesi

  @override
  void initState() {
    super.initState();
    _urunler = fetchUrunler(); // API'den ürünleri çekiyoruz
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Önceden Arattıklarım",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Barkod Sayfası'na yönlendirme
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BarkodSayfasi()),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "Tamamını Gör",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: _urunler,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator()); // Yükleniyor
              } else if (snapshot.hasError) {
                return Center(child: Text('Hata: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("Hiç ürün bulunamadı."));
              } else {
                final urunler = snapshot.data!;
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: urunler.length,
                  itemBuilder: (context, index) {
                    final urun = urunler[index];
                    return ProductCard(
                      foto_url: urun['foto_url'] ?? '',
                      productName: urun['urun_adi'] ?? 'Bilinmeyen Ürün',
                      urunBarkod: urun['urun_barkod'] ?? 'Bilinmeyen Barkod',
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

