import 'dart:convert';
import 'package:http/http.dart';
import 'package:learning_app_bloc/models/recommended_course_model.dart';
import 'package:learning_app_bloc/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  Future<List<RecommendedCourseModel>> getRecommendedCourses() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    Uri url = Uri.parse('${baseUrl}recommended_courses/');
    print(token);
    Response response =
        await get(url, headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<RecommendedCourseModel> courseList = (data['data'] as List)
          .map(
            (e) => RecommendedCourseModel.fromJson(e),
          )
          .toList();

      return courseList;
    } else {
      throw Exception();
    }
  }
}
