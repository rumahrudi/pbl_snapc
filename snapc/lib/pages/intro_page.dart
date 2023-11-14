import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapc/components/my_button.dart';
import 'package:snapc/pages/home_page.dart';
// import 'package:snapc/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // * logo
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset(
                  'lib/images/logo.png',
                  height: 240,
                ),
              ),
              Text(
                'Snap Cuisine',
                style: GoogleFonts.dmSerifDisplay(
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              // * title
              const Text(
                'Capturing the Essence of Food',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              // * sub title
              const Text(
                'Showcasing Culinary Artistry Through Stunning Imagery',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 48,
              ),
              // * start now
              MyButton(
                text: 'Book Now',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(initialPageIndex: 0),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
