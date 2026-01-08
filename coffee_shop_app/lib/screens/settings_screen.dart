import 'package:coffee_shop_app/providers/theme_provider.dart'; // MOVED
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // MOVED

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // State variables for toggles
  bool _notifications = true;
  bool _location = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.bebasNeue(fontSize: 30, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: App Settings
            _buildSectionHeader("App Settings"),
            // Dark Mode Toggle
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return _buildSwitchTile(
                  "Dark Mode", 
                  "Use system dark theme", 
                  themeProvider.isDarkMode, 
                  (val) => themeProvider.toggleTheme(val),
                );
              },
            ),
            _buildSwitchTile("Notifications", "Receive updates and offers", _notifications, (val) => setState(() => _notifications = val)),
            _buildSwitchTile("Location Services", "Find nearby stores", _location, (val) => setState(() => _location = val)),

            const SizedBox(height: 30),

            // Section: Support
            _buildSectionHeader("Support"),
            _buildActionTile("Help Center", Icons.help_outline),
            _buildActionTile("Privacy Policy", Icons.lock_outline),
            _buildActionTile("About Us", Icons.info_outline),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.orange,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
        value: value,
        activeColor: Colors.orange,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildActionTile(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // Placeholder for action
        },
      ),
    );
  }
}
