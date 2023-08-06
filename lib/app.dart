import 'package:cinereview/pages/home_page.dart';
import 'package:cinereview/pages/login_page.dart';
import 'package:cinereview/pages/resgister_page.dart';
import 'package:cinereview/styles/colors.dart';
import 'package:cinereview/styles/text.dart';
import 'package:cinereview/widgets/auth_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          Brightness.light, // Define o ícone da barra de status como escuro
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: ProjectColors.pink,
          contentTextStyle: ProjectText.bold,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthCheck(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage()
      },
    );
  }
}
