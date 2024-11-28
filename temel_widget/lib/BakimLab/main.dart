import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'giris_sayfasi.dart';
import 'barkod_sayfasi.dart'; // Barkod Tarama Sayfası
import 'altmenu_sayfasi.dart'; // Alt Menü Sayfası

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // Firebase'i başlatın
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ürün Analiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseInitialization(), // Firebase başlatılmasını kontrol eden widget
    );
  }
}

class FirebaseInitialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(), // Firebase'in başlatılmasını bekler
      builder: (context, snapshot) {
        // Firebase başlatılması tamamlandığında giriş sayfasına yönlendirir
        if (snapshot.connectionState == ConnectionState.done) {
          return LoginPage(); // Giriş Sayfasına Yönlendir
        }
        // Başlatma sırasında yükleme ekranı gösterir
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

