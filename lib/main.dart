import 'package:flutter/material.dart';
import 'package:umkn_smk/pages/HomeUser.dart';
import 'package:umkn_smk/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:umkn_smk/controller/provider_thame.dart';
import 'package:umkn_smk/pages/registerPage.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (_) => ProviderTheme(),
        child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providerTheme = Provider.of<ProviderTheme>(context);
    return MaterialApp(
      initialRoute: '/LoginPage',
      routes: {
        '/LoginPage' : (context) => const Login(),
        '/RegisterPage': (context) => const Registerpage(),
        '/HomeUser': (context) => const HomeUser()
      },
      theme: providerTheme.themedata,
      debugShowCheckedModeBanner: false,
    );
  }
}
