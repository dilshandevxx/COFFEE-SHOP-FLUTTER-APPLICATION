import 'package:coffee_shop_app/models/cart_model.dart';
import 'package:coffee_shop_app/models/coffee_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('My Cart', style: GoogleFonts.bebasNeue(fontSize: 30, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            children: [
              // List of Cart Items
              Expanded(
                child: value.userCart.isEmpty
                    ? Center(child: Text("Cart is empty", style: TextStyle(color: Colors.grey[500], fontSize: 18)))
                    : ListView.builder(
                        itemCount: value.userCart.length,
                        itemBuilder: (context, index) {
                          CoffeeItem item = value.userCart[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item.imageUrl,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                    Container(height: 50, width: 50, color: Colors.grey[700], child: const Icon(Icons.coffee, size: 30, color: Colors.brown)),
                                ),
                              ),
                              title: Text(item.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              subtitle: Text('\$${item.price}', style: TextStyle(color: Colors.grey[400])),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.grey),
                                onPressed: () {
                                  Provider.of<CartModel>(context, listen: false)
                                      .removeItemFromCart(item);
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // Total and Pay Button
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                   color: Colors.grey[850], // Slightly lighter than background
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Text(
                          '\$${value.calculateTotal()}',
                          style: const TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector( // Make it tappable if we had payment logic
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "Pay Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
