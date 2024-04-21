import 'package:flutter/material.dart';
import '../../../components/already_have_an_account.dart';
import '../../../constants.dart';
import '../../signin/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  String? email, username, password;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: defaultPadding / 2),
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            onChanged: (val) => username = val,
            decoration: const InputDecoration(
              hintText: "Your name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            decoration: const InputDecoration(
              hintText: "Your last name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            onChanged: (val) => email = val,
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: primaryColor,
              onChanged: (val) => password = val,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () => registerWithEmailAndPassword(context),
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void registerWithEmailAndPassword(BuildContext context) async {
    SVProgressHUD.show();
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      User? user = userCredential.user;
      addData(context, user);
    } catch (e) {
      SVProgressHUD.show();
      print("Failed to register: $e");
    }
  }

  void addData(BuildContext context, User? user) {
    FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'name': username,
      'email': email,
    }).then((value) {
      SVProgressHUD.dismiss();
      print("Data added successfully!");
      Navigator.pushNamed(context, '/dashboard');
    }).catchError((error) {
      SVProgressHUD.dismiss();
      print("Failed to add data: $error");
    });
  }
}
