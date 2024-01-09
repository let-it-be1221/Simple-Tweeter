import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo2_form/models/user.dart';
import 'package:demo2_form/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'Login.dart';

class SignUp extends ConsumerStatefulWidget {
  SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _signInkey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final RegExp emailValid = RegExp(
      r"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image:AssetImage("assets/logo.png"),width: 100,height: 100,),
          Text(
            "Sign Up with Twitter",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Form(
              key: _signInkey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 237, 234, 234),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Your Email";
                          } else if (!emailValid.hasMatch(value)) {
                            return "Please Enter A valid Emali";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          contentPadding: EdgeInsets.only(left: 15),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 237, 234, 234),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Your Password";
                          } else if (value.length < 6) {
                            return "Password must be 6 character";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Password",
                            contentPadding: EdgeInsets.only(left: 15),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue),
                      child: TextButton(
                        onPressed: () async {
                          if (_signInkey.currentState!.validate()) {
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                          await ref
                                  .read(userProvider.notifier)
                                  .signUp(_emailController.text);
                              if (!mounted) return;
                              Navigator.of(context).pop();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                (SnackBar(content: Text(e.toString()))),
                              );
                            }
    
                            // debugPrint("Email :${_emailController.text}");i
                            //debugPrint("Password :${_passwordController.text}");
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ;
                        },
                        child:
                            Text("Already have An Account? Click here to Login"))
                  ],
                ),
              )),
        ],
      )),
    );
  }
}
