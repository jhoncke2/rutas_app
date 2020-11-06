part of 'ubicacion_bloc.dart';

@immutable
class UbicacionState {
  final bool existeUbicacion;
  final bool siguiendo;
  final LatLng ubicacion;

  UbicacionState({
    this.existeUbicacion = false,
    this.siguiendo = true,
    this.ubicacion
  });

  UbicacionState copyWith({
    bool existeUbicacion,
    bool siguiendo,
    LatLng ubicacion
  }) => UbicacionState(
    existeUbicacion: existeUbicacion?? this.existeUbicacion,
    siguiendo: siguiendo?? this.siguiendo,
    ubicacion: ubicacion?? this.ubicacion
  );
}


