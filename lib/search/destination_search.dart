import 'package:flutter/material.dart';
import 'package:rutas_app/models/search_result.dart';

class DestinationSearch extends SearchDelegate<SearchResult>{
  @override
  final String searchFieldLabel;

  DestinationSearch()
  : this.searchFieldLabel = "Buscar";

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: (){
          this.query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
      ),
      onPressed: (){
        //TODO: retornar algo en vez de null
        final SearchResult cancelado = SearchResult(cancelado: true);
        this.close(context, cancelado);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(
            Icons.location_on
          ),
          title: Text(
            'Colocar ubicación manualmente'
          ),
          onTap: (){
            print('on tap ListTile manualmente');
            //TODO: retornar un valor en este null
            final SearchResult result = new SearchResult(
              cancelado: false,
              ubicacionManual: true
            );
            this.close(context, result);
          },
        )
      ],
    );
  }

}