import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
class AccesoGpsPage extends StatefulWidget {
  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage> with WidgetsBindingObserver{
  final String _instruccionesText = 'Para usar esta aplicación es necesario el gps';

  Size size;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState(); 
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    // TODO: implement didChangeAppLifecycleState
    print('state: $state');
    if(state == AppLifecycleState.resumed){
      if(await Permission.location.isGranted)
        Navigator.pushReplacementNamed(context, 'loading');
    }
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
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_instruccionesText),
            SizedBox(
              height: size.height * 0.02,
            ),
            MaterialButton(
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              child: Text(
                'Solicitar acceso',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: ()async{
                //.request(): Me lanza un dialog para que confirme o deniegue el permiso de location.
                final PermissionStatus locationPermissionStatus = await Permission.location.request();
                _verificarAccesoAGps(locationPermissionStatus);
              },
            )
          ],
        ),
      ),
    );
  }

  void _verificarAccesoAGps(PermissionStatus status){
    switch(status){
      
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
        break;
      case PermissionStatus.undetermined:
        openAppSettings();
        break;
      case PermissionStatus.denied:
        openAppSettings();
        break;
      case PermissionStatus.restricted:
        openAppSettings();
        break;
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}