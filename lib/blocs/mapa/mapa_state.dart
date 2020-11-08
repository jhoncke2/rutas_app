part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool listoParaSerUsado;
  final bool dibujandoRecorrido;
  final bool siguiendoUbicacion;
  final LatLng centroMapa;

  final Map<String, Polyline> polyLines;

  MapaState({
    this.listoParaSerUsado = false,
    this.dibujandoRecorrido = false,
    this.siguiendoUbicacion = false,
    this.centroMapa,
    Map<String, Polyline> polyLines
  })
  : this.polyLines = polyLines??new Map<String, Polyline>();

  MapaState copyWith({
    bool listoParaSerUsado,
    bool dibujandoRecorrido,
    bool siguiendoUbicacion,
    LatLng centroMapa,
    Map<String, Polyline> polyLines
  })=>MapaState(
    listoParaSerUsado: listoParaSerUsado??this.listoParaSerUsado,
    dibujandoRecorrido: dibujandoRecorrido??this.dibujandoRecorrido,
    siguiendoUbicacion: siguiendoUbicacion??this.siguiendoUbicacion,
    centroMapa: centroMapa??this.centroMapa,
    polyLines: polyLines??this.polyLines
  );
}
