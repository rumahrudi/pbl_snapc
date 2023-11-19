import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:snapc/components/my_app_bar.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('Images');

  String imageUrl = '';

  XFile?
      _pickedImage; // Menambahkan variabel untuk menyimpan gambar yang dipilih

  Future<void> _pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${_pickedImage?.path}');
    if (_pickedImage != null) {
      setState(() {});
    }
  }

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
      // Handle error, if necessary
    }
  }

  void _submitForm() async {
    print("Submitting form...");
    await _uploadImage();
    print("Image uploaded. Image URL: $imageUrl");

    if (imageUrl.isEmpty) {
      print("Image URL is empty. Showing snackbar.");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload an image')));
      return;
    }

    if (key.currentState!.validate()) {
      print("Form validation passed. Adding data to Firestore.");

      String itemName = _controllerName.text;
      String itemQuantity = _controllerQuantity.text;

      Map<String, String> dataToSend = {
        'name': itemName,
        'quantity': itemQuantity,
        'image': imageUrl,
      };

      try {
        await _reference.add(dataToSend);
        print("Data added to Firestore.");
      } catch (error) {
        print("Error adding data to Firestore: $error");
        // Handle error, if necessary
      }

      // Setelah data dikirim, reset variabel dan form
      _resetForm();
      print("Form reset.");
    }
  }

  void _resetForm() {
    setState(() {
      _controllerName.clear();
      _controllerQuantity.clear();
      _pickedImage = null;
      imageUrl = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: 'Add Image Test'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerName,
                decoration: const InputDecoration(
                    hintText: 'Enter the name of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _controllerQuantity,
                decoration: const InputDecoration(
                    hintText: 'Enter the quantity of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item quantity';
                  }

                  return null;
                },
              ),
              _pickedImage != null
                  ? Image.file(
                      File(_pickedImage!.path),
                      height: 150,
                    )
                  : Container(),
              IconButton(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
