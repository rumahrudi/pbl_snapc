import 'package:flutter/material.dart';

class MyTileButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Function() onPressed;
  final Function()? onTap;
  final String textButton;
  final Color? colorTile;
  final Color color;
  final bool isVisible; // Tambahkan properti isVisible

  const MyTileButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.onTap,
    required this.textButton,
    required this.colorTile,
    required this.color,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Gunakan properti isVisible untuk menentukan apakah widget ini harus ditampilkan
    return isVisible
        ? Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              decoration: BoxDecoration(
                color: colorTile,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                onTap: onTap,
                contentPadding: const EdgeInsets.symmetric(horizontal: 05),
                leading: SizedBox(
                  width: 50,
                  child: Center(
                    child: Icon(
                      icon,
                      color: color,
                    ),
                  ),
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  subtitle,
                ),
                trailing: TextButton(
                  onPressed: onPressed,
                  child: Text(
                    textButton,
                    style: TextStyle(
                      color: color,
                    ),
                  ),
                ),
              ),
            ),
          )
        : const SizedBox
            .shrink(); // Jika isVisible adalah false, kembalikan widget kosong
  }
}
