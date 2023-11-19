import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snapc/components/order_item.dart';
import 'package:snapc/database/firestore.dart';
import 'package:snapc/pages/order_detail_page.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  // * get current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // * firestore
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
                String date = data['date'];
                String status = data['status'];
                String payment = data['paymentMethode'];
                String total = data['total'];
                // String email = data['email'];
                String revisions = data['revisions'];
                String typePackage = data['typePackage'];
                String fullName = data['fullName'];
                String noWa = data['noWa'];
                Timestamp timeStamp = data['timeStamp'];

                // * covert timeStamp to dateTime
                DateTime orderDateTime = timeStamp.toDate();

                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetails(
                            docId: docId,
                            fullName: fullName,
                            noWa: noWa,
                            status: status,
                            date: date,
                            payment: payment,
                            revisions: revisions,
                            total: total,
                            typePackage: typePackage,
                            orderOn: DateFormat('EEEE, MMMM d, y')
                                .format(orderDateTime),
                          ),
                        ),
                      );
                    },
                    child: OrderItem(
                      docId: docId,
                      date: date,
                      namePackage: name,
                      price: total,
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
        } else if (snapshot.connectionState == ConnectionState.waiting) {
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
    );
  }
}
