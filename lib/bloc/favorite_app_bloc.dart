import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/favorite_items_model.dart';
import '../repository/favorite_repository.dart';

part 'favorite_app_event.dart';
part 'favorite_app_state.dart';

class FavoriteAppBloc extends Bloc<FavoriteAppEvent, FavoriteAppState> {

  List<FavoriteItemModel> favoritelist=[];
  List<FavoriteItemModel> tempfavoritelist=[];
  FavoriteRepository favoriteRepository;

  FavoriteAppBloc(this.favoriteRepository) : super(FavoriteAppState()) {
    on<FetchFavoriteListEvent>((event, emit)async {
      favoritelist=await favoriteRepository.fetchItem();
      emit(state.copyWith(favoriteItemList: List.from(favoritelist),liststaus:Liststaus.success ));
    });

    on<FavoriteItemEvent>((event, emit){

        final index=favoritelist.indexWhere((element) => element.id==event.item.id);
         favoritelist[index]=event.item;
        emit(state.copyWith(favoriteItemList: List.from(favoritelist)));
    });

    on<SelectItemEvent>((event, emit){
      tempfavoritelist.add(event.item);
      emit(state.copyWith(tempfavoriteItemList: List.from(tempfavoritelist)));
    });

    on<UnselectItemEvent>((event, emit){
      tempfavoritelist.remove(event.item);
      emit(state.copyWith(tempfavoriteItemList: List.from(tempfavoritelist)));
    });

    on<DeleteItemEvent>((event, emit){
     for(int i=0; i<tempfavoritelist.length;i++){
       favoritelist.remove(tempfavoritelist[i]);
     }
     tempfavoritelist.clear();

     emit(state.copyWith(
         favoriteItemList: List.from(favoritelist),
         tempfavoriteItemList: List.from(tempfavoritelist)));

    });

  }
}
