import 'package:coffee_shop_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  // Controller to keep track of which page we are on
  final PageController _controller = PageController();
  
  // Keep track of if we are on the last page
  bool onLastPage = false;
  
  // State for page index
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(
        children: [
          // Page View (Slider)
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
                onLastPage = (index == 2);
              });
            },
            children: [
              _buildPage(
                "Fresh Brew",
                "Quality beans sourced locally for the freshest taste.",
                "https://images.unsplash.com/photo-1497935586351-b67a49e012bf?auto=format&fit=crop&w=1171&q=80",
              ),
              _buildPage(
                "Swift Delivery",
                "Hot coffee delivered to your doorstep in minutes.",
                "https://images.unsplash.com/photo-1526628953301-3e589a6a8b74?auto=format&fit=crop&w=1106&q=80", // Delivery/Pouring image
              ),
              _buildPage(
                "Easy Payment",
                "Seamless and secure checkout process.",
                "https://images.unsplash.com/photo-1556742049-0cfed4f7a07d?auto=format&fit=crop&w=1170&q=80", // Payment/Tech image
              ),
            ],
          ),

          // Controls
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Skip Button
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text("SKIP", style: TextStyle(color: Colors.white)),
                ),

                // Dot Indicators
                Row(
                  children: List<Widget>.generate(3, (index) {
                     return AnimatedContainer(
                       duration: const Duration(milliseconds: 300),
                       margin: const EdgeInsets.symmetric(horizontal: 4),
                       width: _currentPageIndex == index ? 20 : 10, // Expand active dot
                       height: 10,
                       decoration: BoxDecoration(
                         shape: BoxShape.rectangle,
                         borderRadius: BorderRadius.circular(5),
                         color: _currentPageIndex == index ? Colors.orange : Colors.grey,
                       ),
                     );
                  }),
                ),

                // Next or Done Button
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                           Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        },
                        child: const Text("DONE", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text("NEXT", style: TextStyle(color: Colors.white)),
                      ),
              ],
            ),
          ),
          
          // Better Dot Indicator Overlay (Hardcoded for simplicity if package not allowed)
          // To make dots active, we can rebuild the row manually or just use the "Done" logic.
        ],
      ),
    );
  }

  Widget _buildPage(String title, String subtitle, String imageUrl) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              imageUrl,
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                   const Icon(Icons.coffee, size: 200, color: Colors.brown),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: GoogleFonts.bebasNeue(fontSize: 40, color: Colors.white, letterSpacing: 1),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[400]),
          ),
        ),
      ],
    );
  }
}
