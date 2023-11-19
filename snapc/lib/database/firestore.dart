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

  // * get collection of gallery
  final CollectionReference gallery =
      FirebaseFirestore.instance.collection('Gallery');

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
    String revisions,
    String total,
    String paymentMethode,
  ) {
    return orders.add({
      'typePackage': typePackage,
      'email': email,
      'fullName': fullName,
      'noWa': noWa,
      'date': 'Not Schedule',
      'timeStamp': Timestamp.now(),
      'revisions': revisions,
      'total': total,
      'paymentMethode': paymentMethode,
      'status': 'Payment',
      'linkDrive': 'not available',
      'proofPayment': 'No Image'
    });
  }

  // * add to gallery
  Future<void> addToGallery() {
    return gallery.add({
      'type': 'Basic',
      'timeStamp': Timestamp.now(),
      'link': 'lib/images/logo.png'
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

  // * read gallery
  Stream<QuerySnapshot> getGalleryStream() {
    final galleryStream =
        gallery.orderBy('timeStamp', descending: true).snapshots();

    return galleryStream;
  }

  // ? UPDATE

  // * update proof order
  Future<void> updateProofOrder(
    String docId,
    String proofPayment,
  ) {
    return orders.doc(docId).update({
      'proofPayment': proofPayment,
      'status': 'Confirmation',
      'timeStamp': Timestamp.now(),
    });
  }

  // * update schedule order
  Future<void> updateSchedule(
    String docId,
    String date,
  ) {
    return orders.doc(docId).update({
      'date': date,
      'status': 'Photo session',
      'timeStamp': Timestamp.now(),
    });
  }

  // ? DELETE

  // ! delete cart given doc id
  Future<void> deleteCart(String docId) {
    return cart.doc(docId).delete();
  }
}
