import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app_bloc/blocs/favorite_bloc/favorite_event.dart';
import 'package:learning_app_bloc/blocs/favorite_bloc/favorite_state.dart';
import 'package:learning_app_bloc/repositories/favorite_repository.dart';

import '../../models/favorite_model.dart';
import '../home_bloc/home_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState(favoritesCourses: [])) {
    on<InitialFavoriteEvent>((event, emit) => _emitUpdatedFavorites(emit));
    on<RemoveFromFavoriteEvent>(
      (event, emit) async {
        await FavoriteRepository()
            .removeFromFavorite(id: event.id, price: event.price);
        await _emitUpdatedFavorites(emit);
      },
    );
    on<AddToFavoriteEvent>((event, emit) async {
      await FavoriteRepository()
          .addToFavorite(id: event.id, price: event.price);
      await _emitUpdatedFavorites(emit);
    });
  }
  Future<void> _emitUpdatedFavorites(Emitter<FavoriteState> emit) async {
    List<FavoriteModel> updatedItems =
        await FavoriteRepository().fetchFavoriteCourses();
    emit(FavoriteState(favoritesCourses: updatedItems));
  }
}
