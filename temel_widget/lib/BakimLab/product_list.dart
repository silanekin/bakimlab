import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services/firestore_service.dart';
import 'urun_detay_sayfasi.dart';


class MySQLProductPage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchProductsFromMySQL() async {
    final response = await http.get(Uri.parse('http://192.168.203.117:3360/api/urunler'));

    if (response.statusCode == 200) {
      List<dynamic> products = json.decode(response.body);
      return products.map((product) => Map<String, dynamic>.from(product)).toList();
    } else {
      throw Exception("MySQL'den ürün verisi alınamadı");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ürünler")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchProductsFromMySQL(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Ürün bulunamadı!"));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final productName = product['name'];
              final imageUrl = product['image_url'];
              final barkod = product['barkod'];

              return ListTile(
                leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(productName),
                onTap: () async {
                  final firestoreService = FirestoreService();
                  await firestoreService.addProductToHistory("Test Ürün", "https://via.placeholder.com/150");
                  print("Ürün geçmişe kaydedildi ve detay sayfasına gidiliyor...");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UrunDetaySayfasi(barkod: "1234567890"),
                    ),
                  );
                },

              );
            },
          );
        },
      ),
    );
  }
}
