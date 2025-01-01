import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Ürün geçmişine ekle

  Future<void> addProductToHistory(String productName, String imageUrl) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("Kullanıcı oturum açmamış!");
      return;
    }

    try {
      final historyRef = _firestore.collection('history').doc(user.uid);

      await historyRef.set({
        'user_id': user.uid,
        'products': FieldValue.arrayUnion([
          {
            'product_name': productName,
            'image_url': imageUrl,
            'visited_at': DateTime.now().toIso8601String(),
          }
        ]),
      }, SetOptions(merge: true)); // Mevcut dokümana veri ekler veya yeni doküman oluşturur

      print("Ürün geçmişe başarıyla eklendi!");
    } catch (e) {
      print("Geçmişe ürün eklenirken hata: $e");
    }
  }
  // Ürün geçmişini getir
  Future<List<Map<String, dynamic>>> fetchUserHistory() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        final historySnapshot = await _firestore.collection('history').doc(user.uid).get();

        if (historySnapshot.exists) {
          final data = historySnapshot.data();
          return List<Map<String, dynamic>>.from(data?['products'] ?? []);
        } else {
          print("Geçmiş dokümanı bulunamadı.");
        }
      } else {
        print("Kullanıcı oturum açmamış.");
      }
    } catch (e) {
      print("Geçmiş verileri alınırken hata: $e");
    }

    return [];
  }

  // Geçmişi temizle
  Future<void> clearHistory() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        final historyRef = _firestore.collection('history').doc(user.uid);

        await historyRef.update({
          'products': FieldValue.delete(),
        });

        print("Geçmiş başarıyla temizlendi!");
      } else {
        print("Kullanıcı oturum açmamış!");
      }
    } catch (e) {
      print("Geçmiş temizlenirken hata: $e");
    }
  }

}

