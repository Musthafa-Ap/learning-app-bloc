import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app_bloc/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:learning_app_bloc/blocs/favorite_bloc/favorite_event.dart';
import 'package:learning_app_bloc/blocs/home_bloc/home_bloc.dart';
import 'package:learning_app_bloc/blocs/home_bloc/home_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_screens/login_page.dart';
import 'sections/recommented_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(FetchDataEvent());
    context.read<FavoriteBloc>().add(InitialFavoriteEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            RecommendedSection(),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.clear();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false);
        },
      ),
    );
  }
}
