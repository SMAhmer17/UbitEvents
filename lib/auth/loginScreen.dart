import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ubitevents/Utils/utils.dart';
import 'package:ubitevents/Views/homeScreen.dart';

import '../Views/records.dart';
import '../widgets/round_button.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  // states manage
  bool _obsecureText = true;
  bool loading = false;

  //controllers

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // form key
  final _formKey = GlobalKey<FormState>();

  // Auth
  FirebaseAuth _auth = FirebaseAuth.instance;
  String myID = '';
  String myEmail = '';
  String myRole = '';

  // user details

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop();
              return true;
            },
            child: Scaffold(
                body: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),

                    const SizedBox(
                      height: 44,
                    ),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          prefix: const Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(Icons.email),
                          ),
                          label: const Text('Email'),
                          hintText: 'Enter Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(
                      height: 28,
                    ),

                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                            child: Icon(_obsecureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          prefix: const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.lock),
                          ),
                          label: Text('Password'),
                          hintText: 'Enter Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        } else {
                          return null;
                        }
                      },
                      obscureText: _obsecureText,
                    ),

                    const SizedBox(
                      height: 28,
                    ),

                    // Signin button

                    RoundButton(
                        title: 'Sign in',
                        loading: loading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            sigin();
                          }
                        }),

                    const SizedBox(
                      height: 28,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Want to register for the Event?",
                          style: TextStyle(fontSize: 15),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddUserScreen()));
                            },
                            child: Text(
                              ' Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ))));
  }

  sigin() async {
    try {
      setState(() {
        loading = true;
      });
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      await _getRoleAnDNavigate();

      setState(() {
        loading = false;
      });
    } catch (e) {
      Utils().toastMessage("$e");
      setState(() {
        loading = false;
      });
    }

    FocusScope.of(context).unfocus();
  }

  Future<void> _getRoleAnDNavigate() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc("${emailController.text}")
        .get()
        .then((snapshot) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => Records(
                    role: snapshot.data()?['role'] ?? "",
                  )));
      ;
    });

    ;
  }
}
