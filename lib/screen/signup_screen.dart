import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SignUpScreen()));

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool isVisibleObsecure = false;

  void _submittedForm() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Form submitted successfully"),
        ),
      );
    }
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Enter name";
    } else if (!RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return "Please enter a valid name without numbers or special characters";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please enter your email address";
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 6) {
      return "Password should be at least 6 characters long";
    } else if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value)) {
      return "Password should only contain letters and numbers";
    }
    return null;
  }

  String? confirmValidatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please confirm your password";
    } else if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                  image: AssetImage("assets/logo.png"),
                  height: 250,
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create \n New Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff756d64),
                          height: 1,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: validateName,
                        controller: _nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Name",
                        ),
                      ),
                      TextFormField(
                        validator: validateEmail,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Email",
                        ),
                      ),
                      TextFormField(
                        validator: validatePassword,
                        controller: _passwordController,
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: !isVisibleObsecure,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibleObsecure = !isVisibleObsecure;
                              });
                            },
                            icon: isVisibleObsecure
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          prefixIcon: Icon(Icons.password),
                          hintText: "Password",
                        ),
                      ),
                      TextFormField(
                        validator: confirmValidatePassword,
                        controller: _confirmController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password_rounded),
                          hintText: "Confirm Password",
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff756d64),
                          minimumSize: const Size(400, 50),
                        ),
                        onPressed: _submittedForm,
                        child: Text(
                          "Create",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffffffff),
                            height: 1,
                          ),
                        ),
                      ),
                    ],
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
