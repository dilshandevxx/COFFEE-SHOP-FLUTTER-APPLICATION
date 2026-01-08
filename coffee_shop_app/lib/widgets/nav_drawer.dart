import 'package:flutter/material.dart';
import 'package:coffee_shop_app/screens/orders_screen.dart';
import 'package:coffee_shop_app/screens/profile_screen.dart';
import 'package:coffee_shop_app/screens/settings_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          // Header
          DrawerHeader(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[800]!)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(
                    Icons.coffee,
                    size: 60,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Brew Day",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 24,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Menu Items
          // Menu Items
          const SizedBox(height: 10),
          _buildListTile(Icons.home, "Home", () => Navigator.pop(context)),
          _buildListTile(Icons.person, "Profile", () {
             Navigator.pop(context); // Close drawer
             Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }),
          _buildListTile(Icons.shopping_cart, "Orders", () {
             Navigator.pop(context); // Close drawer
             Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersScreen()));
          }),
          _buildListTile(Icons.settings, "Settings", () {
             Navigator.pop(context); // Close drawer
             Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }),
          
          const Spacer(),
          
          // Logout
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: _buildListTile(Icons.logout, "Logout", () {
               // Logic to logout
               Navigator.pop(context);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}
