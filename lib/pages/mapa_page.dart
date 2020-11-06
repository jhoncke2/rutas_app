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
      body: _crearLatitudYLongitudText(),
      floatingActionButton: _crearFloatingActionButtons(),
    );
  }

  Widget _crearLatitudYLongitudText(){
    return Container(
      width: double.infinity,
      child: BlocBuilder<UbicacionBloc, UbicacionState>(
        builder: (_, UbicacionState state){
          return _crearWidgetDeInformacionUbicacion(state);
        },
      ),
    );
  }

  Widget _crearWidgetDeInformacionUbicacion(UbicacionState state){
    if(state.existeUbicacion){
      final MapaBloc mapaBloc = BlocProvider.of<MapaBloc>(context);
      final UpdateLocation cambiarUbicacionEvent = UpdateLocation(
        ubicacion: state.ubicacion
      );
      mapaBloc.add(cambiarUbicacionEvent);
      return _crearMapa(state);
    }
    else
      return Text('Ubicando');     
  }

  Widget _crearMapa(UbicacionState state){ 
    final LatLng actualPosition = state.ubicacion;
    final CameraPosition initialCameraPosition = CameraPosition(
      target: actualPosition,
      zoom: 15.0,
    );
    final MapaBloc mapaBloc = context.bloc<MapaBloc>();
    final Map<String, Polyline> polylines = mapaBloc.state.polyLines;
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