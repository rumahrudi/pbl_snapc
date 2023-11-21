import 'package:flutter/material.dart';

class OrderItemEdit extends StatefulWidget {
  final String docId;
  final String status;
  final String date;
  final String fullName;
  final String noWa;
  final String payment;
  final String typePackage;
  final String total;
  final String revisions;
  final String orderOn;
  const OrderItemEdit({
    super.key,
    required this.docId,
    required this.status,
    required this.date,
    required this.fullName,
    required this.noWa,
    required this.payment,
    required this.typePackage,
    required this.total,
    required this.revisions,
    required this.orderOn,
  });

  @override
  State<OrderItemEdit> createState() => _OrderItemEditState();
}

class _OrderItemEditState extends State<OrderItemEdit> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
