import 'package:flutter/material.dart';
import 'package:snapc/admin_pages/order_list_page.dart';
import 'package:snapc/components/list_tile_button.dart';
import 'package:snapc/components/my_app_bar.dart';
import 'package:snapc/theme/colors.dart';

class AdminOrder extends StatefulWidget {
  const AdminOrder({super.key});

  @override
  State<AdminOrder> createState() => _AdminOrderState();
}

class _AdminOrderState extends State<AdminOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: 'Orders'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTileButton(
              icon: Icons.payment,
              title: 'Payment',
              subtitle: 'Waiting for payment',
              onPressed: () {},
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderList(status: 'Payment'),
                  ),
                );
              },
              textButton: 'Check',
              colorTile: Colors.red[100],
              color: Colors.red,
              isVisible: true,
            ),
            MyTileButton(
              icon: Icons.confirmation_num,
              title: 'Confirmation',
              subtitle: 'Need confirmation',
              onPressed: () {},
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const OrderList(status: 'Confirmation'),
                  ),
                );
              },
              textButton: 'Check',
              colorTile: Colors.orange[100],
              color: secondaryColor,
              isVisible: true,
            ),
            MyTileButton(
              icon: Icons.calendar_month,
              title: 'Schedule',
              subtitle: 'Waiting schedule',
              onPressed: () {},
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderList(status: 'Schedule'),
                  ),
                );
              },
              textButton: 'Check',
              colorTile: Colors.orange[100],
              color: secondaryColor,
              isVisible: true,
            ),
            MyTileButton(
              icon: Icons.photo_camera,
              title: 'Photo Session',
              subtitle: 'Ready for photo session',
              onPressed: () {},
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const OrderList(status: 'Photo session'),
                  ),
                );
              },
              textButton: 'Check',
              colorTile: Colors.purple[100],
              color: Colors.purple,
              isVisible: true,
            ),
            MyTileButton(
              icon: Icons.computer,
              title: 'Editing',
              subtitle: 'Editing Prosess',
              onPressed: () {},
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderList(status: 'Editing'),
                  ),
                );
              },
              textButton: 'Check',
              colorTile: Colors.orange[100],
              color: secondaryColor,
              isVisible: true,
            ),
            MyTileButton(
              icon: Icons.done,
              title: 'Finish',
              subtitle: 'Photos ready',
              onPressed: () {},
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderList(status: 'Finish'),
                  ),
                );
              },
              textButton: 'Check',
              colorTile: Colors.green[100],
              color: Colors.green,
              isVisible: true,
            )
          ],
        ),
      ),
    );
  }
}
