import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:meta/meta.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/map_themes/uber.dart';
 
part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  
  GoogleMapController _googleMapController;

  Polyline _rutaHaciaDestino = new Polyline(
    polylineId: PolylineId('ruta_hacia_destino'),
    color: Colors.deepOrangeAccent,
    width: 4
  );
  Polyline _rutaRecorrida = new Polyline(
    polylineId: PolylineId('ruta_recorrida'),
    color: Colors.transparent,
    width: 6
  );
  

  void initMap(GoogleMapController newController){
    if(!state.listoParaSerUsado){
      _googleMapController = newController;
      _googleMapController.setMapStyle(jsonEncode(uberTheme));
    }
      
    add(AlistarMapa());
  }

  void moverCamara(LatLng destino){
    final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(destino);
    _googleMapController?.animateCamera(cameraUpdate);
  }

  MapaBloc() : super(MapaState());

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    switch(event.runtimeType){
      case AlistarMapa:
        yield state.copyWith(listoParaSerUsado: true);
      break;
      case UpdateLocation:
        final MapaState newState = _crearStateForUpdateLocation(event as UpdateLocation);
        yield newState;
      break;
      case CambiarDibujandoRecorrido:
        final MapaState newState = _crearStateForCambiarDibujandoRecorrido();
        yield newState;
      break;
      case CambiarSiguiendoUbicacion:
        final MapaState newState = _cambiarSiguiendoUbicacion();
        yield newState;
      break;
      case MoverMapa:
        final MapaState newState = _crearStateForMoverMapa(event as MoverMapa);
        yield newState;
      break;
      case CrearRutaInicioYDestino:
        final MapaState newState = _crearRutaInicioYDestino(event as CrearRutaInicioYDestino);
        yield newState;
      break;
    }
  }

  MapaState _crearStateForUpdateLocation(UpdateLocation event){
    if(state.siguiendoUbicacion)
      moverCamara(event.ubicacion);
    _actualizarRutaRecorridaPolyline(event);
    Map<String, Polyline> polyLines = _crearPolylinesMap();
    return state.copyWith(polyLines: polyLines);
  }

  void _actualizarRutaRecorridaPolyline(UpdateLocation event){
    LatLng nuevaUbicacion = event.ubicacion;
    List<LatLng> points = _rutaRecorrida.points.toList();
    points.add(nuevaUbicacion);
    _rutaRecorrida = _rutaRecorrida.copyWith(pointsParam: points);
  }

  MapaState _crearStateForCambiarDibujandoRecorrido(){
    _updateRutaRecorridaSegunIfDibujandoRecorrido();
    Map<String, Polyline> newPolylines = _crearPolylinesMap();
    bool dibujandoRecorrido = state.dibujandoRecorrido;
    return state.copyWith(
      dibujandoRecorrido: !dibujandoRecorrido,
      polyLines: newPolylines
    );
  }

  void _updateRutaRecorridaSegunIfDibujandoRecorrido(){
    final bool dibujandoRecorrido = state.dibujandoRecorrido;
    if(dibujandoRecorrido)
      _rutaRecorrida = _rutaRecorrida.copyWith(colorParam: Colors.black87);
    else
      _rutaRecorrida = _rutaRecorrida.copyWith(colorParam: Colors.black.withOpacity(0));
  }

  Map<String, Polyline> _crearPolylinesMap(){
    return {
      'ruta_recorrida':_rutaRecorrida,
      'ruta_hacia_destino':_rutaHaciaDestino
    };
  }

  MapaState _cambiarSiguiendoUbicacion(){
    final bool siguiendoUbicacion = state.siguiendoUbicacion;
    if(!siguiendoUbicacion){
      int nPointsOfRuta = _rutaRecorrida.points.length;
      LatLng ultimaUbicacion = _rutaRecorrida.points[nPointsOfRuta - 1];
      moverCamara(ultimaUbicacion);
    }
    return state.copyWith(siguiendoUbicacion: !siguiendoUbicacion);
  }

  MapaState _crearStateForMoverMapa(MoverMapa event){
    final LatLng newPosition = event.newPosition;
    return state.copyWith(centroMapa: newPosition);
  }

  MapaState _crearRutaInicioYDestino(CrearRutaInicioYDestino event){
    _rutaHaciaDestino = _rutaHaciaDestino.copyWith(
      pointsParam: event.points
    );
    final Map<String, Polyline> newPolylines = _crearPolylinesMap();
    //TODO: implementar marcadores
    return state.copyWith(polyLines: newPolylines);
  }

}
