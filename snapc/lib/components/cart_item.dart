import 'package:flutter/material.dart';
import 'package:snapc/database/firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:snapc/models/cart.dart';
// import 'package:snapc/models/photo.dart';
import 'package:snapc/theme/colors.dart';

class CartItem extends StatefulWidget {
  final String docId;
  final String name;
  final String price;
  final String imagePath;
  // final Function()? onPressed;

  const CartItem({
    super.key,
    required this.docId,
    required this.name,
    required this.price,
    required this.imagePath,
    // required this.onPressed,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  // * firestore
  final FirestoreService firestoreService = FirestoreService();

  // * remove item from cart
  void removeItemFromCart() {
    // ! Allert succesfully remove
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: const Center(
          child: Text(
            'Successfully Remove',
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: const Text(
          'Check yout cart',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Image.asset(widget.imagePath),
        title: Text('${widget.name} Package'),
        subtitle: Text('\Rp ${widget.price}k'),
        trailing: IconButton(
          onPressed: () {
            firestoreService.deleteCart(widget.docId);
            removeItemFromCart();
          },
          icon: Icon(
            Icons.delete,
            color: secondaryColor,
          ),
        ),
      ),
    );
  }
}
