import 'package:blocdemo/src/models/item_model.dart';
import 'package:blocdemo/src/models/trailer_model.dart';
import 'package:blocdemo/src/resource/movie_api_provider.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => movieApiProvider.fetchMovieList();

  Future<TrailerModel> fetchTrailers(int movieId) => movieApiProvider.fetchTrailer(movieId);
}
