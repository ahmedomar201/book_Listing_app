import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../core/utils/images.dart';
import 'book_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  Future<void> startAnimation() async {
    await Future.delayed(const Duration(seconds: 2));

    await Future.delayed(const Duration(seconds: 1));

    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BookListScreen()),
    );
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagesConstant.appLogo, width: 200, height: 200),
            const SizedBox(height: 30),
            const Text(
              'Book app',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
