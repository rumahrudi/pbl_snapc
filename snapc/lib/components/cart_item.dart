import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapc/models/cart.dart';
import 'package:snapc/models/photo.dart';
import 'package:snapc/theme/colors.dart';

class CartItem extends StatefulWidget {
  Photo photo;
  // void Function()? onTap;
  CartItem({
    super.key,
    required this.photo,
    // required this.onTap,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  // * remove item from cart
  void removeItemFromCart() {
    Provider.of<Cart>(context, listen: false).removeItemFromCart(widget.photo);

    // ! Allert succesfully remove
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: Center(
          child: Text(
            'Successfully Remove',
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: Text(
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
        leading: Image.asset(widget.photo.imagePath),
        title: Text(widget.photo.name),
        subtitle: Text(widget.photo.price),
        trailing:
            IconButton(onPressed: removeItemFromCart, icon: Icon(Icons.delete)),
      ),
    );
  }
}
