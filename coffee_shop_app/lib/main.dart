import 'package:coffee_shop_app/models/cart_model.dart';
import 'package:coffee_shop_app/screens/cart_screen.dart';
import 'package:coffee_shop_app/screens/home_screen.dart';
import 'package:coffee_shop_app/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffee Shop App',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.grey[900],
          textTheme: GoogleFonts.soraTextTheme(ThemeData.dark().textTheme),
        ),
        home: const IntroScreen(),
      ),
    );
  }
}
