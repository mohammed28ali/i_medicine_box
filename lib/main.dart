import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:i_medicine_box/routes/routes.dart';


void main()async {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'test_channel',
      channelName: 'Test Notification',
      channelDescription: 'Notficiations for basic testing',
      defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white
    )
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'I-Medicine Box',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: FirebaseAuth.instance.currentUser != null ||
          GetStorage().read<bool>('auth') == true
          ? AppRoutes.mainScreen
          : AppRoutes.splash,
      getPages:AppRoutes.routes,
    );
  }
}

