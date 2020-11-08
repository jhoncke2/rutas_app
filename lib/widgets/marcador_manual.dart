part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  BuildContext _context;
  Size _size;
  @override
  Widget build(BuildContext context) {
    _context = context;
    _size = MediaQuery.of(context).size;
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (_, BusquedaState state){
        if(state.seleccionandoManualmente)
          return _crearComponentes();
        else
          return Container();
      },
    );
  }

  Widget _crearComponentes(){
    return Stack(
      children: [
        _crearBotonRetroceder(),
        _crearMarcador(),
        _crearBotonConfirmarDestino()
      ],
    );
  }

  Widget _crearBotonRetroceder(){
    return Positioned(
      left: _size.width * 0.055,
      height: _size.height * 0.23,
      child: FadeInLeft(
        child: CircleAvatar(
          maxRadius: _size.width * 0.045,
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black87,
            onPressed: (){
              final BusquedaBloc busquedaBloc = _context.bloc<BusquedaBloc>();
              busquedaBloc.add(DesactivarSeleccionManual());
            },
          ),
        ),
      ),
    );
  }

  Widget _crearMarcador(){
    return Center(
      //transforma el widget usando unas translación
      child: Transform.translate(
        offset: Offset(
          0,
          -_size.width*0.04
        ),
        child: BounceInDown(
          from: 150,
          child: Icon(
            Icons.location_on,
            size: _size.width * 0.1,
          ),
        ),
      ),
    );
  }

  Widget _crearBotonConfirmarDestino(){
    return Positioned(
      bottom: _size.height * 0.08,
      left: _size.width * 0.1,
      child: FadeIn(
        child: MaterialButton(
          minWidth: _size.width - (_size.width * 0.3),
          color: Colors.black,
          splashColor: Colors.transparent,
          shape: StadiumBorder(),
          elevation: 1,
          child: Text(
            'Confirmar destino',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          onPressed: (){
            _calcularRuta();
          },
        ),
      ),
    );
  }

  void _calcularRuta()async{
    mostrarCalculandoAlerta(_context);
    final UbicacionBloc ubicacionBloc = _context.bloc<UbicacionBloc>();
    final BusquedaBloc busquedaBloc = _context.bloc<BusquedaBloc>();
    final MapaBloc mapaBloc = _context.bloc<MapaBloc>();
    final TrafficService trafficService = new TrafficService();
    final LatLng inicio = ubicacionBloc.state.ubicacion;
    final LatLng destino = mapaBloc.state.centroMapa;
    final RouteResponse routeResponse =  await trafficService.getRutaFromInicioYDestino(inicio, destino);
    //supongo que son el mismo geometry, duration y distance para cada elemento de routes
    final geometry = routeResponse.routes[0].geometry;
    final duration = routeResponse.routes[0].duration;
    final distance = routeResponse.routes[0].distance;
    //¿precision:6 se debe a que la petición es polyline6?
    final PLine.Polyline decodedPolyline = PLine.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<List<double>> points = decodedPolyline.decodedCoords;
    final List<LatLng> pointsPositions = _transformarPointsALatLngList(points);
    final MapaEvent crearRutaEvent = CrearRutaInicioYDestino(
      points: pointsPositions,
      duration: duration,
      distance: distance
    );
    mapaBloc.add(crearRutaEvent);
    Navigator.of(_context).pop();
    busquedaBloc.add(DesactivarSeleccionManual());
  }

  List<LatLng> _transformarPointsALatLngList(List<List<double>> points){
    final List<LatLng> pointsPositions = points.map((List<double> point) {
      final LatLng pointPosition = LatLng(point[0], point[1]);
      return pointPosition;
    }).toList();
    return pointsPositions;
  }
  
}


