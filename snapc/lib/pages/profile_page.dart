import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/components/text_box.dart';
import 'package:snapc/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // * user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // * all user collection
  final userCollection = FirebaseFirestore.instance.collection('Users');

  // * edit field
  Future<void> editField(String field) async {
    String newValue = '';
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
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          // * save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
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
    if (newValue.trim().isNotEmpty) {
      // * only update when there is something in textfield
      await userCollection.doc(currentUser.email).update(
        {field: newValue},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const MyAppBar(text: 'My Profile'),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            // * ger user data
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  // * profile picture
                  const SizedBox(
                    height: 25,
                  ),
                  Icon(
                    Icons.person,
                    size: 72,
                    color: secondaryColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // * user email
                  Text(
                    currentUser.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // * userdetails
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'My Details',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  // * username
                  MyTextBox(
                    sectionName: 'Username',
                    text: userData['username'],
                    onPressed: () => editField('username'),
                  ),
                  // * user bio
                  MyTextBox(
                    sectionName: 'Bio',
                    text: userData['bio'],
                    onPressed: () => editField('bio'),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Eror${snapshot.error}'),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
