import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';
import 'gameplay_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Inisialisasi AnimationController untuk fade-out
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Durasi fade-out
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);

    Future.delayed(const Duration(seconds: 2), () {
      _animationController.forward();
    }).then((_) {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          if (_fadeAnimation.value > 0.0) {
            return _buildSplashScreen();
          } else {
            return _buildMainContent();
          }
        },
      ),
    );
  }

  Widget _buildSplashScreen() {
    return Stack(
      children: [
        Container(color: Colors.black),
        Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              'asset/image/LOGO.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Stack(
      children: [
        // Background utama
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFBBAA88),
            image: DecorationImage(
              image: AssetImage('asset/image/bg-duit.png'),
              fit: BoxFit.cover,
              opacity: 1,
            ),
          ),
        ),
        // Konten Utama
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'MONEY MATCH',
                style: TextStyle(
                  fontSize: 128,
                  fontFamily: 'Thick Stitch',
                  color: Color.fromARGB(255, 21, 52, 72),
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      blurRadius: 3,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDDC9A3),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  GameplayScreen()),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Color.fromARGB(255, 60, 91, 111),
                      size: 125,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(75, 0, 0, 0),
                          blurRadius: 0.10,
                          offset: Offset(5, 5),
                        )
                      ],
                    ),
                    SizedBox(width: 10),
                    StrokeText(
                      text: "MAINKAN",
                      textStyle: TextStyle(
                        fontSize: 70,
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
                      strokeColor: Colors.white,
                      strokeWidth: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
