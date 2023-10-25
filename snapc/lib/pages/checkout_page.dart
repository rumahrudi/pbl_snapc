import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView(
                children: [
                  //* title page
                  Text(
                    'Checkout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(
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
                          SizedBox(
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
                                  SizedBox(
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              // * subtitle
                              Text(
                                widget.photo.subtitile,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // * price
                              Text(
                                '\Rp' + widget.photo.price,
                                style: TextStyle(
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