import 'package:coffee_shop_app/models/coffee_item.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {
  final CoffeeItem coffee;
  final void Function(BuildContext context)? onPressed;
  final void Function()? onTap;

  const CoffeeTile({
    super.key,
    required this.coffee,
    required this.onPressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8), // Reduced padding
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(), // Only scroll if absolutely necessary, but prevent user scrolling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Coffee Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  coffee.imageUrl,
                  height: 90, 
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(height: 90, color: Colors.grey[700], child: const Icon(Icons.coffee, color: Colors.brown)),
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffee.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'With Almond Milk', 
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
        
              // Price + Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: '\$ ', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                        TextSpan(text: coffee.price.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          if (onPressed != null) {
                            onPressed!(context);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
