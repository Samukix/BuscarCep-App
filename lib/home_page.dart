import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'resultado_cep.dart';
import 'bloc/cep_bloc.dart';
import 'bloc/cep_event.dart';
import 'bloc/cep_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cepBloc = BlocProvider.of<CepBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('CEP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite o CEP para encontrar o endereço',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final cep = _controller.text.trim();
                if (cep.isNotEmpty) {
                  cepBloc.add(GetCep(cep));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ResultPage()),
                  );
                }
              },
              child: Text('Buscar CEP'),
            ),
            SizedBox(height: 24),
            BlocBuilder<CepBloc, CepState>(
              builder: (context, state) {
                if (state is CepInitial) {
                  return Text('Digite um CEP para buscar');
                } else if (state is CepLoading) {
                  return CircularProgressIndicator();
                } else if (state is CepLoaded) {
                  return Text(state.data.toString());
                } else if (state is CepError) {
                  return Text(state.message);
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
