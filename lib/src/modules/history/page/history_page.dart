import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controller/history_controller.dart';

class HistoryPage extends StatefulWidget {
  final HistoryController controller;
  const HistoryPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadHistory(); // Carrega os dados ao abrir a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Consultas')),
      body: Observer(
        builder: (_) {
          if (widget.controller.historyList.isEmpty) {
            return const Center(child: Text("Nenhuma consulta no histórico."));
          }
          return ListView.builder(
            itemCount: widget.controller.historyList.length,
            itemBuilder: (_, index) {
              final addr = widget.controller.historyList[index];
              return ListTile(
                leading: const Icon(Icons.place, color: Colors.blue),
                title: Text(addr.logradouro ?? 'Endereço sem nome'),
                subtitle: Text("${addr.localidade} - ${addr.uf} | CEP: ${addr.cep}"),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}