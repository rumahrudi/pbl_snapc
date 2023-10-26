import 'package:flutter/material.dart';
import 'package:snapc/pages/about_page.dart';
import 'package:snapc/pages/profile_page.dart';

void goToProfilePage(BuildContext context) {
  // Pop the drawer
  Navigator.pop(context);

  // Navigate to the profile page
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ProfilePage(),
    ),
  );
}

void goToAboutPage(BuildContext context) {
  // Pop the drawer
  Navigator.pop(context);

  // Navigate to the About page
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AboutPage(),
    ),
  );
}
