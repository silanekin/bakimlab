import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'giris_sayfasi.dart';
import 'anasayfa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
  void testFirestoreConnection() async {
    try {
      await FirebaseFirestore.instance.collection('test').add({'test': 'success'});
      print("Firestore bağlantısı başarılı!");
    } catch (e) {
      print("Firestore bağlantısı başarısız: $e");
    }
  }
  void main() {
    WidgetsFlutterBinding.ensureInitialized();
    testFirestoreConnection();
    runApp(MyApp());
  }

}

