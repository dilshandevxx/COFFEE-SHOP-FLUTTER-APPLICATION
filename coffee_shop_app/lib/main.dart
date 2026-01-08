import 'package:coffee_shop_app/models/cart_model.dart';
import 'package:coffee_shop_app/screens/cart_screen.dart';
import 'package:coffee_shop_app/screens/home_screen.dart';
import 'package:coffee_shop_app/screens/intro_screen.dart';
import 'package:coffee_shop_app/providers/theme_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Coffee Shop App',
            theme: ThemeProvider.lightTheme,
            darkTheme: ThemeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const IntroScreen(),
          );
        },
      ),
    );
  }
}
