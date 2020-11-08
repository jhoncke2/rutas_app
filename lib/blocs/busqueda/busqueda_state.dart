part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {
  final bool seleccionandoManualmente;

  BusquedaState({
    this.seleccionandoManualmente = false
  });

  BusquedaState copyWith({
    bool seleccionandoManualmente
  }) => BusquedaState(
    seleccionandoManualmente: seleccionandoManualmente??this.seleccionandoManualmente
  );
}

