import 'package:blocdemo/BLoC/bloc_provider.dart';
import 'package:blocdemo/BLoC/location_bloc.dart';
import 'package:blocdemo/BLoC/location_query_bloc.dart';
import 'package:blocdemo/DataLayer/location.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  final bloc = LocationQueryBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Where do you want to eat?'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a location'),
                onChanged: (query) => bloc.submitQuery(query),
              ),
            ),
            Expanded(
              child: _buildResults(bloc),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResults(LocationQueryBloc bloc) {
    return StreamBuilder<List<Location>>(
      stream: bloc.locationStream,
      builder: (context, snapshot) {
        final results = snapshot.data;
        if (results == null) {
          return Center(child: Text('Enter a location'),);
        }
        if (results.isEmpty) {
          return Center(child: Text('No Results'));
        }
        return _buildSearchResults(results);
      },
    );
  }
  Widget _buildSearchResults(List<Location> results) {
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, index) {
        final location = results[index];
        return ListTile(
          title: Text(location.title),
          onTap: () {
            // 3
            final locationBloc = BlocProvider.of<LocationBloc>(context);
            locationBloc.selectLocation(location);
          },
        );
      },
    );
  }
}
