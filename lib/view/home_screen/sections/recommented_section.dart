import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app_bloc/blocs/home_bloc/home_bloc.dart';
import 'package:learning_app_bloc/blocs/home_bloc/home_event.dart';
import 'package:learning_app_bloc/blocs/home_bloc/home_state.dart';
import 'package:learning_app_bloc/view/details/course_details_screen.dart';
import 'package:learning_app_bloc/view/home_screen/widgets/recommended_item_card.dart';

import '../../../models/recommended_course_model.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is HomeErrorState) {
          return const Center(child: Text('Error'));
        } else if (state is HomeLoadedState) {
          List<RecommendedCourseModel> courseList = state.courseList;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recommended for you',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              // context.read<HomeBloc>().add(SelectedCourseEvent(
                              //     course: courseList[index]));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CourseDetailsScreen(),
                                  ));
                            },
                            child:
                                RecommendedItemCard(course: courseList[index]),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemCount: courseList.length,
                      ),
                    ),
                    const SizedBox(width: 35),
                    Column(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                        const SizedBox(height: 60)
                      ],
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
