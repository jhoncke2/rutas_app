part of 'ubicacion_bloc.dart';

@immutable
abstract class UbicacionEvent {}

class CambiarUbicacion extends UbicacionEvent{
  final LatLng ubicacion;
  CambiarUbicacion({
    @required this.ubicacion
  });
}
