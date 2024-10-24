class FavoriteEvent {}

class InitialFavoriteEvent extends FavoriteEvent {}

class AddToFavoriteEvent extends FavoriteEvent {
  final int id;
  final num price;
  AddToFavoriteEvent({required this.id, required this.price});
}

class RemoveFromFavoriteEvent extends FavoriteEvent {
  final int id;
  final num price;
  RemoveFromFavoriteEvent({required this.id, required this.price});
}
