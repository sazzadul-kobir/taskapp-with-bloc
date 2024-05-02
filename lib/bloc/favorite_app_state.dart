part of 'favorite_app_bloc.dart';


enum Liststaus{
  loading,
  success,
  failure
}

 class FavoriteAppState extends Equatable {

   final List<FavoriteItemModel> favoriteItemList;
   final List<FavoriteItemModel> tempfavoriteItemList;
  final Liststaus liststaus;
  const FavoriteAppState({
     this.favoriteItemList=const [],
   this.tempfavoriteItemList=const [],
    this.liststaus=Liststaus.loading
 });

  FavoriteAppState copyWith({
    List<FavoriteItemModel>? favoriteItemList,
    List<FavoriteItemModel>? tempfavoriteItemList,
    Liststaus? liststaus
  }){
    return FavoriteAppState(
      favoriteItemList: favoriteItemList??this.favoriteItemList,
        tempfavoriteItemList: tempfavoriteItemList??this.tempfavoriteItemList,
      liststaus: liststaus??this.liststaus
    );
 }

  @override
  // TODO: implement props
  List<Object?> get props => [favoriteItemList,liststaus,tempfavoriteItemList];
}


