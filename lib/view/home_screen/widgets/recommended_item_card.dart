import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app_bloc/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:learning_app_bloc/blocs/favorite_bloc/favorite_event.dart';
import 'package:learning_app_bloc/blocs/favorite_bloc/favorite_state.dart';
import 'package:learning_app_bloc/models/recommended_course_model.dart';

import 'favorite_button.dart';
import 'custom_star.dart';

class RecommendedItemCard extends StatelessWidget {
  final RecommendedCourseModel course;
  const RecommendedItemCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(10),
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  bool isFavorite = state.favoritesCourses.any(
                    (element) => element.courseId == course.id,
                  );

                  return FavoriteButton(
                      isFavorite: isFavorite,
                      onTap: () {
                        if (isFavorite) {
                          context.read<FavoriteBloc>().add(
                              RemoveFromFavoriteEvent(
                                  id: course.id ?? 0,
                                  price: course.price ?? 0));
                        } else {
                          context.read<FavoriteBloc>().add(AddToFavoriteEvent(
                              id: course.id ?? 0, price: course.price ?? 0));
                        }
                      });
                },
              )),
          Text(
            course.courseName ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            course.description ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          StarRating(rating: course.rating ?? 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${course.price}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              InkWell(onTap: () {}, child: const Icon(Icons.local_mall)),
            ],
          ),
        ],
      ),
    );
  }
}
