import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState());

  @override
  Stream<BusquedaState> mapEventToState(
    BusquedaEvent event,
  ) async* {
    switch(event.runtimeType){
      case ActivarSeleccionManual:
        yield state.copyWith(seleccionandoManualmente: true);
      break;
      case DesactivarSeleccionManual:
        yield state.copyWith(seleccionandoManualmente: false);
      break;
    }
  }

}
