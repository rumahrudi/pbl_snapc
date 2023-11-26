import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/admin_pages/admin_orders_page.dart';
import 'package:snapc/admin_pages/schedule_page.dart';
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
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: () {
              signOut(context);
            },
          ),
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.shopping_bag_rounded,
                color: Colors.transparent,
              ),
            )
          ],
          // iconTheme: const IconThemeData(color: Colors.white),
          title: const Center(
            child: Text(
              'Admin Dashboard',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: GridView.count(
            crossAxisCount: 1,
            children: [
              AdminCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShcedulePage(),
                    ),
                  );
                },
                linkImage: 'lib/images/schedule.png',
                title: 'S C H E D U L E',
                color: Colors.grey[200],
              ),
              AdminCard(
                color: Colors.grey[200],
                linkImage: 'lib/images/order.png',
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
