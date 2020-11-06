import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'ubicacion_event.dart';
part 'ubicacion_state.dart';

class UbicacionBloc extends Bloc<UbicacionEvent, UbicacionState> {
  UbicacionBloc() : super(UbicacionState());

  StreamSubscription<Position> _positionSubscription;

  @override
  Stream<UbicacionState> mapEventToState(
    UbicacionEvent event,
  ) async* {
    if(event is CambiarUbicacion){
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.ubicacion
      );
    }
  }

  void iniciarSeguimiento(){
    _positionSubscription = Geolocator.getPositionStream(
      //entre más accuracy(exactitud) tenga, más datos consume.
      desiredAccuracy: LocationAccuracy.high,
      //cada cuánta distancia recorrida me va a emitir una nueva posición
      distanceFilter: 10
    ).listen((Position position) {
      final LatLng nuevaUbicacion = LatLng(
        position.latitude,
        position.longitude
      );
      add( CambiarUbicacion(ubicacion: nuevaUbicacion));
    });
  }

  void cancelarSeguimiento(){
    _positionSubscription.cancel();
  }
}
