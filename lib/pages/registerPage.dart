import 'package:flutter/material.dart';
import 'package:umkn_smk/Components/MyTextFIeld.dart';
import 'package:umkn_smk/controller/backend.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final usernamController = TextEditingController();
  final passwordController = TextEditingController();
  final againPassword = TextEditingController();

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
                const Icon(Icons.rocket_launch_outlined, size: 100),
                const SizedBox(height: 50),
                Text(
                  "Hai, Mari Bergabung!",
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
                const SizedBox(height: 20),
                Mytextfield(
                  controller: againPassword,
                  hinttext: "Ulangi Password",
                  obsecuretext: true,
                  icon: Icons.lock_person,
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/LoginPage');
                  },
                  icon: const Icon(Icons.login, color: Colors.grey),
                  label: const Text(
                    "Sudah punya akun?",
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
                    final repeatPassword = againPassword.text;

                    if (username.isEmpty || password.isEmpty || repeatPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Semua field harus diisi")),
                      );
                      return;
                    }

                    if (password != repeatPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Password tidak cocok")),
                      );
                      return;
                    }

                    final success = await Backend.register(username, password);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Registrasi berhasil! Silakan login.")),
                      );
                      Navigator.pushNamed(context, '/LoginPage');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Username sudah terdaftar")),
                      );
                    }
                  },
                  icon: const Icon(Icons.app_registration),
                  label: const Text("Daftar Sekarang"),
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
