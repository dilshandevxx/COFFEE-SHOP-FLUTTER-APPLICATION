import 'package:flutter/material.dart';
import 'coffee_item.dart';

class CartModel extends ChangeNotifier {
  // List of items in the shop
  final List<CoffeeItem> _shopItems = [
    CoffeeItem(
      id: '1',
      name: 'Cappuccino',
      description: 'Espresso-based coffee drink that originated in Italy.',
      price: 4.20,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=680&q=80',
      rating: 4.8,
    ),
    CoffeeItem(
      id: '2',
      name: 'Latte',
      description: 'Coffee drink of Italian origin made with espresso and steamed milk.',
      price: 3.80,
      imageUrl: 'https://images.unsplash.com/photo-1570968992193-eb3a3390c965?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=680&q=80',
      rating: 4.5,
    ),
    CoffeeItem(
      id: '3',
      name: 'Espresso',
      description: 'Full-flavored, concentrated form of coffee.',
      price: 2.50,
      imageUrl: 'https://images.unsplash.com/photo-1510707577519-e05913d22436?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=680&q=80',
      rating: 4.9,
    ),
    CoffeeItem(
      id: '4',
      name: 'Iced Coffee',
      description: 'Coffee beverage served cold.',
      price: 4.00,
      imageUrl: 'https://images.unsplash.com/photo-1517701604599-bb6e87f28bed?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=680&q=80',
      rating: 4.3,
    ),
  ];

  // List of items in user cart
  final List<CoffeeItem> _userCart = [];

  // get list of items for sale
  List<CoffeeItem> get shopItems => _shopItems;

  // get items in cart
  List<CoffeeItem> get userCart => _userCart;

  // add item to cart
  void addItemToCart(CoffeeItem item) {
    _userCart.add(item);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(CoffeeItem item) {
    _userCart.remove(item);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < _userCart.length; i++) {
      totalPrice += _userCart[i].price;
    }
    return totalPrice.toStringAsFixed(2);
  }
}
