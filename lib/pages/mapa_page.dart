import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/blocs/mapa/mapa_bloc.dart';
import 'package:rutas_app/blocs/ubicacion/ubicacion_bloc.dart';
import 'package:rutas_app/widgets/widgets.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  LatLng _currentCentralMapPosition;

  @override
  void initState() {
    context.bloc<UbicacionBloc>().iniciarSeguimiento();    
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    context.bloc<UbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearBody(),
      floatingActionButton: _crearFloatingActionButtons(),
    );
  }

  Widget _crearBody(){
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: BlocBuilder<UbicacionBloc, UbicacionState>(
            builder: (_, UbicacionState state){
              return _crearWidgetDeInformacionUbicacion(state);
            },
          ),
        ),
        Positioned(
          top: 10.0,
          child: SearchBar()
        ),
        //TODOL: hacer el toggle de cuando se está manualmente
        MarcadorManual()
      ],
    );
  }

  Widget _crearWidgetDeInformacionUbicacion(UbicacionState ubicacionState){
    if(ubicacionState.existeUbicacion){
      final MapaBloc mapaBloc = BlocProvider.of<MapaBloc>(context);
      final UpdateLocation cambiarUbicacionEvent = UpdateLocation(
        ubicacion: ubicacionState.ubicacion
      );
      mapaBloc.add(cambiarUbicacionEvent);
      return BlocBuilder<MapaBloc, MapaState>(
        builder:(_, MapaState mapaState){
          return _crearMapa(ubicacionState, mapaState);
        }
      );
    }
    else
      return Text('Ubicando');     
  }

  Widget _crearMapa(UbicacionState ubicacionState, MapaState mapaState){
    final MapaBloc mapaBloc = context.bloc<MapaBloc>();
    final LatLng actualPosition = ubicacionState.ubicacion;
    final CameraPosition initialCameraPosition = CameraPosition(
      target: actualPosition,
      zoom: 15.0,
    );
    final Map<String, Polyline> polylines = mapaState.polyLines;
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController newController){
        context.bloc<MapaBloc>().initMap(newController);
      },
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      polylines: polylines.values.toSet(),
      onCameraMove: (CameraPosition newPosition){
        final LatLng newPositionEnLatLng = newPosition.target;
        _currentCentralMapPosition = newPositionEnLatLng;
      },
      onCameraIdle: (){
        mapaBloc.add(MoverMapa(newPosition: _currentCentralMapPosition));
      },
    );
  }

  Widget _crearFloatingActionButtons(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BtnDirigirseAUbicacion(),
        BtnRutaRecorrida(),
        BtnSeguirUbicacion()
      ],
    );
  }
}