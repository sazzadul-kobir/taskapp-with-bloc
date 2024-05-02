import 'package:taskbloc/model/favorite_items_model.dart';

class FavoriteRepository{

  Future<List<FavoriteItemModel>> fetchItem() async {
    await Future.delayed(const Duration(seconds: 3));
    return List.from(GenerateList(10));

  }

  List<FavoriteItemModel> GenerateList(int length){
   return List.generate(length, (index) => FavoriteItemModel(id: index.toString(), value: "Item $index"));
  }
}