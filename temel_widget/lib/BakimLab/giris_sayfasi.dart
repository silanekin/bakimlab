import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'anasayfa.dart'; // Ana sayfa widget'ını buradan çağırıyoruz
import 'kayit_modulu.dart'; // Kayıt sayfası için

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInUser(BuildContext context) async {
    try {
      // Firebase Authentication ile giriş yap
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Giriş başarılı olduğunda kullanıcıyı ana sayfaya yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AnaSayfa()),
      );

    } on FirebaseAuthException catch (e) {
      // Hata mesajını göster
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = "Kullanıcı bulunamadı.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Hatalı şifre.";
      } else {
        errorMessage = "Giriş hatası: ${e.message}";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'lib/BakimLab/bakimLabLogo.png',
              fit: BoxFit.contain,
              height: 60,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  "Temiz Bakım, Güzel Seçim!",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Tekrardan Hoşgeldiniz!",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: -250,
                    child: Container(
                      width: 500,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen.shade100,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'E-posta',
                              labelStyle: TextStyle(color: Colors.grey[700]),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightGreen, width: 2),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(height: 35),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Şifre',
                              labelStyle: TextStyle(color: Colors.grey[700]),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightGreen, width: 2),
                              ),
                            ),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(height: 100),
                        Center(
                          child: Container(
                            width: 215,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                textStyle: TextStyle(fontSize: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  signInUser(context); // Giriş yap
                                }
                              },
                              child: Text(
                                'GİRİŞ YAP',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Şifremi Unuttum!',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  );
                                },
                                child: Text.rich(
                                  TextSpan(
                                    text: 'Hesabım yok. ',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Kayıt Ol!',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.lightGreen.shade100,
        height: 63.9,
      ),
    );
  }
}
