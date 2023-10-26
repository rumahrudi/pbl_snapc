import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:snapc/components/botttom_nav_bar.dart';
import 'package:snapc/components/my_drawer.dart';
import 'package:snapc/components/navigation_utils.dart';
// import 'package:snapc/models/cart.dart';
import 'package:snapc/pages/cart_page.dart';
// import 'package:snapc/pages/page_details.dart';
import 'package:snapc/pages/shop_page.dart';
import 'package:snapc/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // * this selected index to controll the bottom nav bar

  int _selectedIndex = 0;
  // * this method to update selected index
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // * Page to display
  final List<Widget> _pages = [
    // * home page
    const ShopPage(),
    // * cart page
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_bag_rounded,
              color: secondaryColor,
            ),
          )
        ],
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Icon(
                Icons.menu,
                color: secondaryColor,
              ),
            ),
          ),
        ),
      ),
      drawer: MyDrawer(
        onProfileTap: () => goToProfilePage(context),
        onAboutTap: () => goToAboutPage(context),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
