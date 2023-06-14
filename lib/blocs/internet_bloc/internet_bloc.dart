import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_events.dart';
import 'internet_states.dart';

//jab bhi page off hoga tw bloc bhi band hojayega
//magar jo listen hota h wo Chalta rehta h
//usy manually off karna parta h

class InternetBloc extends Bloc<InternetEvents, InternetState> {
  final _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  //super k sath hamesha Initial State Lkhty hn
  InternetBloc() : super(InternetInitialState()) {
    // Event hamesha add hota hai
    // State hamesha emit hoti h
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }
  // To Close Listen Manaually to prevent performance DownGrade
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
