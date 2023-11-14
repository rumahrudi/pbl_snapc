import 'package:flutter/material.dart';
import 'package:snapc/components/my_app_bar.dart';

class OrderDetails extends StatefulWidget {
  final String docId;
  final String status;
  final String date;
  final String fullName;
  final String noWa;
  final String payment;
  final String typePackage;
  final String total;
  final String revisions;
  const OrderDetails({
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
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Color getStatusColor() {
    if (widget.status.toLowerCase() == 'belum bayar') {
      return Colors.red;
    } else if (widget.status.toLowerCase() == 'sudah bayar') {
      return Colors.green;
    } else {
      //* Default color
      return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: const MyAppBar(text: 'D E T A I L S'),
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#${widget.docId}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            widget.status,
                            style: TextStyle(
                              color: getStatusColor(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.date),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Booked By',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.fullName,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '(${widget.noWa})',
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Bukit Ayu Lestari Blok B No 11 Sei Beduk',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Payment Methode',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.payment,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Divider(
                      color: Colors.grey[600],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.typePackage,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.status,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Revisions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.revisions,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Additional Features',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Basic photo editing',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Divider(
                      color: Colors.grey[600],
                    ),
                  ),
                  // * noted
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Note',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Please Make Payment')
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Divider(
                      color: Colors.grey[600],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 05),
                      leading: Container(
                        width: 50,
                        child: const Center(
                          child: Icon(
                            Icons.drive_file_move,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      title: const Text(
                        'Your Photos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text('Check your Photo'),
                      trailing: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Visit',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 05),
                      leading: Container(
                        width: 50,
                        child: const Center(
                          child: Icon(
                            Icons.support_agent,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      title: const Text(
                        'Need Support ?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text('Chat with Us'),
                      trailing: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Chat',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
