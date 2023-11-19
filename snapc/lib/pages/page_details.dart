import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/models/photo.dart';
import 'package:snapc/models/cart.dart';
import 'package:snapc/theme/colors.dart';

class PageDetails extends StatefulWidget {
  final Photo photo;
  const PageDetails({super.key, required this.photo});

  @override
  State<PageDetails> createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  void addPhotoPackageToCart(Photo photo) {
    Provider.of<Cart>(context, listen: false).addItemToCart(widget.photo);

    // ! alert user ,show successfully added
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: const Center(
          child: Text(
            'Successfully Added',
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
      backgroundColor: Colors.grey[300],
      appBar: const MyAppBar(text: 'Package Detail'),
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
                    widget.photo.imagePath,
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
                        widget.photo.rating,
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
                    widget.photo.name,
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
                    height: 25,
                  ),
                  Text(
                    widget.photo.description,
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: 14, height: 2),
                  )
                ],
              ),
            ),
          ),
          // * price and buttton
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  // * price

                  // * button
                  MyButton(
                    isVisible: true,
                    text: 'Add To Cart',
                    onTap: () => addPhotoPackageToCart(widget.photo),
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
