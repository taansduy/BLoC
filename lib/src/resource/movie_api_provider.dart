import 'dart:convert';

import 'package:blocdemo/src/models/item_model.dart';
import 'package:http/http.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed";

  Future<ItemModel> fetchMovieList() async {
    final response = await client.get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
