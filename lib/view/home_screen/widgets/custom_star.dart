import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final double? size;

  const StarRating({
    super.key,
    required this.rating,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: size ?? 18,
          color: index < rating ? Colors.amber : Colors.grey,
        );
      }),
    );
  }
}
