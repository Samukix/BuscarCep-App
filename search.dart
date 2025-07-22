import 'dart:async';
import 'package:dio/dio.dart';
import 'Home.dart';

class SearchCep {
  final _streamController = StreamController<String>();
  Sink<String> get searchCep => _streamController.sink;
  Stream<Map> get cepResult => _streamController.stream.asyncMap(searchCep as FutureOr<Map> Function(String event));


  var isLoading = false;


  Future<void> searchCep(String cep) async{
    try {
      cepResult = ();
      error = null;
      setState((){
        isLoading = true;
      });
      final response = await Dio().get('viacep.com.br/ws/$cep/json/ ');
    
    setState((){
      cepResult = response.data;
    });
    } catch (e) {
      error = 'Erro na pesquisa';
    }
    setState(({
      isLoading = false;
    }));
  }
}
