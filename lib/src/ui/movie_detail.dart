import 'package:blocdemo/src/blocs/movie_detail_bloc.dart';
import 'package:blocdemo/src/blocs/movie_detail_bloc_provider.dart';
import 'package:blocdemo/src/models/trailer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatefulWidget {
  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  MovieDetail({this.title, this.posterUrl, this.description, this.releaseDate, this.voteAverage, this.movieId});

  @override
  State<StatefulWidget> createState() {
    return MovieDetailState();
  }
}

class MovieDetailState extends State<MovieDetail> {
  MovieDetailBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = MovieDetailBlocProvider.of(context);
    bloc.fetchTrailerById(widget.movieId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    "https://image.tmdb.org/t/p/w500${widget.posterUrl}",
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ];
          },
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5),
                ),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 1, right: 1),
                    ),
                    Text(
                      widget.voteAverage,
                      style: TextStyle(fontSize: 18),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                    ),
                    Text(
                      widget.releaseDate,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                ),
                Text(widget.description),
                Container(margin: EdgeInsets.only(top: 8, bottom: 8),),
                Text("Trailer",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
                Container(margin: EdgeInsets.only(top: 8,bottom: 8),),
                StreamBuilder(
                  stream: bloc.movieTrailers,
                    builder: (context, AsyncSnapshot<Future<TrailerModel>> snapshot){
                      if(snapshot.hasData){
                        return FutureBuilder(
                          future: snapshot.data,
                          builder: (context,AsyncSnapshot<TrailerModel> itemSnapshot){
                            if(itemSnapshot.hasData){
                              if(itemSnapshot.data.results.length>0){
                                return trailerLayout(itemSnapshot.data);
                              }
                              else return noTrailer(itemSnapshot.data);
                            }else{
                              return Center(child: CircularProgressIndicator(),);
                            }
                          },
                        );
                      }
                      else{
                        return Center(child: CircularProgressIndicator(),);

                      }
                    },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget noTrailer(TrailerModel data){
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  Widget trailerLayout(TrailerModel data){
    if(data.results.length>1){
      return Row(
        children: <Widget>[
          trailerItem(data,0),
          trailerItem(data,1),
        ],
      );
    }
    else{
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel data, int index){
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5),
            height: 100,
            color: Colors.grey,
            child: Center(child: Icon(Icons.play_circle_filled),),
          ),
          Text(
            data.results[index].name,
            maxLines: 1,
              overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
