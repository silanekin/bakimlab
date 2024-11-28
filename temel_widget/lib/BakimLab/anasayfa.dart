import 'package:flutter/material.dart';
import 'barkod_sayfasi.dart'; // Barkod Sayfası

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _currentIndex = 0;

  // Alt menüdeki sayfalar
  final List<Widget> _pages = [
    AnaSayfaContent(), // Ana Sayfa içeriği
    Scaffold(body: Center(child: Text("Arama Sayfası"))), // Ara (placeholder)
    BarkodSayfasi(), // Barkod Tarama Sayfası
    Scaffold(body: Center(child: Text("Karşılaştırma Sayfası"))), // Karşılaştır (placeholder)
    Scaffold(body: Center(child: Text("Geçmiş Sayfası"))), // Geçmiş (placeholder)
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
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Bakımlab",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Temiz Bakım, Güzel Seçim!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/user_photo.jpg'), // Kullanıcı fotoğrafı
            ),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onItemTapped, // Alt menü tıklama olayı
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

class AnaSayfaContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Önceden Arattıklarım",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemCount: 4, // Ürün sayısı
              itemBuilder: (context, index) {
                return ProductCard(
                  imagePath: 'assets/product_$index.jpg', // Ürün resimleri
                  productName: 'Ürün $index',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String productName;

  ProductCard({required this.imagePath, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            productName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // "Analiz Et" butonuna tıklama olayı
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Analiz Et',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
