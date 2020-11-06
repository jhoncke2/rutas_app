import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rutas_app/helpers/helpers.dart';
import 'package:rutas_app/pages/acceso_gps_page.dart';
import 'package:rutas_app/pages/mapa_page.dart';
class LoadingPage extends StatefulWidget {

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver{

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    // TODO: implement didChangeAppLifecycleState
    final bool locationServiceIsEnabled = await Geolocator.isLocationServiceEnabled();
    if(state == AppLifecycleState.resumed && locationServiceIsEnabled)
      Navigator.pushReplacement(context, navegarAMapaPorFadeIn(context, MapaPage()));
    super.didChangeAppLifecycleState(state);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this._checkGpsAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return (
            (snapshot.hasData)?
              Center(
                child: Text(snapshot.data)
              )
            : Center(
              child: CircularProgressIndicator(),
            )
          );
        },
      )
    );
  }

  Future<String> _checkGpsAndLocation(BuildContext context)async{
    final bool gpsIsGranted = await Permission.location.isGranted;
    final bool gpsIsActive = await Geolocator.isLocationServiceEnabled();
    if(gpsIsGranted && gpsIsActive){
      Navigator.pushReplacement(context, navegarAMapaPorFadeIn(context, MapaPage()));
      return '';
    }     
    else if(!gpsIsGranted){
      Navigator.pushReplacement(context, navegarAMapaPorFadeIn(context, AccesoGpsPage()));
      return 'Es necesario el permiso del gps';
    }
    else{
      return 'Active el gps';
    }
  }
}