import 'package:flutter/material.dart';
import 'package:umkn_smk/Components/MyTextFIeld.dart';
import 'package:umkn_smk/controller/backend.dart';
import 'package:umkn_smk/pages/HomeUser.dart';
import 'package:umkn_smk/pages/HomeAdmin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernamController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Icon(Icons.login, size: 100),
                const SizedBox(height: 50),
                Text(
                  "Selamat Datang Kembali!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                Mytextfield(
                  controller: usernamController,
                  hinttext: "Username",
                  obsecuretext: false,
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                Mytextfield(
                  controller: passwordController,
                  hinttext: "Password",
                  obsecuretext: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/RegisterPage');
                  },
                  icon: const Icon(Icons.person_add_alt, color: Colors.grey),
                  label: const Text(
                    "Buat akun sekarang",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    final username = usernamController.text.trim();
                    final password = passwordController.text;

                    final success = await Backend.login(username, password);

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login Berhasil!")),
                      );

                      // Check if user is admin
                      if (username.toLowerCase() == 'admin' && password == 'admin') {
                        // Navigate to Admin Home
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeAdmin()),
                        );
                      } else {
                        // Navigate to User Home
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeUser()),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Username atau Password salah"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.login),
                  label: const Text("Masuk"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}