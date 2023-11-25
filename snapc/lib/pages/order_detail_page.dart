import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:snapc/components/date_field.dart';
import 'package:snapc/components/list_tile_button.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/components/my_gap.dart';
import 'package:snapc/components/my_note.dart';
import 'package:snapc/database/firestore.dart';
import 'package:snapc/theme/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderDetails extends StatefulWidget {
  final String docId;
  final String status;
  final String date;
  final String fullName;
  final String noWa;
  final String payment;
  final String typePackage;
  final String total;
  final String revisions;
  final String orderOn;

  const OrderDetails({
    super.key,
    required this.docId,
    required this.status,
    required this.date,
    required this.fullName,
    required this.noWa,
    required this.payment,
    required this.typePackage,
    required this.total,
    required this.revisions,
    required this.orderOn,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  // * firestore
  final FirestoreService firestoreService = FirestoreService();

  // * global key
  GlobalKey<FormState> key = GlobalKey();

  // * open wa apps
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
  Color getStatusColor() {
    if (widget.status.toLowerCase() == 'payment') {
      return Colors.red;
    } else if (widget.status.toLowerCase() == 'finish') {
      return Colors.green;
    } else if (widget.status.toLowerCase() == 'photo session') {
      return Colors.purple;
    } else {
      //* Default color
      return secondaryColor;
    }
  }

  // * payment methode status

  String _getNorek() {
    if (widget.payment.toLowerCase() == 'bni') {
      return ' (4321234465)';
    } else {
      return ' (4321234564)';
    }
  }

  // * get add features

  String _getAddFeature() {
    if (widget.typePackage.toLowerCase() == 'basic') {
      return 'Not Available';
    } else if (widget.typePackage.toLowerCase() == 'standart') {
      return 'Basic Photo Editing';
    } else {
      return 'Advanced Photo Editing';
    }
  }

  // * if status = payment
  bool shouldShowButton(List<String> allowedStatusList) {
    String lowerCaseStatus = widget.status.toLowerCase();
    for (String allowedStatus in allowedStatusList) {
      if (lowerCaseStatus == allowedStatus.toLowerCase()) {
        return true;
      }
    }
    return false;
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

  String imageUrl = '';

  XFile? _pickedImage;

  Future<void> _pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${_pickedImage?.path}');
    if (_pickedImage != null) {
      setState(() {});
    }
  }

  // * upload image
  Future<void> _uploadImage() async {
    if (_pickedImage == null) {
      return;
    }

    try {
      String fileName =
          _pickedImage!.name; // Mengambil nama file asli dari XFile
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');
      Reference referenceImageToUpload = referenceDirImages.child(fileName);

      File imageFile = File(_pickedImage!.path);
      List<int> imageBytes = await imageFile.readAsBytes();

      print("Uploading image to Firebase Storage...");
      await referenceImageToUpload.putData(
        Uint8List.fromList(imageBytes),
        SettableMetadata(contentType: 'auto'),
      );
      print("Image uploaded successfully.");

      print("Getting download URL...");
      imageUrl = await referenceImageToUpload.getDownloadURL();
      print("Download URL: $imageUrl");
    } catch (error) {
      print("Error during image upload: $error");
    }
  }

  // * upate image to database
  void _submitFormImage() async {
    print("Submitting form...");
    await _uploadImage();
    print("Image uploaded. Image URL: $imageUrl");

    if (imageUrl.isEmpty) {
      print("Image URL is empty. Showing snackbar.");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload an image')));
      return;
    }

    await firestoreService.updateProofOrder(
      widget.docId,
      imageUrl,
    );

    _showAlertDialog(
      'Success',
      'Successfully Update Order',
      () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
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

    await firestoreService.updateSchedule(
      widget.docId,
      DateFormat('EEEE, MMMM d, y').format(_dateTime),
    );

    _showAlertDialog(
      'Success',
      'Successfully Update Order',
      () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: const MyAppBar(text: 'Order Details'),
        backgroundColor: Colors.white,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '#${widget.docId}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(widget.date),
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
                          widget.fullName,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '(${widget.noWa})',
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
                          '${widget.typePackage} Package',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // * total
                        Text(
                          'Rp ${widget.total}K',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
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
                          widget.revisions,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                      _getAddFeature(),
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
                              widget.payment + _getNorek(),
                            ),
                          ],
                        ),

                        // * status
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: getStatusColor(),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              widget.status,
                              style: TextStyle(
                                color: getStatusColor(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // * note confirmation
                    MyNote(
                        isVisible: shouldShowButton(['confirmation']),
                        note: 'Please wait confirmation payment from admin'),
                    // * note payment
                    MyNote(
                      isVisible: shouldShowButton(['payment']),
                      note:
                          'Please make Payment according to the selected payment method and upload your proof!',
                    ),
                    MyNote(
                        isVisible: shouldShowButton(['photo session']),
                        note:
                            'Please come to the photo studio according to your schedule on ${widget.date}'),

                    MyTileButton(
                        onTap: _pickImage,
                        isVisible: shouldShowButton(
                          ['payment'],
                        ),
                        icon: Icons.photo_album,
                        title: 'Pick Image',
                        subtitle: 'Tap to pick image',
                        onPressed: () {},
                        textButton: 'Pick',
                        colorTile: Colors.blue[100],
                        color: Colors.blue),
                    MyGap(
                      height: 15,
                      isVisible: shouldShowButton(['payment', 'schedule']),
                    ),
                    // * upload button
                    MyButton(
                      text: 'Upload',
                      onTap: _submitFormImage,
                      isVisible: shouldShowButton(['payment']),
                    ),
                    DateField(
                      isVisible: shouldShowButton(['schedule']),
                      onTap: _showDatePicker,
                      hintText: DateFormat('EEEE, MMMM d, y').format(_dateTime),
                    ),
                    MyGap(
                      height: 15,
                      isVisible: shouldShowButton(['schedule']),
                    ),
                    // * shedule button
                    MyButton(
                      text: 'Schedule',
                      onTap: _submitForm,
                      isVisible: shouldShowButton(
                        ['schedule'],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                      ),
                      child: Divider(
                        color: Colors.grey[600],
                      ),
                    ),
                    MyTileButton(
                        onTap: () {
                          launchUrlString(
                              'https://drive.google.com/drive/folders/1hoZD_pxhRzgETAJjfKfmp8q-uxZmUUzF?usp=sharing');
                        },
                        isVisible: shouldShowButton(
                            ['editing', 'finish', 'photo session']),
                        icon: Icons.drive_file_move,
                        title: 'Your Photos',
                        subtitle: 'Check your Photos',
                        onPressed: () {},
                        textButton: 'Visit',
                        colorTile: Colors.green[100],
                        color: Colors.green),
                    MyTileButton(
                        icon: Icons.map,
                        title: 'Studio Location',
                        subtitle: 'Visit our studio',
                        onPressed: () {},
                        onTap: () {
                          launchUrlString(
                              'https://maps.app.goo.gl/m6cArC3ikRatjVvY8');
                        },
                        textButton: 'Go',
                        colorTile: Colors.blue[100],
                        color: Colors.blue,
                        isVisible: shouldShowButton(['photo session'])),

                    MyTileButton(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ChatPage(),
                          //   ),
                          // );

                          openWhatsApp('+6281364300283',
                              '*Kode pesanan:* ${widget.docId}\n*Name:* ${widget.fullName}\n*Package:* ${widget.typePackage}\n*Status:* ${widget.status}');
                        },
                        isVisible: shouldShowButton([
                          'payment',
                          'schedule',
                          'editing',
                          'finish',
                          'photo session'
                        ]),
                        icon: Icons.support_agent,
                        title: 'Need Support ?',
                        subtitle: 'Chat with Us',
                        onPressed: () {},
                        textButton: 'Chat',
                        colorTile: Colors.red[100],
                        color: Colors.red),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
