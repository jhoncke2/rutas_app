import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

class SearchResult{
   final bool cancelado;
   final bool ubicacionManual;
   final LatLng position;
   final String nombreLugar;
   final String descripcionLugar;

   SearchResult({
     @required this.cancelado,
     this.ubicacionManual,
     this.position,
     this.nombreLugar,
     this.descripcionLugar
   });
 }