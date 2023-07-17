import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled12/controllers/user_controller.dart';
import 'package:untitled12/views/signup_Page.dart';

import 'HomePage.dart';
import 'forget_password.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscureText = true;

  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  _handleSignInAction(BuildContext context) {
    final storage = const FlutterSecureStorage();
    EasyLoading.show(status: "Loading");
    UserController()
        .login(_controllerEmail.text, _controllerPassword.text)
        .then((value) async {
      EasyLoading.dismiss();
      await const FlutterSecureStorage()
          .write(key: "token", value: "${value.type} ${value.token}");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }).catchError((ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    });
  }

  _handleSignUpAction(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://appsamurai.com/wp-content/uploads/2022/12/3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _keyForm,
            child: ListView( // Changed to ListView
              children: [
                const SizedBox(height: 40),

                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    // You can add more validation logic for email format
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controllerPassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.password, color: Colors.white),

                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),

                    ),
                  ),
                  obscureText: obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _handleSignInAction(context);
                  },
                  child: const Text("Sign in"),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _handleSignUpAction(context);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}