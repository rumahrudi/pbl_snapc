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
    String total,
    String paymentMethode,
  ) {
    // Calculate expiration timestamp (current timestamp + 24 hours)
    DateTime expirationDateTime = DateTime.now().add(const Duration(hours: 24));
    Timestamp expirationTimestamp = Timestamp.fromDate(expirationDateTime);

    return orders.add({
      'typePackage': typePackage,
      'email': email,
      'fullName': fullName,
      'noWa': noWa,
      'date': date,
      'address': address,
      'timeStamp': Timestamp.now(),
      'expirationTimestamp': expirationTimestamp,
      'revisions': revisions,
      'total': total,
      'paymentMethode': paymentMethode,
      'status': 'Payment',
      'linkDrive': 'not available',
    });
  }

  // ? READ

  // * read packages
  Stream<QuerySnapshot> getPackagesStream() {
    final packagesStream = packages.orderBy(FieldPath.documentId).snapshots();

    return packagesStream;
  }

  // * read cart
  Stream<QuerySnapshot> getCartStream(String? currentUser) {
    final cartStream = cart
        .where('email', isEqualTo: currentUser)
        .orderBy('timeStamp', descending: true)
        .snapshots();

    return cartStream;
  }

  // * read orders
  Stream<QuerySnapshot> getOrdersStream(String? currentUser) {
    final ordersStream = orders
        .where('email', isEqualTo: currentUser)
        .orderBy('timeStamp', descending: true)
        .snapshots();

    return ordersStream;
  }

  // ? UPDATE

  // ? DELETE

  // ! delete cart given doc id
  Future<void> deleteCart(String docId) {
    return cart.doc(docId).delete();
  }
}
