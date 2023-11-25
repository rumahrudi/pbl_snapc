import 'package:flutter/material.dart';
import 'package:snapc/components/package_card.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // * Search bar
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.home_filled,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        // * message
        Padding(
          padding: const EdgeInsets.all(25),
          child: Text(
            'Showcasing Culinary Artistry Through Stunning Imagery',
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ),
        // * hot pics
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Hot Package',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              // Text(
              //   'See all',
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color: Colors.grey[600],
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        // * list of photo package
        const Expanded(
          child: PackageCard(),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 25,
            left: 25,
            right: 25,
          ),
          child: Divider(
            color: Colors.grey[200],
          ),
        )
      ],
    );
  }
}
