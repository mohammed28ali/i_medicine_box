import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../logic/controllers/splash_controller.dart';
import '../widgets/text_utils.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/gradient.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                      child: Lottie.asset(
                        'assets/images/medLogo.json',
                        fit:BoxFit.cover,
                      )
                  ),
                  const SizedBox(height: 20,),
                  const TextUtils(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    text: 'I-Medicine Box',
                    color: Colors.white,
                    underline: TextDecoration.none,
                  ),
                  const SizedBox(height: 10,),
                  const TextUtils(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    text: 'ver.:1.0',
                    color: Colors.white,
                    underline: TextDecoration.none,
                  ),
                  const SizedBox(height: 150,),
                  const TextUtils(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    text: 'by',
                    color: Colors.white,
                    underline: TextDecoration.none,
                  ),
                  const SizedBox(height: 10,),
                  const TextUtils(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    text: 'Bushra & Yasmin',
                    color: Colors.white,
                    underline: TextDecoration.none,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
