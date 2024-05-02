part of 'favorite_app_bloc.dart';

abstract class FavoriteAppEvent extends Equatable {
  const FavoriteAppEvent();

  List<Object?> get props => [];
}


class FetchFavoriteListEvent extends FavoriteAppEvent{



}

class FavoriteItemEvent extends FavoriteAppEvent{
  final FavoriteItemModel item;

  FavoriteItemEvent({required this.item});

}

class SelectItemEvent extends FavoriteAppEvent{
  final FavoriteItemModel item;

  SelectItemEvent({required this.item});

}

class UnselectItemEvent extends FavoriteAppEvent{
  final FavoriteItemModel item;

  UnselectItemEvent({required this.item});

}

class DeleteItemEvent extends FavoriteAppEvent{}