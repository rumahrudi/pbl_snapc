import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snapc/admin_pages/edit_box.dart';
import 'package:snapc/components/date_field.dart';
import 'package:snapc/components/list_tile_button.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/components/my_gap.dart';
import 'package:snapc/database/firestore.dart';
import 'package:snapc/theme/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderItemEdit extends StatefulWidget {
  final String email;
  final String docId;
  final String orderOn;
  const OrderItemEdit({
    super.key,
    required this.email,
    required this.docId,
    required this.orderOn,
  });

  @override
  State<OrderItemEdit> createState() => _OrderItemEditState();
}

class _OrderItemEditState extends State<OrderItemEdit> {
  // * firestore
  final FirestoreService firestoreService = FirestoreService();

  // * all user collection
  final userOrder = FirebaseFirestore.instance.collection('Orders');

  // * global key
  GlobalKey<FormState> key = GlobalKey();

  // * open whatsapp
  void openWhatsApp(String phoneNumber, String message) async {
    final url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // * colour status
  Color getStatusColor(String status) {
    if (status.toLowerCase() == 'payment') {
      return Colors.red;
    } else if (status.toLowerCase() == 'finish') {
      return Colors.green;
    } else if (status.toLowerCase() == 'photo session') {
      return Colors.purple;
    } else {
      //* Default color
      return secondaryColor;
    }
  }

  // * payment methode status

  String _getNorek(String payment) {
    if (payment.toLowerCase() == 'bni') {
      return ' (4321234465)';
    } else {
      return ' (4321234564)';
    }
  }

  // * get add features

  String _getAddFeature(String typePackage) {
    if (typePackage.toLowerCase() == 'basic') {
      return 'Not Available';
    } else if (typePackage.toLowerCase() == 'standart') {
      return 'Basic Photo Editing';
    } else {
      return 'Advanced Photo Editing';
    }
  }

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
      if (value != null) {
        setState(() {
          _dateTime = value;
        });
      }
    });
  }

  //* Function to show AlertDialog
  void _showAlertDialog(
      String title, String content, void Function()? onPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor:
            secondaryColor, // Sesuaikan warna latar belakang sesuai keinginan
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

  // * upadte date order
  void _submitForm() async {
    //* Pemeriksaan hari untuk Sabtu atau Minggu
    if (_dateTime.weekday == DateTime.saturday ||
        _dateTime.weekday == DateTime.sunday) {
      _showAlertDialog(
        'Invalid Date',
        'Sorry, you cannot select a holiday (Saturday or Sunday)',
        () {
          Navigator.pop(context);
        },
      );
      return;
    }

    //* Pemeriksaan apakah tanggal sudah penuh
    final QuerySnapshot<Map<String, dynamic>> orders = await FirebaseFirestore
        .instance
        .collection('Orders')
        .where('date',
            isEqualTo: DateFormat('EEEE, MMMM d, y').format(_dateTime))
        .get();

    if (orders.docs.length >= 3) {
      _showAlertDialog(
        'An Error Occurred',
        'Maaf, tanggal tersebut sudah penuh.',
        () {
          Navigator.pop(context);
        },
      );
      return;
    }

    await firestoreService.updateScheduleAdmin(
      widget.docId,
      DateFormat('EEEE, MMMM d, y').format(_dateTime),
    );

    _showAlertDialog(
      'Success',
      'Successfully Update Order',
      () {
        Navigator.pop(context);
      },
    );
  }

  // * edit field
  Future<void> editField(String field, String initialValue) async {
    String originalValue = initialValue; // Store the original value
    String newValue = '';

    TextEditingController controller =
        TextEditingController(text: initialValue);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: Text(
          'Edit $field',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter new $field',
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // * cancel button
          TextButton(
            onPressed: () {
              // If Cancel is pressed, reset the value to the original value
              newValue = originalValue;
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // * save button
          TextButton(
            onPressed: () {
              // Only update when Save is pressed
              Navigator.of(context).pop(newValue);
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );

    if (newValue.trim().isNotEmpty && newValue != originalValue) {
      // * only update when there is something in textfield and the value has changed
      await userOrder.doc(widget.docId).update(
        {field: newValue},
      );
    }
  }

  // * edit status with radio button
  Future<void> editRadioField(
      String field, String initialValue, List<String> options) async {
    String originalValue = initialValue;
    String selectedValue = initialValue;
    bool isCancelled = false;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: secondaryColor,
          title: Text(
            'Edit $field',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return RadioListTile(
                title: Text(
                  option,
                  style: const TextStyle(color: Colors.white),
                ),
                value: option,
                groupValue: selectedValue,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                isCancelled = true;
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedValue);
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );

    if (!isCancelled && selectedValue != originalValue) {
      await userOrder.doc(widget.docId).update(
        {field: selectedValue},
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(text: 'Order Details'),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .doc(widget.docId)
            .snapshots(),
        builder: (context, snapshot) {
          // * ger user data
          if (snapshot.hasData) {
            final ordersData = snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '#${widget.docId}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(ordersData['date']),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text('Booked By',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              ordersData['fullName'],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${'( ' + ordersData['noWa']} )',
                            )
                          ],
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Order On',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.orderOn,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: Divider(
                            color: Colors.grey[600],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // * type package
                            Text(
                              ordersData['typePackage'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            // * total
                            Text(
                              '${'Rp ' + ordersData['total']}K',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Additional Features',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          _getAddFeature(ordersData['typePackage']),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Revisions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ordersData['revisions'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: Divider(
                            color: Colors.grey[600],
                          ),
                        ),
                        // * payment
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //  * payment methode (Bank)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Payment Methode',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  ordersData['paymentMethode'] +
                                      _getNorek(ordersData['paymentMethode']),
                                ),
                              ],
                            ),

                            // * status
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: getStatusColor(ordersData['status']),
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  ordersData['status'],
                                  style: TextStyle(
                                    color: getStatusColor(ordersData['status']),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const MyGap(
                          height: 15,
                          isVisible: true,
                        ),
                        MyTileButton(
                            onTap: () {},
                            isVisible: true,
                            icon: Icons.photo_album,
                            title: 'Show Proof Image',
                            subtitle: 'Tap to show image',
                            onPressed: () {},
                            textButton: 'Show',
                            colorTile: Colors.blue[100],
                            color: Colors.blue),
                        MyTileButton(
                            onTap: () {
                              launchUrlString(
                                  'https://drive.google.com/drive/folders/1hoZD_pxhRzgETAJjfKfmp8q-uxZmUUzF?usp=sharing');
                            },
                            isVisible: true,
                            icon: Icons.drive_file_move,
                            title: 'User Photos',
                            subtitle: 'Check user Photos',
                            onPressed: () {},
                            textButton: 'Visit',
                            colorTile: Colors.green[100],
                            color: Colors.green),

                        MyTileButton(
                            onTap: () {
                              openWhatsApp(ordersData['noWa'],
                                  '*Kode pesanan:* ${widget.docId}\n*Name:* ${ordersData['fullName']}\n*Package:* ${ordersData['typePackage']}\n*Status:* ${ordersData['status']}');
                            },
                            isVisible: true,
                            icon: Icons.support_agent,
                            title: 'Support ?',
                            subtitle: 'Chat with User',
                            onPressed: () {},
                            textButton: 'Chat',
                            colorTile: Colors.red[100],
                            color: Colors.red),

                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: Divider(
                            color: Colors.grey[600],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Change Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        EditBox(
                          sectionName: 'Status',
                          text: ordersData['status'],
                          onPressed: () {
                            editRadioField('status', ordersData['status'], [
                              'Payment',
                              'Confirmation',
                              'Schedule',
                              'Photo session',
                              'Editing',
                              'Finish',
                            ]);
                          },
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Rename',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),

                        EditBox(
                          sectionName: 'Name',
                          text: ordersData['fullName'],
                          onPressed: () =>
                              editField('fullName', ordersData['fullName']),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Edit No.Wa',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        EditBox(
                          sectionName: 'No Wa',
                          text: ordersData['noWa'],
                          onPressed: () =>
                              editField('noWa', ordersData['noWa']),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Edit Revision Left',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),

                        EditBox(
                          sectionName: 'Revision',
                          text: ordersData['revisions'],
                          onPressed: () =>
                              editField('revisions', ordersData['revisions']),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Edit Link Drive',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        EditBox(
                          sectionName: 'Link Drive',
                          text: ordersData['linkDrive'],
                          onPressed: () =>
                              editField('linkDrive', ordersData['linkDrive']),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Reschedule',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),

                        DateField(
                          isVisible: true,
                          onTap: _showDatePicker,
                          hintText:
                              DateFormat('EEEE, MMMM d, y').format(_dateTime),
                        ),
                        const MyGap(
                          height: 15,
                          isVisible: true,
                        ),
                        // * shedule button
                        MyButton(
                          text: 'Reschedule',
                          onTap: _submitForm,
                          isVisible: true,
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // * Menampilkan Circular Progress Indicator saat mengambil data
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Eror${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            // Tampilkan pesan atau widget lain jika data tidak tersedia
            return const Center(child: Text('Order not available'));
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
