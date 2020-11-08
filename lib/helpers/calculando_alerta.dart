part of 'helpers.dart';

void mostrarCalculandoAlerta(BuildContext context){
  if(Platform.isAndroid){
    showDialog(
      context: context,
      builder: (BuildContext cnotext)=>AlertDialog(
        title: Text('Por favor espere'),
        content: Text('Calculando ruta'),
      )
    );
  }else if(Platform.isIOS){
    showCupertinoDialog(
      context: context, 
      builder: (BuildContext context)=>CupertinoAlertDialog(
        title: Text('Por favor espere'),
        content: CupertinoActivityIndicator(),
      )
    );
  }
}