import 'package:blocdemo/BLoC/bloc_provider.dart';
import 'package:blocdemo/BLoC/location_bloc.dart';
import 'package:blocdemo/DataLayer/location.dart';
import 'package:blocdemo/UI/location_screen.dart';
import 'package:blocdemo/UI/restaurant_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: LocationBloc(),
        child: MaterialApp(
          title: 'Restaurant Finder',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.red,
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MainScreen(),
        )
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Location>(
      stream: BlocProvider
          .of<LocationBloc>(context)
          .locationStream,
      builder: (context, snapshot) {
        final location = snapshot.data;
        if (location == null) {
          return LocationScreen();
        }
        return RestaurantScreen(location: location,);
      },
    );
  }

}
 