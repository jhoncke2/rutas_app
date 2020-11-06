part of 'widgets.dart';

class BtnRutaRecorrida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.transit_enterexit,
            color: Colors.black87,
          ),
          onPressed: (){
            mapaBloc.add(CambiarDibujandoRecorrido());
          },
        ),
      ),
    );
  }
}