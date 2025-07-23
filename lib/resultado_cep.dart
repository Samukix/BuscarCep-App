import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cep_bloc.dart';
import 'bloc/cep_state.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultado da Pesquisa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),), backgroundColor: Colors.blue),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: BlocBuilder<CepBloc, CepState>(
          builder: (context, state) {
            if (state is CepLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CepLoaded) {
              final data = state.data;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CEP:', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                      Text('Logradouro:', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                      Text('Bairro:', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                      Text('Cidade:', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                      Text('UF:', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${data['cep']}'),
                  Text('${data['logradouro']}'),
                  Text('${data['bairro']}'),
                  Text('${data['localidade']}'),
                  Text('${data['uf']}'),
                  ],
                  ),
                ],
              );
            } else if (state is CepError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Insira um CEP'));
            }
          },
        ),
      ),
    );
  }
}
