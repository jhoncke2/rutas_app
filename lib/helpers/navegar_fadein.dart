part of 'helpers.dart';

Route navegarAMapaPorFadeIn(BuildContext context, Widget page){
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: Duration(milliseconds: 350),
    transitionsBuilder: (BuildContext context, Animation<double> animation, _, Widget child){
      return FadeTransition(
        child: child,
        opacity: Tween<double>(
          begin: 0,
          end: 1
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut
          )
        ),
      );
    }
  );
}