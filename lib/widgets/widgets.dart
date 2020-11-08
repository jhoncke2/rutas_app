import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/blocs/busqueda/busqueda_bloc.dart';
import 'package:rutas_app/blocs/mapa/mapa_bloc.dart';
import 'package:rutas_app/blocs/ubicacion/ubicacion_bloc.dart';
import 'package:rutas_app/helpers/helpers.dart';
import 'package:rutas_app/models/route_response.dart';
import 'package:rutas_app/models/search_result.dart';
import 'package:rutas_app/search/destination_search.dart';
import 'package:rutas_app/services/traffic_service.dart';
//le pongo un alias porque los nombres de elementos del paquete pueden chocar con nombres de elementos de googleMaps o MapBox
import 'package:polyline/polyline.dart' as PLine;

part 'btn_dirigirse_a_ubicacion.dart';
part 'btn_ruta_recorrida.dart';
part 'btn_seguir_ubicacion.dart';
part 'search_bar.dart';
part 'marcador_manual.dart';
