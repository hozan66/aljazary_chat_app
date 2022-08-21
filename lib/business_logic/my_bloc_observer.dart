import 'dart:developer';

import 'package:bloc/bloc.dart';

// MyBlocObserver helps in (We will keep track where are we)
class MyBlocObserver extends BlocObserver {
  //It comes from => bloc: ^7.0.0
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- ${bloc.runtimeType}'); //runtimeType determines which type (data type) of object bloc is
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // log('onChange -- ${bloc.runtimeType}, $change');
    log('onChange -- ${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- ${bloc.runtimeType}');
  }
}
