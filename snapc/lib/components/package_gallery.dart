import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snapc/database/firestore.dart';

class PackageGallery extends StatefulWidget {
  final String type;
  const PackageGallery({
    super.key,
    required this.type,
  });

  @override
  State<PackageGallery> createState() => _PackageGalleryState();
}

class _PackageGalleryState extends State<PackageGallery> {
  // * firestore
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getGalleryStream(widget.type),
        builder: (context, snapshot) {
          // * if we have data
          if (snapshot.hasData) {
            List galleryList = snapshot.data!.docs;

            // * display as list
            return ListView.builder(
              itemCount: galleryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DocumentSnapshot document = galleryList[index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String link = data['link'];

                return Container(
                  margin: const EdgeInsets.only(left: 15),
                  height: 150,
                  child: Image.network(link),
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
              child: Text('no image'),
            );
          }
        });
  }
}
