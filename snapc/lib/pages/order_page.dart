import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapc/components/order_item.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Order',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getOrdersStream(currentUser.email),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List ordersList = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: ordersList.isNotEmpty ? ordersList.length : 1,
                    itemBuilder: (context, index) {
                      if (ordersList.isNotEmpty) {
                        DocumentSnapshot document = ordersList[index];
                        String docId = document.id;
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String name = data['typePackage'];
                        String price = data['total'];
                        String date = data['date'];
                        String status = data['status'];

                        return GestureDetector(
                            onTap: () {},
                            child: OrderItem(
                              docId: docId,
                              date: date,
                              namePackage: name,
                              price: price,
                              status: status,
                            ));
                      } else {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Text(
                              'Order is Empty',
                            ),
                          ),
                        );
                      }
                    },
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  // * Menampilkan Circular Progress Indicator saat mengambil data
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Order is Empty',
                    ),
                  );
                }
              },
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
