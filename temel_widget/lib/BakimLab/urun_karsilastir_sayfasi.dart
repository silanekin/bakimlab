import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class UrunKarsilastirSayfasi extends StatefulWidget {
  @override
  _UrunKarsilastirSayfasiState createState() => _UrunKarsilastirSayfasiState();
}

class _UrunKarsilastirSayfasiState extends State<UrunKarsilastirSayfasi> {
  String? barkod1; // İlk ürünün barkod bilgisi
  String? barkod2; // İkinci ürünün barkod bilgisi

  // Barkod tarama fonksiyonu
  Future<void> _scanBarcode1() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barkod1 = result.rawContent; // İlk ürünün barkodu
      });
    } catch (e) {
      print("Hata: $e");
    }
  }

  Future<void> _scanBarcode2() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barkod2 = result.rawContent; // İkinci ürünün barkodu
      });
    } catch (e) {
      print("Hata: $e");
    }
  }

  // Karşılaştırma işlemi
  void _karsilastir() {
    if (barkod1 == null || barkod2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Her iki ürünün barkodunu da tarayın!")),
      );
    } else {
      // Burada karşılaştırma işlemini yapabilirsiniz
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ürünler karşılaştırılıyor: $barkod1 - $barkod2")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Ürün Karşılaştır",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // İlk ürün tarama
              TextField(
                decoration: InputDecoration(
                  hintText: "Karşılaştırmak istediğiniz 1. ürünün ismini giriniz",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text("ya da barkodla taratın", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        barkod1 ?? "Barkod taratılmadı",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: _scanBarcode1,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              // İkinci ürün tarama
              TextField(
                decoration: InputDecoration(
                  hintText: "Karşılaştırmak istediğiniz 2. ürünün ismini giriniz",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text("ya da barkodla taratın", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 10),
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        barkod2 ?? "Barkod taratılmadı",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: _scanBarcode2,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _karsilastir,
                child: Text("Ürünleri Karşılaştır", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
