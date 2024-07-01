import 'dart:io';

import 'package:buss/Presentation/HomePage.dart';
import 'package:buss/Presentation/LoginPage.dart';
import 'package:buss/Utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Database Repo/Crud.dart';
import '../main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var obsecure = true;
  var id;

  File? myfile;

  Crud crud = Crud();

  register() async {
    if (_formKey.currentState!.validate()) {
      var response = await crud.PostRequest(linkRegisterName, {
        "name": name.text,
        "email": email.text,
        "username": username.text,
        "password": password.text,
      });
      if (response['status'] == "success") {
        id = response['data'][0]['id'];
        sharedPref.setString('id', id.toString());
        sharedPref.setString('username', response['data'][0]['username']);
        sharedPref.setString('password', response['data'][0]['password']);
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => HomePage(
              userName: username.text,
              password: password.text,
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: const Text('Invalid username or password.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus App'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login To PRTSPD',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // Stack(
                  //   alignment: Alignment.bottomRight, // Align at bottom right
                  //   children: [
                  //     // CircleAvatar for the image (replace with your image or placeholder)
                  //     const CircleAvatar(
                  //       backgroundImage:myfile,
                  //       backgroundColor: Colors.grey,
                  //       radius: 50.0,
                  //       child: Icon(
                  //         Icons.person,
                  //         color: Colors.white,
                  //         size: 40,
                  //       ), // Or use NetworkImage
                  //     ),
                  //     // IconButton with a plus icon for photo upload
                  //     CircleAvatar(
                  //       radius: 15,
                  //       backgroundColor: Colors.grey[200],
                  //       child: IconButton(
                  //         onPressed: () async {
                  //           final xFile = await ImagePicker()
                  //               .pickImage(source: ImageSource.gallery);
                  //           myfile = File(xFile!.path);
                  //         },
                  //         icon: const Icon(Icons.add,
                  //             color: Colors
                  //                 .black), // White icon for better visibility
                  //         padding: EdgeInsets.zero, // Remove default padding
                  //         constraints:
                  //             const BoxConstraints(), // Remove default constraints
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.focused)
                              ? Colors.black
                              : Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      labelText: "Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.focused)
                              ? Colors.black
                              : Colors.grey),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r"\S+@\S+\.\S+").hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      labelText: "Username",
                      prefixIcon: const Icon(Icons.person_2_sharp),
                      prefixIconColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.focused)
                              ? Colors.black
                              : Colors.grey),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.password),
                      prefixIconColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.focused)
                              ? Colors.black
                              : Colors.grey),
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
                          color: Colors.black,
                        ),
                      ),
                    ),
                    obscureText: obsecure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      register();
                      // if (_formKey.currentState!.validate()) {
                      //   // Handle successful form submission
                      // }
                    },
                    child: const Text('Register'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
                          style: const TextStyle(color: Colors.blueAccent),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const LoginPage(),
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
    );
  }
}
