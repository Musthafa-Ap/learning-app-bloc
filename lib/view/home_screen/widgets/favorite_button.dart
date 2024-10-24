import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final Function()? onTap;

  const FavoriteButton({super.key, required this.isFavorite, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border_sharp,
        color: isFavorite ? Colors.red : Colors.white,
      ),
    );
  }
}
