import 'package:coffee_shop_app/models/coffee_item.dart';
import 'package:coffee_shop_app/screens/details_screen.dart';
import 'package:coffee_shop_app/widgets/coffee_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data for favorites
    final List<CoffeeItem> favorites = [
      CoffeeItem(
        id: '1',
        name: 'Cappuccino',
        description: 'Smooth espresso with steamed milk',
        price: 4.20,
        imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
        rating: 4.8,
      ),
      CoffeeItem(
        id: '2',
        name: 'Latte',
        description: 'Espresso with extra steamed milk',
        price: 3.50,
        imageUrl: 'https://images.unsplash.com/photo-1593443320739-77f74952dabd?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
        rating: 4.7,
      ),
       CoffeeItem(
        id: '3',
        name: 'Espresso',
        description: 'Strong concentrated coffee',
        price: 2.80,
        imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
        rating: 4.9,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent to show background if needed
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Your Favorites",
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 100), // Bottom padding for floating nav
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.48, // Much taller
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return CoffeeTile(
                  coffee: favorites[index],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(coffee: favorites[index]),
                    ),
                  ),
                  onPressed: (context) {
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('Added to Cart from Favorites!'), duration: Duration(seconds: 1)),
                     );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
