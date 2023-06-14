import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ! If we do not have Data in our states then we can put states in enum
// ! else if have data then make seperate class like in Bloc
enum Internetstate { Initial, Gained, Lost }

class InternetCubit extends Cubit<Internetstate> {
  final _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;
  // ! initialState Like Bloc

  InternetCubit() : super(Internetstate.Initial) {
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        // ! no Events
        emit(Internetstate.Gained);
      } else {
        emit(Internetstate.Lost);
      }
    });
  }
  @override
  Future<void> close() {
    // TODO: implement close
    connectivitySubscription?.cancel();
    return super.close();
  }
}
