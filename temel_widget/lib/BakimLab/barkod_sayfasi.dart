import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarkodSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              // Barkod algılandığında bir mesaj göster
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Barkod Tarandı'),
                    content: Text('Barkod İçeriği: ${code.rawValue}'),
                    actions: [
                      TextButton(
                        child: Text('Tamam'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              break; // İlk barkodu işledikten sonra döngüyü kırıyoruz
            }
          }
        },
      ),
    );
  }
}
