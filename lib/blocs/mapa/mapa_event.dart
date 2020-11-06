part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class AlistarMapa extends MapaEvent{

}

class UpdateLocation extends MapaEvent{
  final LatLng ubicacion;

  UpdateLocation({
    @required this.ubicacion
  });
}

class CambiarDibujandoRecorrido extends MapaEvent{
  CambiarDibujandoRecorrido();
}

class CambiarSiguiendoUbicacion extends MapaEvent{
  CambiarSiguiendoUbicacion();
}

class MoverMapa extends MapaEvent{
  final LatLng newPosition;
  MoverMapa({
    @required this.newPosition
  });
}