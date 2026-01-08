import 'package:coffee_shop_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Coffee Logo / Main Image
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.network(
                'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                     const Icon(Icons.coffee, size: 200, color: Colors.brown),
              ),
            ),

            const SizedBox(height: 48),

            // Title
            Text(
              "Brew Day",
              style: GoogleFonts.bebasNeue(
                fontSize: 56,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // Subtitle
            Text(
              "How do you like your coffee?",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[400],
              ),
            ),

            const SizedBox(height: 48),

            // Get Started Button
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
