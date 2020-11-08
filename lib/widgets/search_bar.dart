part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  BuildContext _context;
  Size _size;

  @override
  Widget build(BuildContext context) {
    _context = context;
    _size = MediaQuery.of(context).size;
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (_, BusquedaState state){
        if(!state.seleccionandoManualmente)
          return _crearBarra();
        else
          return Container();
      },
    );
  }

  Widget _crearBarra(){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: _size.width * 0.05),
        width: _size.width,
        child: _crearComponenteDeBarra()
      ),
    );
  }

  Widget _crearComponenteDeBarra(){
    return FadeInDown(
      duration: Duration(milliseconds: 400),
      child: GestureDetector(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: _size.height * 0.014),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 3)
              )
            ]
          ),
          child: Text(
            '¿A dónde quieres ir?',
            style: TextStyle(
              color: Colors.black87
            ),
          ),
        ),
        onTap: ()=>_onTapSearchBar(),
      ),
    );
  }

  void _onTapSearchBar()async{
    final SearchResult result = await showSearch<SearchResult>(context: _context, delegate: DestinationSearch());
    _recibirRetornoDeBusqueda(result);
  }

  void _recibirRetornoDeBusqueda(SearchResult result){
    if(result.cancelado)
      print('cancelado');
    else if(result.ubicacionManual){
      final BusquedaBloc busquedaBloc = _context.bloc<BusquedaBloc>();
      busquedaBloc.add(ActivarSeleccionManual());
    }

  }

}
