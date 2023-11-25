import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/components/my_textfield.dart';
import 'package:snapc/database/firestore.dart';
import 'package:snapc/pages/order_page.dart';
import 'package:snapc/theme/colors.dart';

class CheckoutPage extends StatefulWidget {
  final String name;
  final String imagePath;
  final String price;
  final String docId;
  final String revisions;
  const CheckoutPage({
    super.key,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.docId,
    required this.revisions,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

List<String> options = ['BCA', 'BNI'];

class _CheckoutPageState extends State<CheckoutPage> {
  // * user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // * firestore
  final FirestoreService firestoreService = FirestoreService();

  // * radio contoller
  String currentOptions = options[0];

  // * text controller
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // * navigate
  void _navigatePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderPage(),
      ),
    );
  }

  //* Function to show AlertDialog
  void _showAlertDialog(
      String title, String content, void Function()? onPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: Center(
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'O K',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  // * add data from form to database orders
  void _submitForm() async {
    // * if form not complete

    if ([
      nameController,
      phoneController,
    ].any((controller) => controller.text.isEmpty)) {
      _showAlertDialog('An Error Occurred', 'Form not completed', () {
        Navigator.pop(context);
      });
      return;
    }

    await firestoreService.addToOrders(
      widget.name,
      currentUser.email!,
      nameController.text,
      phoneController.text,
      widget.revisions,
      widget.price,
      currentOptions,
    );

    await firestoreService.deleteCart(widget.docId);

    _showAlertDialog(
      'Successfully Add Order',
      'Booking berhasil ditambahkan',
      () {
        Navigator.pop(context);
        _navigatePage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(text: 'Checkout'),
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

                  // * show package choosed from cart
                  Container(
                    decoration: BoxDecoration(
                      color: thirdColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Image.asset(widget.imagePath),
                      title: Text('${widget.name} Package'),
                      subtitle: Text('Rp ${widget.price}k'),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  // * user fill the form
                  const Text(
                    'Form Booking',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    controller: nameController,
                    hintText: 'Full Name',
                    obsecureText: false,
                    readOnly: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    controller: phoneController,
                    hintText: 'No WhatsApp',
                    obsecureText: false,
                    readOnly: false,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // * Payment methode
                  const Text(
                    'Payment',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // * Option 1
                  Container(
                    decoration: BoxDecoration(
                      color: thirdColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RadioListTile(
                      title: const Text(
                        'BCA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text('4321234564'),
                      value: options[0],
                      groupValue: currentOptions,
                      onChanged: (value) {
                        setState(() {
                          currentOptions = value.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // * Option 2
                  Container(
                    decoration: BoxDecoration(
                      color: thirdColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RadioListTile(
                      title: const Text(
                        'BNI',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text('4321234465'),
                      value: options[1],
                      groupValue: currentOptions,
                      onChanged: (value) {
                        setState(() {
                          currentOptions = value.toString();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  MyButton(
                    isVisible: true,
                    text: 'Checkout',
                    onTap: () {
                      _submitForm();
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
