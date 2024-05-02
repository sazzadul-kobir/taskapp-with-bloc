import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskbloc/bloc/favorite_app_bloc.dart';
import 'package:taskbloc/model/favorite_items_model.dart';
import 'package:taskbloc/repository/favorite_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteAppBloc(FavoriteRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<FavoriteAppBloc>().add(FetchFavoriteListEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task app"),
        actions: [
          BlocBuilder<FavoriteAppBloc, FavoriteAppState>(
            builder: (context, state) {
              return Visibility(
                visible: state.tempfavoriteItemList.isNotEmpty?true:false,
                child: IconButton
                  (onPressed: () {
                  context.read<FavoriteAppBloc>().add(DeleteItemEvent());
                },
                    icon: Icon(Icons.delete)),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<FavoriteAppBloc, FavoriteAppState>(
        builder: (context, state) {
          switch (state.liststaus) {
            case Liststaus.loading:
              return Center(child: CircularProgressIndicator());

            case Liststaus.success:
              return ListView.builder(
                itemCount: state.favoriteItemList.length,
                itemBuilder: (context, index) {
                  FavoriteItemModel item = state.favoriteItemList[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        onChanged: (value) {
                          value! ? context.read<FavoriteAppBloc>().add(
                              SelectItemEvent(item: item)) :
                          context.read<FavoriteAppBloc>().add(
                              UnselectItemEvent(item: item));
                        },
                        value: state.tempfavoriteItemList.contains(item)
                            ? true
                            : false,
                      ),
                      title: Text(item.value),
                      trailing: IconButton(

                        onPressed: () {
                          context.read<FavoriteAppBloc>().add(
                              FavoriteItemEvent(item: FavoriteItemModel(
                                  id: item.id,
                                  value: item.value,
                                  isFavorite: !item.isFavorite
                              )
                              )
                          );
                        },
                        icon: Icon(
                            item.isFavorite ? Icons.favorite : Icons
                                .favorite_outline
                        ),

                      ),
                    ),
                  );
                },
              );


            case Liststaus.failure:
              return Center(
                child: Text("something went wrong"),
              );
          }
        },
      ),
    );
  }
}
