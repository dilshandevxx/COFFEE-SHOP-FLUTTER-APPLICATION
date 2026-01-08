import 'package:flutter/material.dart';

class FlyingCoffee extends StatefulWidget {
  final Offset startPosition;
  final Offset endPosition;
  final String image;
  final VoidCallback onComplete;

  const FlyingCoffee({
    super.key,
    required this.startPosition,
    required this.endPosition,
    required this.image,
    required this.onComplete,
  });

  @override
  State<FlyingCoffee> createState() => _FlyingCoffeeState();
}

class _FlyingCoffeeState extends State<FlyingCoffee>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _positionAnimation = Tween<Offset>(
      begin: widget.startPosition,
      end: widget.endPosition,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Shrink as it flies
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward().then((_) => widget.onComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: _positionAnimation.value.dx,
          top: _positionAnimation.value.dy,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12), // Match tile radius
              child: Image.network(
                  widget.image,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  // Simple error fallback if needed, though ephemeral
                  errorBuilder: (c, e, s) => const Icon(Icons.circle, color: Colors.brown),
              ),
            ),
          ),
        );
      },
    );
  }
}
