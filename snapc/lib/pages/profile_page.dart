import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/components/text_box.dart';
import 'package:snapc/theme/colors.dart';
// import 'package:snapc/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // * user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // * edit field
  Future<void> editField(String field) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
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
                    height: 50,
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
                  SizedBox(
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
                    sectionName: 'username',
                    text: userData['username'],
                    onPressed: () => editField('username'),
                  ),
                  // * user bio
                  MyTextBox(
                    sectionName: 'bio',
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
