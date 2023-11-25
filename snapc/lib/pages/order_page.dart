import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/components/order_card.dart';
import 'package:snapc/database/firestore.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // * get current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // * firestore
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(text: 'My Order'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: OrderCard(),
            ),
          ],
        ),
      ),
    );
  }
}
