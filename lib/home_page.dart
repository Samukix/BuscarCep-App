import 'package:buscacep/search_cep_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final textController = TextEditingController(); 

  final searchCepBloc = SearchCepBloc();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar CEP"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextField(keyboardType: TextInputType.number),
            Text("Resultado: ", style: TextStyle(fontSize: 25)),

            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o CEP para encontrar o endereço",
              ),
              style: TextStyle(fontSize: 15),
              controller: textController,
            ),

            ElevatedButton(
              child: Text("Consultar", style: TextStyle(fontSize: 15)),
              onPressed: () {
                searchCepBloc.searchCep.add(textController.text);
              },
            ),
            StreamBuilder<Map>
            stream: searchCepBloc.cepResult, 
            builder: (context, snapshot){

              if(snapshot,hasError){
                return Text("${snapshot.error}", style: TextStyle(color: Colors.red));
              }
            },)
            if (searchCepBloc.isLoading)
              Expanded(child: Center(child: CircularProgressIndicator())),
            if (searchCepBloc.error != null)
              Text(searchCepBloc.error!, style: TextStyle(color: Colors.red)),
            if (!searchCepBloc.isLoading && searchCepBloc.cepResult.isNotEmpty) Text("Cep: ${searchCepBloc.cepResult['cep']}"),
          ],
        ),
      ),
    );
  }
}
