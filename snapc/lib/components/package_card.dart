import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapc/components/package_tile.dart';
import 'package:snapc/database/firestore.dart';
import 'package:snapc/pages/package_details.dart';
import 'package:snapc/theme/colors.dart';

class PackageCard extends StatefulWidget {
  const PackageCard({super.key});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  // * user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // * firestore
  final FirestoreService firestoreService = FirestoreService();

  void allertAddToCart() {
    // ! Allert succesfully add to cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: const Center(
          child: Text(
            'Successfully Add to Cart',
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: const Text(
          'Check yout cart',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getPackagesStream(),
        builder: (context, snapshot) {
          // * if we have data
          if (snapshot.hasData) {
            List packagesList = snapshot.data!.docs;

            // * display as list
            return ListView.builder(
              itemCount: packagesList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DocumentSnapshot document = packagesList[index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String name = data['name'];
                String imagePath = data['image_path'];
                String price = data['price'];
                String decs = data['decs'];
                String rating = data['rating'];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PackagesDetails(
                        name: name,
                        imagePath: imagePath,
                        price: price,
                        decs: decs,
                        rating: rating,
                      ),
                    ));
                  },
                  child: PackageTile(
                    name: name,
                    imagePath: imagePath,
                    price: price,
                    onTap: () {
                      // * add new cart
                      firestoreService.addToCart(
                        currentUser.email!,
                        name,
                        price,
                        imagePath,
                      );
                      // * show alert
                      allertAddToCart();
                    },
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // * Menampilkan Circular Progress Indicator saat mengambil data
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // * if no data
          else {
            return const Center(
              child: Text('no packages'),
            );
          }
        });
  }
}
