import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<Map<String, dynamic>> orders = [
      {
        'id': '#1234',
        'date': 'Jan 8, 2026',
        'items': '2x Cappuccino, 1x Croissant',
        'total': '\$12.50',
        'status': 'Processing',
        'color': Colors.orange,
      },
      {
        'id': '#1233',
        'date': 'Jan 5, 2026',
        'items': '1x Iced Latte',
        'total': '\$4.50',
        'status': 'Delivered',
        'color': Colors.green,
      },
      {
        'id': '#1230',
        'date': 'Jan 2, 2026',
        'items': '3x Espresso',
        'total': '\$9.00',
        'status': 'Delivered',
        'color': Colors.green,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('My Orders', style: GoogleFonts.bebasNeue(fontSize: 30, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(25),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (ID and Status)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['id'],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: order['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        order['status'],
                        style: TextStyle(color: order['color'], fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(color: Colors.grey),
                ),

                // Details
                Text(
                  order['date'],
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  order['items'],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                
                const SizedBox(height: 10),
                
                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Amount", style: TextStyle(color: Colors.grey)),
                    Text(
                      order['total'],
                      style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
