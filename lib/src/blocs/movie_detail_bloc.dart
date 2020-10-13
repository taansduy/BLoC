import 'package:blocdemo/src/models/trailer_model.dart';
import 'package:blocdemo/src/resource/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc{
  final _repository = Repository();
  final _movieId = PublishSubject<int>();
  final _trailers = BehaviorSubject<Future<TrailerModel>>();

  Function(int) get fetchTrailerById => _movieId.sink.add;
  Observable<Future<TrailerModel>> get movieTrailers => _trailers.stream;

  MovieDetailBloc() {
    _movieId.stream.transform(_itemTransformer()).pipe(_trailers);
  }

  dispose() async {
    _movieId.close();
    await _trailers.drain();
    _trailers.close();
  }

  _itemTransformer() {
    return ScanStreamTransformer(
          (Future<TrailerModel> trailer, int id, int index) {
        trailer = _repository.fetchTrailers(id);
        return trailer;
      },
    );
  }
}

