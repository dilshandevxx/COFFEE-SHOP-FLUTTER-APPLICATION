import 'dart:ui' as ui;
import 'package:coffee_shop_app/models/cart_model.dart';
import 'package:coffee_shop_app/models/coffee_item.dart';
import 'package:coffee_shop_app/screens/cart_screen.dart';
import 'package:coffee_shop_app/screens/details_screen.dart';
import 'package:coffee_shop_app/screens/favorites_screen.dart';
import 'package:coffee_shop_app/screens/notifications_screen.dart';
import 'package:coffee_shop_app/widgets/coffee_tile.dart';
import 'package:coffee_shop_app/widgets/flying_coffee.dart';
import 'package:coffee_shop_app/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Navigation State
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Global Key for Cart Icon
  final GlobalKey _cartKey = GlobalKey();

  // Pages to display
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ShopPage(cartKey: _cartKey), // Pass key to ShopPage
      const FavoritesScreen(),
      const NotificationsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const NavDrawer(),
      appBar: AppBar(
        // title: Text("Brew Day V2", ...), removed
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
             icon: Icon(Icons.menu, color: Colors.grey[400]),
             onPressed: () {
               Scaffold.of(context).openDrawer();
             },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              key: _cartKey, // Assign Key here
              icon: Icon(Icons.shopping_bag, color: Colors.grey[400]),
               onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Main Body Content
          _pages[_selectedIndex],

          // Floating Glass Bottom Navigation
          Positioned(
            left: 20,
            right: 20,
            bottom: 25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: _sigmaX(), 
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900]!.withOpacity(0.8) 
                        : Colors.white.withOpacity(0.8), // Dynamic Glass Color
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.home, 'Home', 0),
                      _buildNavItem(Icons.favorite, 'Favs', 1),
                      _buildNavItem(Icons.notifications, 'Notifs', 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Glass Blur
  // Using a separate method to avoid direct instantiation issues if any
  ui.ImageFilter _sigmaX() {
     return ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10);
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _navigateBottomBar(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[400],
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

// Extracted Shop Page Component (The previous Home content)
class ShopPage extends StatefulWidget {
  final GlobalKey cartKey;
  const ShopPage({super.key, required this.cartKey});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // Search Controller
  final TextEditingController _searchController = TextEditingController();

   // Category selection
  final List<List<dynamic>> coffeeType = [
    ['All', true],
    ['Cappuccino', false],
    ['Latte', false],
    ['Espresso', false],
    ['Flat White', false],
  ];

  void coffeeTypeSelected(int index) {
    setState(() {
      for (int i = 0; i < coffeeType.length; i++) {
        coffeeType[i][1] = false;
      }
      coffeeType[index][1] = true;
    });
  }

  // Filter Logic
  List<CoffeeItem> _getFilteredCoffees(List<CoffeeItem> allCoffees) {
    String searchText = _searchController.text.toLowerCase();
    String selectedCategory = coffeeType.firstWhere((element) => element[1] == true)[0];

    return allCoffees.where((coffee) {
      // 1. Filter by Name (Search)
      bool matchesSearch = coffee.name.toLowerCase().contains(searchText);

      // 2. Filter by Category
      bool matchesCategory = true;
      if (selectedCategory != 'All') {
        // Simple matching logic: Check if name contains category (e.g. "Latte" in "Iced Latte")
        // Ideally, CoffeeItem should have a 'category' field.
        matchesCategory = coffee.name.toLowerCase().contains(selectedCategory.toLowerCase());
      }

      return matchesSearch && matchesCategory;
    }).toList();
  }

  void runAddToCartAnimation(BuildContext widgetContext, String imageUrl) async {
    // 1. Get Start Position
    RenderBox renderBox = widgetContext.findRenderObject() as RenderBox;
    Offset startPos = renderBox.localToGlobal(Offset.zero);

    // 2. Get End Position (Cart Icon)
    RenderBox? cartBox = widget.cartKey.currentContext?.findRenderObject() as RenderBox?;
    if (cartBox == null) return;
    Offset endPos = cartBox.localToGlobal(Offset.zero);

    // 3. Create Overlay Entry
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => FlyingCoffee(
        startPosition: startPos,
        endPosition: endPos,
        image: imageUrl,
        onComplete: () {
          overlayEntry.remove();
        },
      ),
    );

    // 4. Insert Overlay
    Overlay.of(context).insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          // Find the best coffee for you
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Find the best coffee for you",
              style: GoogleFonts.bebasNeue(
                fontSize: 56,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _searchController, // Linked controller
              onChanged: (value) => setState(() {}), // Rebuild on typing
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.orange),
                hintText: 'Find your coffee..',
                hintStyle: TextStyle(color: Colors.grey[600]),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.grey.shade800,
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),

          const SizedBox(height: 25),

          // Horizontal List of Categories
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: coffeeType.length,
              itemBuilder: (context, index) {
                return CoffeeType(
                  coffeeType: coffeeType[index][0],
                  isSelected: coffeeType[index][1],
                  onTap: () => coffeeTypeSelected(index),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          // Horizontal List of Coffees
          Expanded(
            child: Consumer<CartModel>(
              builder: (context, value, child) {
                // Get Filtered List
                List<CoffeeItem> filteredItems = _getFilteredCoffees(value.shopItems);

                return GridView.builder(
                  padding: const EdgeInsets.only(left: 25, right: 25, bottom: 100),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.48, // Much taller to ensure no overflow 
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    CoffeeItem coffee = filteredItems[index];
                    return CoffeeTile(
                      coffee: coffee,
                      onPressed: (BuildContext btnContext) { // Received context here!
                          // Start Animation
                          runAddToCartAnimation(btnContext, coffee.imageUrl);

                          // Add Item Logic
                          Provider.of<CartModel>(context, listen: false).addItemToCart(coffee);
                          
                          // Optional: Clearer feedback (removed snackbar to let animation shine)
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //    const SnackBar(content: Text('Added to Cart'), duration: Duration(milliseconds: 500)),
                          // );
                      },
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(coffee: coffee),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
  }
}

class CoffeeType extends StatelessWidget {
  final String coffeeType;
  final bool isSelected;
  final VoidCallback onTap;

  const CoffeeType({
    super.key,
    required this.coffeeType,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Text(
          coffeeType,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.orange : Colors.grey[600], // Orange for selected
          ),
        ),
      ),
    );
  }
}
