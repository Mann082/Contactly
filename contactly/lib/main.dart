import 'package:contactly/providers/auth.dart';
import 'package:contactly/providers/contact_provider.dart';
import 'package:contactly/providers/group_provider.dart';
import 'package:contactly/screens/excel_upload_screen.dart';
import 'package:contactly/screens/homepage.dart';
import 'package:contactly/screens/settings.dart';
import 'package:contactly/screens/signup.dart';
import 'package:contactly/screens/login.dart';
import 'package:contactly/screens/splashScreen.dart';
import 'package:contactly/widgets/add_contact_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Contactsp(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Groups(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Contactly',
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                  color: Color.fromARGB(255, 29, 83, 222),
                ),
                textTheme: const TextTheme(
                    headlineLarge: TextStyle(color: Colors.white),
                    bodyMedium: TextStyle(color: Colors.white)),
                primaryColor: const Color.fromARGB(255, 29, 83, 222),
                iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 29, 83, 222),
                )),
            routes: {
              Homepage.routeName: (ctx) => const Homepage(),
              Login.routeName: (ctx) => const Login(),
              Signup.routeName: (ctx) => const Signup(),
              addContact.routeName: (ctx) => addContact(),
              excelUploadScreen.routeName: (ctx) => excelUploadScreen(),
              Settings.routeName: (ctx) => const Settings()
            },
            home: !auth.isAuth
                ? FutureBuilder(
                    future: auth.autologin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? const splashScreen()
                            : authResultSnapshot.data == false
                                ? const Login()
                                : const Homepage())
                : const Homepage()),
      ),
    );
  }
}
