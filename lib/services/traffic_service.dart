import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:rutas_app/models/route_response.dart';

class TrafficService{

  //Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService(){
    return _instance;
  }

  final Dio _dio = new Dio();
  final String _baseUrl = 'https://api.mapbox.com/directions/v5';
  final String _accesToken = 'pk.eyJ1IjoidGhldHVydGxldHVydGxlciIsImEiOiJja2g2bGR5c2YwM3hkMzFyNzYza3hxdjV0In0.PSvvrOHMT-pWEzF-w_0eEQ';

  Future<RouteResponse> getRutaFromInicioYDestino(LatLng inicio, LatLng fin)async{
    print('Inicio: $inicio \n Fin:$fin');
    final String formatedCoords = '${inicio.longitude},${inicio.latitude};${fin.longitude},${fin.latitude}';
    final String url = '$_baseUrl/mapbox/driving/$formatedCoords';
    final Map<String, dynamic> queryParameters = {
      'alternatives':true,
      'geometries':'polyline6',
      'steps':false,
      'access_token':_accesToken,
      'language':'es'
    };
    final Response response = await _dio.get(url, queryParameters: queryParameters);
    final RouteResponse data = RouteResponse.fromJson(response.data);
    return data;
  }
}