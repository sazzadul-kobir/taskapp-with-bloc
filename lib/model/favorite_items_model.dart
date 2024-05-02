
import 'package:equatable/equatable.dart';

class FavoriteItemModel extends Equatable{

  final String id;
  final String value;
  final bool isDeleting;
 final bool isFavorite;

  FavoriteItemModel({required this.id, required this.value,
   this.isDeleting=false,  this.isFavorite=false
  });


  FavoriteItemModel copyWith({String? id, String? value, bool? isDeleting,
  bool? isFavorite
  }){
    return FavoriteItemModel(
        id: id??this.id,
        value: value??this.value,
        isDeleting: isDeleting??this.isDeleting,
        isFavorite: isFavorite??this.isFavorite
    );
  }


  @override
  // TODO: implement props
  List<Object?> get props =>[id,value, isDeleting,isFavorite];

}