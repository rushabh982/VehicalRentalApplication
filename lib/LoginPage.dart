import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'services/authFunctions.dart';
import 'pages/IntroPage.dart'; // Import your IntroPage.dart file
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool login = true;

  String loggedInUserName = ''; // Initialize with an empty string
  String loggedInUserEmail = ''; // Initialize with an empty string

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(login ? 'Login' : 'Register'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: ValueKey('email'),
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please Enter a valid Email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              TextFormField(
                key: ValueKey('password'),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                ),
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Password must be at least 6 characters long';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      User? user = await AuthServices.signinUser(email, password, context);

                      if (user != null) {
                        setState(() {
                          loggedInUserName = user.displayName ?? '';
                          loggedInUserEmail = user.email ?? '';
                        });

                        // Navigate to the IntroPage after successful login
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => IntroPage(userName: loggedInUserName, userEmail: loggedInUserEmail)),
                        );
                      }
                    }
                  },
                  child: Text(login ? 'Login' : 'Register'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    login = !login;
                  });

                  // Navigate to the registration page when switching to register mode
                  if (!login) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => RegisterForm()),
                    );
                  }
                },
                child: Text(login
                    ? "Don't have an account? Register"
                    : "Already have an account? Login"),
              ),
              // Display user information after successful login
              if (loggedInUserName.isNotEmpty && loggedInUserEmail.isNotEmpty)
                Column(
                  children: [
                    Text('Logged in as: $loggedInUserName'),
                    Text('Email: $loggedInUserEmail'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
