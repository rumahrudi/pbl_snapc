import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snapc/components/photo_tile.dart';
import 'package:snapc/models/cart.dart';
import 'package:snapc/models/photo.dart';
import 'package:snapc/pages/page_details.dart';
import 'package:snapc/theme/colors.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // * add photo package to cart
  void addPhotoPackageToCart(Photo photo) {
    Provider.of<Cart>(context, listen: false).addItemToCart(photo);

    // ! alert user ,show successfully added
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: Center(
          child: Text(
            'Successfully Added',
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: Text(
          'Check your cart',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void navigateToPackageDetail(BuildContext context, int index) {
    Photo selectedPhoto =
        Provider.of<Cart>(context, listen: false).getPhotoList()[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageDetails(
          photo: selectedPhoto,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          // * Search bar
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Search',
                  style: TextStyle(color: Colors.grey),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                Text(
                  'See all',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),

          // * list of photo package
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // * create photo package
                Photo photo = value.getPhotoList()[index];
                // * return photo package
                return GestureDetector(
                  onTap: () => navigateToPackageDetail(context, index),
                  child: PhotoTile(
                    photo: photo,
                    onTap: () => addPhotoPackageToCart(photo),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Divider(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
