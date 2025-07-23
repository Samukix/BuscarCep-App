import 'dart:async';

import 'package:dio/dio.dart';

class SearchCepBloc {

  final _streamController = StreamController<String>();
  Sink<String> get searchCep => _streamController.sink;
  Stream<Map> get cepResult => _streamController.stream.asyncMap(_searchCep);


Future<Map> _searchCep(String cep) async {
    try {
 
      final response = await Dio().get('viacep.com.br/ws/$cep/json/');

      return response.data;
    } catch (e) {
     throw Exception('Erro na pesquisa');
    }
}

void dispose(){
  _streamController.close();
}
}