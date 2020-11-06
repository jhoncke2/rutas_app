part of 'widgets.dart';

class BtnDirigirseAUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final ubicacionBloc = BlocProvider.of<UbicacionBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.my_location,
            color: Colors.black87,
          ),
          onPressed: (){
            final LatLng ultimasPosicionGps = ubicacionBloc.state.ubicacion;
            mapaBloc.moverCamara(ultimasPosicionGps);
          },
        ),
      ),
    );
  }
}