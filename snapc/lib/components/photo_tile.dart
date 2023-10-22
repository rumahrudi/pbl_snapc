import 'package:flutter/material.dart';
import 'package:snapc/models/photo.dart';
import 'package:snapc/theme/colors.dart';

class PhotoTile extends StatelessWidget {
  void Function()? onTap;
  Photo photo;
  PhotoTile({super.key, required this.photo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
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
            photo.subtitile,
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
                    SizedBox(
                      height: 5,
                    ),
                    // * price
                    Text(
                      '\Rp' + photo.price,
                      style: TextStyle(color: Colors.grey),
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Icon(
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
