import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:snapc/components/my_list_tile.dart';
import 'package:snapc/theme/colors.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onAboutTap;
  const MyDrawer(
      {super.key, required this.onProfileTap, required this.onAboutTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: secondaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // * Logo
              DrawerHeader(
                child: Image.asset(
                  'lib/images/logo.png',
                  color: Colors.white,
                  width: 100,
                ),
              ),
              // * title
              // Text(
              //   'Snap Cuisine',
              //   style: GoogleFonts.dmSerifDisplay(
              //     color: Colors.white,
              //     fontSize: 28,
              //   ),
              // ),

              // * Other Page

              // * Home
              MyListTile(
                icon: Icons.home,
                text: 'H O M E',
                onTap: () {},
              ),
              // * Profile
              MyListTile(
                icon: Icons.person,
                text: 'P R O F I L E',
                onTap: onProfileTap,
              ),
              // * About
              MyListTile(
                icon: Icons.info,
                text: 'A B O U T',
                onTap: onAboutTap,
              ),
            ],
          ),
          MyListTile(
            icon: Icons.logout,
            text: 'L O G O U T',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}