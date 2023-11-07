import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapc/components/cart_item.dart';
import 'package:snapc/database/firestore.dart';
import 'package:snapc/models/cart.dart';
import 'package:snapc/models/photo.dart';
import 'package:snapc/pages/checkout_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final FirestoreService firestoreService = FirestoreService();

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
            const Text(
              'My Cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getCartStream(currentUser.email),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List cartList = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: cartList.isNotEmpty ? cartList.length : 1,
                      itemBuilder: (context, index) {
                        if (cartList.isNotEmpty) {
                          DocumentSnapshot document = cartList[index];
                          String docId = document.id;
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String name = data['name'];
                          String price = data['price'];
                          String imagePath = data['imagePath'];

                          return CartItem(
                            docId: docId,
                            name: name,
                            price: price,
                            imagePath: imagePath,
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'no packages in the cart',
                            ),
                          );
                        }
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    // * Menampilkan Circular Progress Indicator saat mengambil data
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'no packages in the cart',
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
