import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // * get collection of packages
  final CollectionReference packages =
      FirebaseFirestore.instance.collection('Packages');

  // * get collection of cart
  final CollectionReference cart =
      FirebaseFirestore.instance.collection('Cart');

  // * get collection of orders
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('Orders');

  // ? CREATE

  // * add to cart
  Future<void> addToCart(
    String email,
    String name,
    String price,
    String imagePath,
    String revisions,
  ) {
    return cart.add({
      'email': email,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'revisions': revisions,
      'timeStamp': Timestamp.now(),
    });
  }

  // * add to orders
  Future<void> addToOrders(
    String typePackage,
    String email,
    String fullName,
    String noWa,
    String date,
    String address,
    String revisions,
  ) {
    return orders.add({
      'typePackage': typePackage,
      'email': email,
      'fullName': fullName,
      'noWa': noWa,
      'date': date,
      'address': address,
      'timeStamp': Timestamp.now(),
      'revisions': revisions,
    });
  }

  // ? READ

  // * read packages
  Stream<QuerySnapshot> getPackagesStream() {
    final packagesStream = packages.orderBy(FieldPath.documentId).snapshots();

    return packagesStream;
  }

  // * get package by name
  Stream<QuerySnapshot> getPackagesByName(String namePackage) {
    final packageByName =
        packages.where('name', isEqualTo: namePackage).snapshots();

    return packageByName;
  }

  // * read cart
  Stream<QuerySnapshot> getCartStream(String? currentUser) {
    final cartStream = cart
        .where('email', isEqualTo: currentUser)
        .orderBy('timeStamp', descending: true)
        .snapshots();

    return cartStream;
  }

  // ? UPDATE

  // ? DELETE

  // ! delete cart given doc id
  Future<void> deleteCart(String docId) {
    return cart.doc(docId).delete();
  }
}
