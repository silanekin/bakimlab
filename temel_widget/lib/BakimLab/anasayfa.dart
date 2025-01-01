import 'package:flutter/material.dart';
import 'package:temel_widget/BakimLab/urun_karsilastir_sayfasi.dart';
import 'barkod_sayfasi.dart'; // Barkod Tarama Sayfası
import 'arama_sayfasi.dart'; // Arama Sayfası
import 'anasayfa_content.dart'; // Ana Sayfa İçeriği
import 'profil_sayfasi.dart';
import 'gecmis_sayfasi.dart';



class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _currentIndex = 0;

  // Alt menüdeki sayfalar
  final List<Widget> _pages = [
    AnaSayfaContent(), // Ana Sayfa içeriği
    AramaSayfasi(), // Arama Sayfası
    BarkodSayfasi(), // Barkod Tarama Sayfası
    UrunKarsilastirSayfasi(), // Karşılaştır
    HistoryPage()// Geçmiş
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'lib/BakimLab/bakimLabLogo.png',
              fit: BoxFit.contain,
              height: 60,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              // Profil sayfasına yönlendirme
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilSayfasi()), // ProfilSayfasi'nı çağır
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('lib/BakimLab/default_image.jpg'), // Kullanıcı fotoğrafı
              ),
            ),
          ),
        ],
      ),
      body: _pages[_currentIndex], // Aktif sayfa gösteriliyor
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex, // Aktif menü
        onTap: _onItemTapped, // Menüde tıklama
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Ara',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Barkod',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare),
            label: 'Karşılaştır',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Geçmiş',
          ),
        ],
      ),
    );
  }


}
