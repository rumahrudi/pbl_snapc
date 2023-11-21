import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/admin_pages/admin_orders_page.dart';
import 'package:snapc/admin_pages/upload_ref.dart';
import 'package:snapc/admin_pages/user_list_page.dart';
import 'package:snapc/auth/auth.dart';
import 'package:snapc/components/admin_card.dart';
import 'package:snapc/database/firestore.dart';
import 'package:snapc/theme/colors.dart';

class Dasboard extends StatefulWidget {
  const Dasboard({super.key});

  @override
  State<Dasboard> createState() => _DasboardState();
}

class _DasboardState extends State<Dasboard> {
  // * user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // * firestore
  final FirestoreService firestoreService = FirestoreService();

  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const AuthPage(),
      ),
    );
  }

  void allertAddToGallery() {
    // ! Allert succesfully add to cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: const Center(
          child: Text(
            'Success',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: const Text(
          'Successfully Add to Gallery',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () {
              signOut(context);
            },
          ),
          actions: [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.shopping_bag_rounded,
                color: secondaryColor,
              ),
            )
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Center(
            child: Text(
              'A D M I N',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              AdminCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserList(),
                    ),
                  );
                },
                icon: Icons.person,
                title: 'U S E R S',
                color: thirdColor,
              ),
              AdminCard(
                color: thirdColor,
                icon: Icons.message,
                title: 'C H A T S',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyUpload(),
                    ),
                  );
                },
              ),
              AdminCard(
                onTap: () {},
                icon: Icons.date_range,
                title: 'S C H E D U L E',
                color: thirdColor,
              ),
              AdminCard(
                color: thirdColor,
                icon: Icons.shopping_bag,
                title: 'O R D E R S',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminOrder(),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
