import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'common/colors.dart';
import 'features/auth/views/sign_in.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Bear Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldBGColor,
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: greyColor,
          type: BottomNavigationBarType.fixed,
          backgroundColor: bottomNavigationBGColor,
        ),
      ),
      home: const SignIn(),
    );
  }
}
