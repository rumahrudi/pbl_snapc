import 'package:flutter/material.dart';
import 'package:snapc/theme/colors.dart';

class OrderItem extends StatefulWidget {
  final String email;
  final String docId;
  final String date;
  final String namePackage;
  final String price;
  final String status;
  const OrderItem({
    super.key,
    required this.email,
    required this.docId,
    required this.date,
    required this.namePackage,
    required this.price,
    required this.status,
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  // * get status color
  Color getStatusColor() {
    if (widget.status.toLowerCase() == 'payment') {
      return Colors.red;
    } else if (widget.status.toLowerCase() == 'finish') {
      return Colors.green;
    } else if (widget.status.toLowerCase() == 'photo session') {
      return Colors.purple;
    } else {
      //* Default color
      return secondaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${widget.docId}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(widget.date),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.namePackage} Package',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp ${widget.price}k',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Order by',
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  IconButton(
                    icon: Icon(
                      Icons.support_agent,
                      color: secondaryColor,
                    ),
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
