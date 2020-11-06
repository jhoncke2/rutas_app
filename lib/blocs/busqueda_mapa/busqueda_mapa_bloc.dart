import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'busqueda_mapa_event.dart';
part 'busqueda_mapa_state.dart';

class BusquedaMapaBloc extends Bloc<BusquedaMapaEvent, BusquedaMapaState> {
  BusquedaMapaBloc() : super(BusquedaMapaInitial());

  @override
  Stream<BusquedaMapaState> mapEventToState(
    BusquedaMapaEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
