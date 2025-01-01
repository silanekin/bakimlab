import 'dart:convert';
import 'package:http/http.dart' as http;


Future<List<dynamic>> fetchUrunler() async {
  final response = await http.get(Uri.parse('http://192.168.203.117:3360/api/urunler'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    // Her ürün için 'foto_url' kontrolü yapıyoruz
    return data.map((item) {
      return {
        "urun_adi": item["urun_adi"] ?? "Bilinmeyen Ürün", // Varsayılan ürün adı
        "urun_barkod": item["urun_barkod"] ?? "Bilinmeyen Barkod", // Varsayılan barkod
        "foto_url": item["foto_url"] ?? "", // Varsayılan görsel
      };
    }).toList();
  } else {
    throw Exception('Ürünler yüklenemedi!');
  }
}
