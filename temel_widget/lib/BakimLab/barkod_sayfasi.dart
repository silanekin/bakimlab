import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'urun_detay_sayfasi.dart'; // Ürün Detay Sayfası

class BarkodSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Barkod Tarayıcı',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: MobileScanner(
        onDetect: (BarcodeCapture barcode) {
          final List<Barcode> barcodes = barcode.barcodes;
          for (final Barcode code in barcodes) {
            if (code.rawValue != null) {
              final String barkod = code.rawValue!; // Barkod değeri

              // Barkod algılandığında API'den ürün bilgilerini çek ve detay sayfasına yönlendir
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UrunDetaySayfasi(barkod: barkod),
                ),
              );
              break; // İlk barkodu işledikten sonra döngüyü kırıyoruz
            }
          }
        },
      ),
    );
  }
}
