import 'dart:convert';
import 'package:http/http.dart';
import 'package:learning_app_bloc/models/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRepository {
  Future<List<FavoriteModel>> fetchFavoriteCourses() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    Response response = await get(
        Uri.parse('http://learningapp.e8demo.com/api/wishlist/'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<FavoriteModel> itemsList = (data['data']['wishlist'] as List)
          .map(
            (e) => FavoriteModel.fromJson(e),
          )
          .toList();

      return itemsList;
    }
    return [];
  }

  addToFavorite({required int id, required num price}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    await post(Uri.parse('http://learningapp.e8demo.com/api/wishlist/'),
        body: jsonEncode({'course': id, 'price': price, 'variant': 1}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        });
  }

  removeFromFavorite({required int id, required num price}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    Response response = await put(
        Uri.parse('http://learningapp.e8demo.com/api/wishlist/'),
        body: jsonEncode({'course': id, 'variant': 1}),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        });
    print(response.body);
  }
}
