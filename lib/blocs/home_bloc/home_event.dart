import '../../models/recommended_course_model.dart';

class HomeEvent {}

class FetchDataEvent extends HomeEvent {}

class SelectedCourseEvent extends HomeEvent {
  RecommendedCourseModel course;
  SelectedCourseEvent({required this.course});
}
