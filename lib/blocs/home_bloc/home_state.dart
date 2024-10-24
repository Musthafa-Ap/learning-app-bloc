import 'package:learning_app_bloc/models/recommended_course_model.dart';

class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  List<RecommendedCourseModel> courseList = [];
  HomeLoadedState({required this.courseList});
}

class HomeErrorState extends HomeState {}

class SelectedCourseState extends HomeState {
  RecommendedCourseModel course;
  SelectedCourseState({required this.course});
}
