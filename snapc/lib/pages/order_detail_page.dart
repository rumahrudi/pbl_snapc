import 'package:flutter/material.dart';
import 'package:snapc/components/list_tile_button.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/components/my_note.dart';
import 'package:snapc/pages/chat_page.dart';
import 'package:snapc/theme/colors.dart';

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
  final String orderOn;
  final String expiresOn;

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
    required this.orderOn,
    required this.expiresOn,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Color getStatusColor() {
    if (widget.status.toLowerCase() == 'payment') {
      return Colors.red;
    } else if (widget.status.toLowerCase() == 'finish') {
      return Colors.green;
    } else {
      //* Default color
      return secondaryColor;
    }
  }

  // * if status = payment
  bool shouldShowButton(List<String> allowedStatusList) {
    String lowerCaseStatus = widget.status.toLowerCase();
    for (String allowedStatus in allowedStatusList) {
      if (lowerCaseStatus == allowedStatus.toLowerCase()) {
        return true;
      }
    }
    return false;
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
        backgroundColor: Colors.white,
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
                      'Order On',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.orderOn,
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
                        // * type package
                        Text(
                          '${widget.typePackage} Package',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        // * total
                        Text(
                          'Rp ${widget.total}K',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
                    // * payment
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //  * payment methode (Bank)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                          ],
                        ),

                        // * status
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: getStatusColor(),
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
                      height: 15,
                    ),

                    // * expires on
                    const Text(
                      'Expires On',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(widget.expiresOn),

                    // * noted
                    MyNote(
                      isVisible: shouldShowButton(['payment']),
                    ),

                    MyTileButton(
                        isVisible: shouldShowButton(
                          ['payment'],
                        ),
                        icon: Icons.photo_album,
                        title: 'Upload Proof',
                        subtitle: 'Proof your Payment',
                        onPressed: () {},
                        textButton: 'Upload',
                        colorTile: Colors.blue[100],
                        color: Colors.blue),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                      ),
                      child: Divider(
                        color: Colors.grey[600],
                      ),
                    ),
                    MyTileButton(
                        isVisible: shouldShowButton(['editing', 'finish']),
                        icon: Icons.drive_file_move,
                        title: 'Your Photos',
                        subtitle: 'Check your Photos',
                        onPressed: () {},
                        textButton: 'Visit',
                        colorTile: Colors.green[100],
                        color: Colors.green),

                    MyTileButton(
                        isVisible:
                            shouldShowButton(['payment', 'editing', 'finish']),
                        icon: Icons.support_agent,
                        title: 'Need Support ?',
                        subtitle: 'Chat with Us',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(),
                            ),
                          );
                        },
                        textButton: 'Chat',
                        colorTile: Colors.red[100],
                        color: Colors.red),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
