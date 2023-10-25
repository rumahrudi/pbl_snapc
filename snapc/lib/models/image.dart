import 'package:flutter/material.dart';

class ImageProvider with ChangeNotifier {
  Map<String, List<String>> _cardImages = {
    'Basic': [
      'assets/basic_image1.png',
      'assets/basic_image2.png',
      // Gambar-gambar untuk jenis kartu Basic
    ],
    'Standart': [
      'assets/standart_image1.png',
      'assets/standart_image2.png',
      // Gambar-gambar untuk jenis kartu Standart
    ],
    'Premium': [
      'assets/premium_image1.png',
      'assets/premium_image2.png',
      // Gambar-gambar untuk jenis kartu Premium
    ],
  };

  List<String> getImagesForCard(String cardType) {
    return _cardImages[cardType] ?? [];
  }
}
