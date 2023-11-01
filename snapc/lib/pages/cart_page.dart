import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapc/components/cart_item.dart';
import 'package:snapc/models/cart.dart';
import 'package:snapc/models/photo.dart';
import 'package:snapc/pages/checkout_page.dart';
// import 'package:snapc/pages/page_details.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void navigateToCheckoutPage(BuildContext context, Photo photo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(
          photo: photo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // * Heading
            const Text(
              'My Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.getUserCart().length,
                itemBuilder: (context, index) {
                  // * Get individual photo package
                  Photo individualPhotoPackage = value.getUserCart()[index];
                  // * Return the cart item
                  return GestureDetector(
                    onTap: () =>
                        navigateToCheckoutPage(context, individualPhotoPackage),
                    child: CartItem(
                      photo: individualPhotoPackage,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
