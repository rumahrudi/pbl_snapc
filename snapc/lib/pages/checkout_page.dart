import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/models/photo.dart';
import 'package:snapc/theme/colors.dart';

class CheckoutPage extends StatefulWidget {
  final Photo photo;
  const CheckoutPage({super.key, required this.photo});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: const MyAppBar(text: 'Checkout'),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 25,
              ),
              child: ListView(
                children: [
                  //* title page
                  const Text(
                    'Checkout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // * package
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          // * image package
                          Image.asset(
                            widget.photo.imagePath,
                            width: 80,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // * Details package
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // * name package
                                  Text(
                                    widget.photo.name,
                                    style: GoogleFonts.dmSerifDisplay(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  // * star icon
                                  Icon(
                                    Icons.star,
                                    color: secondaryColor,
                                  ),

                                  // * rate
                                  Text(
                                    widget.photo.rating,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              // * subtitle
                              Text(
                                '${widget.photo.name} Package',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // * price
                              Text(
                                '\Rp${widget.photo.price}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )

                  // * form
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
