import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stroke_text/stroke_text.dart';
import 'dart:math';

class GameplayScreen extends StatefulWidget {
  GameplayScreen({super.key});  

  @override
  _GameplayScreenState createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  final TextEditingController _controller100000 = TextEditingController();
  final TextEditingController _controller50000 = TextEditingController();
  final TextEditingController _controller20000 = TextEditingController();
  final TextEditingController _controller10000 = TextEditingController();
  final TextEditingController _controller5000 = TextEditingController();
  final TextEditingController _controller2000 = TextEditingController();
  final TextEditingController _controller1000 = TextEditingController();
  final TextEditingController _controller500 = TextEditingController();

  // Fungsi untuk menghasilkan angka acak antara 1.000 hingga 100.000
  int generateRandomAmount() {
    final random = Random();
    // Menghasilkan angka acak antara 1000 hingga 100000
    int amount = random.nextInt(100000 - 1000 + 1) + 1000;
    // Membulatkan angka ke kelipatan 500 terdekat
    return roundToNearest500(amount);
  }

  // Fungsi untuk membulatkan angka ke kelipatan 500 terdekat
  int roundToNearest500(int amount) {
    // Menentukan pembulatan ke 500 terdekat
    if (amount % 500 == 0) return amount;

    int remainder = amount % 500;
    if (remainder >= 1) {
      // Jika sisa pembagian lebih besar atau sama dengan 250, bulatkan ke atas
      return amount + (500 - remainder);
    } else {
      // Jika sisa pembagian kurang dari 250, bulatkan ke bawah
      return amount - remainder;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Menghasilkan angka acak untuk uang, dan pastikan total lebih kecil dari uang
    int randomUang = generateRandomAmount();
    int randomTotal;

    // Pastikan total lebih kecil dari uang
    do {
      randomTotal = generateRandomAmount();
    } while (randomTotal >= randomUang); // total lebih kecil dari uang
    
    // Hitung kembalian
    int randomKembali = randomUang - randomTotal;
    
    return Scaffold(
      appBar: AppBar(
        title: const StrokeText(
          text: "Kembali", 
          textStyle: TextStyle(
            fontSize: 24,
            fontFamily: 'Super Ramen',
            color: Color.fromARGB(255, 60, 91, 111),
            letterSpacing: 1,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          strokeColor: Color.fromARGB(255, 241, 232, 215),
          strokeWidth: 10,
        ),
        backgroundColor: const Color.fromARGB(255, 173, 161, 142),
        leading: IconButton(
          icon: Image.asset('asset/image/back.png'), // Ganti dengan path gambar yang sesuai
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0), // Memberikan jarak dari ujung kanan
            child: Center(
              child: Text(
                'MONEY MATCH',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: Color.fromARGB(255, 21, 52, 72), 
                  fontFamily: 'Thick Stitch',
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      blurRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      backgroundColor: const Color.fromARGB(255, 148, 137, 121),
      body: Stack(
        children: <Widget>[
          _buildContainerWithImage(50, 56, 304, 142, Colors.transparent, 'asset/image/duit/100000.png'),
          _buildContainerWithImage(226, 56, 304, 142, Colors.transparent, 'asset/image/duit/50000.png'),
          _buildContainerWithImage(402, 56, 304, 142, Colors.transparent, 'asset/image/duit/20000.png'),
          _buildContainerWithImage(578, 56, 304, 142, Colors.transparent, 'asset/image/duit/10000.png'),
          _buildContainerWithImage(56, 549, 304, 142, Colors.transparent, 'asset/image/duit/5000.png'),
          _buildContainerWithImage(227, 549, 304, 142, Colors.transparent, 'asset/image/duit/2000.png'),
          _buildContainerWithImage(403, 549, 304, 142, Colors.transparent, 'asset/image/duit/1000.png'),
          _buildContainerWithImageCheck(579, 549, 304, 142, Colors.transparent, 'asset/image/duit/500.png', randomKembali, imageWidth: 150, imageHeight: 75), // Mengatur ukuran gambar
          _buildTextField(80, 400, 71, 79, controller: _controller100000), // untuk gambar 100.000
          _buildTextField(250, 400, 71, 79, controller: _controller50000), // untuk gambar 50.000
          _buildTextField(426, 400, 71, 79, controller: _controller20000), // untuk gambar 20.000
          _buildTextField(602, 400, 71, 79, controller: _controller10000), // untuk gambar 10.000
          _buildTextField(74, 894, 71, 79, controller: _controller5000), // untuk gambar 5.000
          _buildContainerWithText(172, 1133, 228, 211, const Color.fromARGB(255, 82, 102, 113), randomTotal, randomUang, randomKembali),
          _buildContainerWithImageCheck(507, 1169, 156, 147, Colors.transparent, 'asset/image/check.png', randomKembali),
          _buildTextField(250, 894, 71, 79, controller: _controller2000), // untuk gambar 2.000
          _buildTextField(426, 894, 71, 79, controller: _controller1000), // untuk gambar 1.000
          _buildTextField(602, 894, 71, 79, controller: _controller500), // untuk gambar 500
          _buildContainerWithT(400, 1009, 500, 100,  Colors.transparent, "CEK JAWABAN"),
        ],
      ),
    );
  }

  Widget _buildContainerWithImage(double top, double left, double width, double height, Color color, String imagePath, {double? imageWidth, double? imageHeight}) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15), // Membuat kotak menjadi rounded
          
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15), // Membuat gambar mengikuti bentuk rounded
          child: Image.asset(
            imagePath,  
            fit: BoxFit.cover,
            width: imageWidth,
            height: imageHeight,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(double top, double left, double width, double height, {TextEditingController? controller}) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15), // Membuat kotak menjadi rounded
        ),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center, // Mengatur teks agar berada di tengah
          keyboardType: TextInputType.number, // Memastikan hanya angka yang bisa dimasukkan
          inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly, // Membatasi input hanya angka
        ],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Membuat border TextField menjadi rounded
              borderSide: const BorderSide(
                color: Color(0x153448),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Membuat border TextField menjadi rounded
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 60, 91, 111), // Set your desired focus color here
                width: 2.0,
              ),
            ),
            fillColor: const Color.fromARGB(255, 148, 137, 121),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 20.0), // Mengatur tinggi TextField
          ),
          style: const TextStyle(
            height: 2, // Mengatur tinggi TextField
            fontSize: 25, // Memperbesar ukuran font
            color: Colors.white, //
            fontFamily: 'BubbleNorth'
          ),
          textInputAction: TextInputAction.done,
          showCursor: false,
          autofocus: false,
        ),
      ),
    );
  }

  Widget _buildContainerWithText(double top, double left, double width, double height, Color color, int total, int uang, int kembali) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color.fromARGB(255, 223, 208, 184), width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(5, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Soal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Super Ramen',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Total: $total',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Super Ramen',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Uang: $uang',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Super Ramen',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Kembali: $kembali',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Super Ramen',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainerWithT(double top, double left, double width, double height, Color color, String text) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15), // Membuat kotak menjadi rounded
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: StrokeText(
              text: "Cek Jawaban",
              textStyle: TextStyle(
                color: Color.fromARGB(255, 60, 91, 111), // Warna teks
                fontSize: 50, // Ukuran font
                fontFamily: 'Super Ramen', //  font
              ),
              strokeColor: Colors.white,
              strokeWidth: 10,
              ),
          ),
        ),
      ),
    );
  }

Widget _buildContainerWithImageCheck(double top, double left, double width, double height, Color color, String imagePath, int kembali, {double? imageWidth, double? imageHeight}) {
  return Positioned(
    top: top,
    left: left,
    child: GestureDetector(
      onTap: () {
        int seratus = (int.tryParse(_controller100000.text) ?? 0) * 100000;
        int limapuluh = (int.tryParse(_controller50000.text) ?? 0) * 50000;
        int duapuluh = (int.tryParse(_controller20000.text) ?? 0) * 20000;
        int sepuluh = (int.tryParse(_controller10000.text) ?? 0) * 10000;
        int limaribu = (int.tryParse(_controller5000.text) ?? 0) * 5000;
        int duaribu = (int.tryParse(_controller2000.text) ?? 0) * 2000;
        int seribu = (int.tryParse(_controller1000.text) ?? 0) * 1000;
        int gopek = (int.tryParse(_controller500.text) ?? 0) * 500;
        int output = (seratus + limapuluh + duapuluh + sepuluh + limaribu + duaribu + seribu + gopek);
        
        if (kembali == output) {
          print('jawaban Benar');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.pop(context);
                setState(() {
                  _controller100000.clear();
                  _controller50000.clear();
                  _controller20000.clear();
                  _controller10000.clear();
                  _controller5000.clear();
                  _controller2000.clear();
                  _controller1000.clear();
                  _controller500.clear();
                });
              });

              return Dialog(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'asset/image/menang.png',
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        } else {
          print("jawaban salah");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'asset/image/cobalagi.png',
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: imageWidth,
            height: imageHeight,
          ),
        ),
      ),
    ),
  );
}
}

