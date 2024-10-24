import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app_bloc/blocs/home_bloc/home_event.dart';
import 'package:learning_app_bloc/blocs/home_bloc/home_state.dart';
import 'package:learning_app_bloc/models/recommended_course_model.dart';
import 'package:learning_app_bloc/repositories/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<FetchDataEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        try {
          List<RecommendedCourseModel> courseList =
              await HomeRepository().getRecommendedCourses();
          emit(HomeLoadedState(courseList: courseList));
        } catch (e) {
          emit(HomeErrorState());
        }
      },
    );
    on<SelectedCourseEvent>((event, emit) {
      emit(SelectedCourseState(course: event.course));
    });
  }
}
