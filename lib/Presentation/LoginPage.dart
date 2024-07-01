import 'package:buss/Database%20Repo/Crud.dart';
import 'package:buss/Presentation/HomePage.dart';
import 'package:buss/Utils/Constants.dart';
import 'package:buss/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int id = 0;

  var obsecure = true;

  Crud crud = Crud();

  login() async {
    if (_formKey.currentState!.validate()) {
      var response = await crud.PostRequest(linkLoginName, {
        "email": _emailController.text,
        "password": _passwordController.text
      });
      if (response['status'] == "success") {
        id = response['data'][0]['id'];
        sharedPref.setString('id', id.toString());
        sharedPref.setString('username', response['data'][0]['username']);
        sharedPref.setString('password', response['data'][0]['password']);

        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => HomePage(
              userName: _emailController.text,
              password: _passwordController.text,
            ),
            // builder: (context) => const BusInfoPage(),
          ),
        );
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return Container(
                child: const Center(
                  child: Text('Invalid'),
                ),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.36,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/AppLogo.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.29,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Login To PRTSPD',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Provider.of<ThemeProvider>(context)
                                              .isDarkMode
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email address.';
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-z_+]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: obsecure,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obsecure = !obsecure;
                                      });
                                    },
                                    icon: Icon(
                                      obsecure
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.visibility,
                                      color: Provider.of<ThemeProvider>(context)
                                              .isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      color: Provider.of<ThemeProvider>(context)
                                              .isDarkMode
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password.';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters long.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder()),
                          onPressed: () {
                            login();
                          },
                          child: const Text('Login'),
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign Up',
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const RegisterPage(),
                                      ),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
