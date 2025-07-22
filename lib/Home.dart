import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  final textController = TextEditingController();

  var isLoading = false;
  String? error;

  var cepResult = ();

  Future<void> searchCep(String cep) async{
    try {
      cepResult = ();
      error = null; 
      setState(() {
        isLoading = true;
      });
      final response = await Dio().get('viacep.com.br/ws/$cep/json/');

      setState(() {
        cepResult = response.data;
      });
    } catch (e){
      error = "Erro na pesquisa";
    }
    setState(() {
      isLoading = false;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar CEP"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextField(keyboardType: TextInputType.number),
            Text("Resultado: ", style: TextStyle(fontSize: 25),),

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
                searchCep(textController.text);
              },
            ),
            if (isLoading) Expanded (child: Center(child: CircularProgressIndicator())),
            if (error != null) Text(error!, style: TextStyle(color: Colors.red)),
            if (!isLoading) Text("Cep: ${cepResult['cep']}"),
          ],
        ),
      ),
    );
  }
}


