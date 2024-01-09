import 'package:demo2_form/pages/SignUp.dart';
import 'package:demo2_form/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  Login({super.key});

  @override
  ConsumerState<Login> createState() => _Login();
}

class _Login extends ConsumerState<Login> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _signInkey = GlobalKey();

  final TextEditingController _emialController = TextEditingController();

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
            "Log in with Twitter",
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
                        controller: _emialController,
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
                            //debugPrint("Email :${_emialController.text}");
                            //debugPrint("Password :${_passwordController.text}");
                            try {
                              await _auth.signInWithEmailAndPassword(
                                  email: _emialController.text,
                                  password: _passwordController.text);
    
                              ref
                                  .watch(userProvider.notifier)
                                  .login(_emialController.text);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                (SnackBar(content: Text(e.toString()))),
                              );
                            }
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text("Don't have an Account? Sign Up here"))
                  ],
                ),
              )),
        ],
      )),
    );
  }
}
