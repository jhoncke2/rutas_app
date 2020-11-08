import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app/blocs/busqueda/busqueda_bloc.dart';
import 'package:rutas_app/blocs/mapa/mapa_bloc.dart';
import 'package:rutas_app/blocs/ubicacion/ubicacion_bloc.dart';
import 'package:rutas_app/pages/acceso_gps_page.dart';
import 'package:rutas_app/pages/loading_page.dart';
import 'package:rutas_app/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UbicacionBloc>(create: (_)=>UbicacionBloc()),
        BlocProvider<MapaBloc>(create: (_)=>MapaBloc()),
        BlocProvider<BusquedaBloc>(create: (_)=>BusquedaBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: LoadingPage(),
        routes: {
          'acceso_gps':(BuildContext context)=>AccesoGpsPage(),
          'loading':(BuildContext context)=>LoadingPage(),
          'mapa':(BuildContext context)=>MapaPage()
        },
      ),
    );
  }
}