import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'urun_detay_sayfasi.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> userHistory = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserHistory();
  }

  Future<void> fetchUserHistory() async {
    final user = auth.currentUser;

    if (user != null) {
      final historyRef = firestore.collection('history').doc(user.uid);
      final snapshot = await historyRef.get();

      if (snapshot.exists) {
        final data = snapshot.data();
        setState(() {
          userHistory = List<Map<String, dynamic>>.from(data?['products'] ?? []);
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geçmiş"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userHistory.isEmpty
          ? Center(child: Text("Geçmiş bulunamadı!"))
          : ListView.builder(
        itemCount: userHistory.length,
        itemBuilder: (context, index) {
          final product = userHistory[index];
          return ListTile(
            leading: Image.network(product['image_url']),
            title: Text(product['product_name']),
            subtitle: Text("Ziyaret: ${product['visited_at']}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UrunDetaySayfasi(barkod: "Ürün Barkod"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
