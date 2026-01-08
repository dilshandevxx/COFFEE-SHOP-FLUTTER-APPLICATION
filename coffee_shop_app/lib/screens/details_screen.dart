import 'package:coffee_shop_app/models/cart_model.dart';
import 'package:coffee_shop_app/models/coffee_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final CoffeeItem coffee;
  const DetailsScreen({super.key, required this.coffee});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  void addToCart() {
    Provider.of<CartModel>(context, listen: false).addItemToCart(widget.coffee);
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.grey, // Darker dialog
        title: Text("Successfully added!", style: TextStyle(color: Colors.white)),
        content: Text("Check your cart", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView( // Allow scrolling for smaller screens
        child: Column(
          children: [
            // Image with Back Button
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.network(
                    widget.coffee.imageUrl,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(height: 400, color: Colors.grey[800], child: const Icon(Icons.coffee, size: 200, color: Colors.brown)),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
        
            const SizedBox(height: 25),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.coffee.name,
                        style: GoogleFonts.bebasNeue(
                          fontSize: 36,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.orange),
                            const SizedBox(width: 5),
                            Text(
                              widget.coffee.rating.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
        
                  const SizedBox(height: 25),
        
                  // Description Label
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[400],
                    ),
                  ),
        
                  const SizedBox(height: 10),
        
                  // Description
                  Text(
                    widget.coffee.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                      height: 1.6,
                    ),
                  ),
        
                  const SizedBox(height: 30),
                  
                  // Size Selector (Visual Only)
                  Text(
                    "Size",
                     style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildSizeButton("S"),
                      _buildSizeButton("M", isSelected: true),
                      _buildSizeButton("L"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Price and Add to Cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Price",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(text: '\$ ', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 24)),
                                TextSpan(text: widget.coffee.price.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(width: 20),

                      Expanded(
                        child: GestureDetector(
                          onTap: addToCart,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeButton(String size, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSelected ? Colors.orange : Colors.grey[700]!),
      ),
      child: Text(
        size, 
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[400],
          fontWeight: FontWeight.bold
        )
      ),
    );
  }
}
