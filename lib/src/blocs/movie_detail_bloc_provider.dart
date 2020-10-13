import 'package:flutter/cupertino.dart';

import 'movie_detail_bloc.dart';

class MovieDetailBlocProvider extends InheritedWidget{
  final MovieDetailBloc bloc;

  MovieDetailBlocProvider({Key key, Widget child}) : bloc = MovieDetailBloc(),super(key:key,child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static MovieDetailBloc of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<MovieDetailBlocProvider>().bloc;
  }

}