import 'package:flutter/material.dart';
import 'package:snapc/models/photo.dart';
import 'package:snapc/theme/colors.dart';

class PhotoTile extends StatelessWidget {
  final Function()? onTap;
  final Photo photo;
  const PhotoTile({
    super.key,
    required this.photo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 25,
      ),
      // padding: EdgeInsets.all(20),
      width: 250,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // * photo picture
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(photo.imagePath),
            ),
          ),
          // * description
          Text(
            '${photo.name} Package',
            style: TextStyle(color: Colors.grey[600]),
          ),
          // * price + details
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * photo package name
                    Text(
                      photo.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // * price
                    Text(
                      '\Rp${photo.price}',
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                // * plus button
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
          // * button add to cart
        ],
      ),
    );
  }
}
