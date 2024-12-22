// pages/register_page.dart
import 'package:chat_app/const.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // for spinner

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  static String id = 'registerpage';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  void _registerUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final auth = FirebaseAuth.instance;
      await registerUser(auth, email, password);
      Navigator.pushNamed(context, ChatPage.id); // Navigate to the chat page
    
      Navigator.pop(context); // Navigate to login or another page
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> registerUser(FirebaseAuth auth, String email, String password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 50),
            Image.asset('assets/images/scholar.png'),
            const SizedBox(height: 20),
            const Text(
              "Chat",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Register",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(controller: emailController, labelText: "Email"),
            const SizedBox(height: 10),
            CustomTextField(controller: passwordController, labelText: "Password", obscureText: true),
            const SizedBox(height: 10),
            CustomTextField(
                controller: confirmPasswordController,
                labelText: "Confirm Password",
                obscureText: true),
            const SizedBox(height: 30),
            isLoading
                ? const Center(child: SpinKitRing(color: Colors.white, size: 50)) // Spinner while loading
                : ElevatedButton(
                    onPressed: () => _registerUser(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
