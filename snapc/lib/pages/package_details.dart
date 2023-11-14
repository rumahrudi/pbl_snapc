import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/database/firestore.dart';
import 'package:snapc/theme/colors.dart';

class PackagesDetails extends StatefulWidget {
  final String name;
  final String imagePath;
  final String price;
  final String decs;
  final String rating;
  final String revisions;

  const PackagesDetails(
      {super.key,
      required this.name,
      required this.imagePath,
      required this.price,
      required this.decs,
      required this.rating,
      required this.revisions});

  @override
  State<PackagesDetails> createState() => _PackagesDetailsState();
}

class _PackagesDetailsState extends State<PackagesDetails> {
  // * user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // * firestore
  final FirestoreService firestoreService = FirestoreService();

  void allertAddToCart() {
    // ! Allert succesfully add to cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: const Center(
          child: Text(
            'Successfully Add to Cart',
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(text: 'D E T A I L S'),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Image.asset(
                    widget.imagePath,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      // * star icon
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      // * number
                      Text(
                        widget.rating,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // * food name
                  Text(
                    widget.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // * description
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.decs,
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: 14, height: 2),
                  ),
                ],
              ),
            ),
          ),
          // * price and buttton
          Container(
            decoration: BoxDecoration(
              color: fourthColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  // * price

                  // * button
                  MyButton(
                    text: 'Add To Cart',
                    onTap: () {
                      // * add package to cart
                      firestoreService.addToCart(
                          currentUser.email!,
                          widget.name,
                          widget.price,
                          widget.imagePath,
                          widget.revisions);

                      // * show allert
                      allertAddToCart();
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
