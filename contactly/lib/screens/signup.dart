import 'package:contactly/models/http_exception.dart';
import 'package:contactly/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  static const routeName = "/SignUp";
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isloading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodeUsername = FocusNode();
  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  bool _obscurePassword = true;

  void _showErrorMessage(String s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Couldn't SignUp !!"),
        backgroundColor: Theme.of(context).primaryColor..withAlpha(150),
        contentTextStyle: const TextStyle(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white),
        alignment: Alignment.center,
        content: Text(s),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Okay",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _isloading
          ? Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff3d4eaf), Color(0xff45a7f5)],
                stops: [0, 0.7],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Loading...")
                  ],
                ),
              ),
            )
          : Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff3d4eaf), Color(0xff45a7f5)],
                stops: [0, 0.7],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      Text(
                        "Register",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Create your account",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 35),
                      TextFormField(
                        controller: _controllerName,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: "Name",
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10))),
                        validator: (String? value) {
                          if (value!.length <= 3) {
                            return "Please enter your full name.";
                          }
                          // else if (_boxAccounts.containsKey(value)) {
                          //   return "Username is already registered.";
                          // }
                          return null;
                        },
                        onEditingComplete: () =>
                            _focusNodeUsername.requestFocus(),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _controllerUsername,
                        focusNode: _focusNodeUsername,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText: "Mobile Number",
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10))),
                        validator: (String? value) {
                          if (value!.length != 10) {
                            return "Please enter a valid phone number.";
                          }
                          // else if (_boxAccounts.containsKey(value)) {
                          //   return "Username is already registered.";
                          // }
                          for (var char in value.runes) {
                            if (char < 48 || char > 57) {
                              return "Please enter a valid phone number.";
                            }
                          }
                          return null;
                        },
                        onEditingComplete: () => _focusNodeEmail.requestFocus(),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _controllerEmail,
                        focusNode: _focusNodeEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10))),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email.";
                          } else if (!(value.contains('@') &&
                              value.contains('.'))) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        onEditingComplete: () =>
                            _focusNodePassword.requestFocus(),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _controllerPassword,
                        obscureText: _obscurePassword,
                        focusNode: _focusNodePassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(
                              Icons.password_outlined,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: _obscurePassword
                                    ? const Icon(
                                        Icons.visibility_outlined,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.white,
                                      )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10))),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password.";
                          } else if (value.length < 8) {
                            return "Password must be at least 8 character.";
                          }
                          return null;
                        },
                        onEditingComplete: () =>
                            _focusNodeConfirmPassword.requestFocus(),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _controllerConFirmPassword,
                        obscureText: _obscurePassword,
                        focusNode: _focusNodeConfirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            labelText: "Confirm Password",
                            prefixIcon: const Icon(
                              Icons.password_outlined,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                icon: _obscurePassword
                                    ? const Icon(
                                        Icons.visibility_outlined,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.white,
                                      )),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10))),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password.";
                          } else if (value != _controllerPassword.text) {
                            return "Password doesn't match.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 50),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              backgroundColor:
                                  const Color.fromARGB(255, 84, 178, 255),
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                // _boxAccounts.put(
                                //   _controllerUsername.text,
                                //   _controllerConFirmPassword.text,
                                // );
                                setState(() {
                                  _isloading = true;
                                });
                                try {
                                  await Provider.of<Auth>(context,
                                          listen: false)
                                      .signUp(
                                          _controllerUsername.text,
                                          _controllerPassword.text,
                                          _controllerEmail.text,
                                          _controllerName.text);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      width: 200,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      duration: const Duration(seconds: 3),
                                      content: const Text(
                                        "Registered Successfully\nYou can Login Now",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );

                                  _formKey.currentState?.reset();

                                  Navigator.pop(context);
                                } on HttpException catch (err) {
                                  _showErrorMessage(err.toString());
                                } catch (err) {
                                  _showErrorMessage(err.toString());
                                }
                                setState(() {
                                  _isloading = false;
                                });
                              }
                            },
                            child: const Text("Register"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Login",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
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

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }
}
