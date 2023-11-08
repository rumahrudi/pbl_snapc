import 'package:flutter/material.dart';
import 'package:snapc/components/date_field.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/components/my_textfield.dart';
import 'package:intl/intl.dart';

// import 'package:snapc/theme/colors.dart';

class CheckoutPage extends StatefulWidget {
  final String name;
  final String imagePath;
  final String price;
  const CheckoutPage({
    super.key,
    required this.name,
    required this.imagePath,
    required this.price,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // * text controller
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  // * date time now

  DateTime _dateTime = DateTime.now();

  // * show date picker

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            hintText: 'No Whatsapp',
                            obsecureText: false,
                            readOnly: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DateField(
                            onTap: _showDatePicker,
                            hintText:
                                DateFormat('EEEE, MMMM d, y').format(_dateTime),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                              controller: addressController,
                              hintText: 'Full Address',
                              obsecureText: false,
                              readOnly: false),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  MyButton(
                    text: 'Checkout',
                    onTap: () {},
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
