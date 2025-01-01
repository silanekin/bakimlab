import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UrunDetaySayfasi extends StatefulWidget {
  final String barkod;

  UrunDetaySayfasi({required this.barkod});

  @override
  _UrunDetaySayfasiState createState() => _UrunDetaySayfasiState();
}

class _UrunDetaySayfasiState extends State<UrunDetaySayfasi> {
  late Future<Map<String, dynamic>> _urunDetay;

  @override
  void initState() {
    super.initState();
    _urunDetay = fetchUrunDetay(widget.barkod);
  }

  Future<Map<String, dynamic>> fetchUrunDetay(String barkod) async {
    final url = 'http://10.35.215.141:3360/api/urunler/$barkod';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw Exception('Ürün bulunamadı. Lütfen barkodu kontrol edin.');
      } else {
        throw Exception('Sunucu hatası: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayları"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _urunDetay,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  SizedBox(height: 10),
                  Text(
                    'Hata: ${snapshot.error}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _urunDetay = fetchUrunDetay(widget.barkod);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text("Tekrar Dene"),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Ürün bulunamadı!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            final urun = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ürün Adı: ${urun['urun_adi']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'İçerik: ${urun['urun_icerik']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Barkod: ${urun['urun_barkod']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, urun['urun_adi']); // Ürün adı döndürülüyor
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text("Ürün Adını Kaydet"),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}