import 'package:contactly/models/http_exception.dart';
import 'package:contactly/providers/auth.dart';
import 'package:contactly/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const routeName = "/Login";
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> _submit() async {
    // if (_formKey.currentState?.validate() ?? false) {
    //   _boxLogin.put("loginStatus", true);
    //   _boxLogin.put("userName", _controllerUsername.text);

    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return Home();
    //       },
    //     ),
    //   );
    // }
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).login(
            _controllerUsername.text.toString(),
            _controllerPassword.text.toString());
      } on HttpException catch (err) {
        setState(() {
          _isLoading = false;
        });
        _showAlert(err.toString());
      } catch (err) {
        _showAlert(err.toString());
      }
      setState(() {
        _isLoading = false;
      });
    } else
      return;
  }

  void _showAlert(String s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Couldn't Login!!"),
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

  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      // backgroundColor: LinearGradient(
      //     colors: [Colors.blue, Colors.white],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight) as Color,
      body: _isLoading
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
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
                      Text(
                        "Welcome back",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Login to your account",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 60),
                      TextFormField(
                        controller: _controllerUsername,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.white),
                            labelText: "Phone Number",
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white))),
                        onEditingComplete: () =>
                            _focusNodePassword.requestFocus(),
                        onTapOutside: (_) => _focusNodePassword.unfocus(
                            disposition: UnfocusDisposition.scope),
                        validator: (String? value) {
                          if (value!.length != 10) {
                            return "Please enter Valid mobile number";
                          }
                          //  else if (!_boxAccounts.containsKey(value)) {
                          //   return "Username is not registered.";
                          // }
                          for (var char in value.runes) {
                            if (char < 48 || char > 57) {
                              return "Please enter a valid mobile number";
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _controllerPassword,
                        focusNode: _focusNodePassword,
                        onTapOutside: (_) => _focusNodePassword.unfocus(
                            disposition: UnfocusDisposition.scope),
                        obscureText: _obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(color: Colors.white),
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
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white))),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password.";
                          }
                          //  else if (value !=
                          //     _boxAccounts.get(_controllerUsername.text)) {
                          //   return "Wrong password.";
                          // }

                          return null;
                        },
                      ),
                      const SizedBox(height: 60),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 84, 178, 255),
                            ),
                            onPressed: () => _submit(),
                            child: const Text("Login"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  _formKey.currentState?.reset();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const Signup();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Signup",
                                  style: TextStyle(color: Colors.white),
                                ),
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
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }
}
