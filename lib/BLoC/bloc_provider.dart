import 'package:blocdemo/BLoC/bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, this.bloc, this.child}) : super(key: key);

  static T of<T extends Bloc>(BuildContext context) {
//    final type = _providerType<BlocProvider<T>>();
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }

  static Type _providerType<T>() => T;

  @override
  State<StatefulWidget> createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
