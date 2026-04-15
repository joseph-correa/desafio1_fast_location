import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:map_launcher/map_launcher.dart';
import '../controller/home_controller.dart';
import '../../../routes/app_routes.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;
  const HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cepController = TextEditingController();

  Future<void> _openMap() async {
    final addr = widget.controller.lastAddress;
    if (addr != null) {
      final availableMaps = await MapLauncher.installedMaps;
      if (availableMaps.isNotEmpty) {
        await availableMaps.first.showDirections(
          destinationTitle: "Entrega: ${addr.logradouro}",
          destination: Coords(0, 0),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastLocation'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Ver Histórico',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _cepController,
              decoration: InputDecoration(
                labelText: 'Digite o CEP (apenas números)',
                hintText: 'Ex: 89201000',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    widget.controller.searchCep(_cepController.text);
                    FocusScope.of(context).unfocus(); 
                  },
                ),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                widget.controller.searchCep(value);
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 30),
            
            Observer(
              builder: (_) {
                if (widget.controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                if (widget.controller.hasError) {
                  return Column(
                    children: const [
                      Icon(Icons.error_outline, color: Colors.red, size: 50),
                      SizedBox(height: 10),
                      Text(
                        "⚠️ Este CEP não existe ou é inválido.",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }

                if (widget.controller.lastAddress != null) {
                  final addr = widget.controller.lastAddress!;
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(Icons.location_on, size: 40, color: Colors.blue),
                          const SizedBox(height: 15),
                          Text(
                            addr.logradouro ?? 'Rua não informada',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text("${addr.bairro} - ${addr.localidade}/${addr.uf}"),
                          Text("CEP: ${addr.cep}"),
                          const Divider(height: 30),
                          ElevatedButton.icon(
                            onPressed: _openMap,
                            icon: const Icon(Icons.navigation),
                            label: const Text("TRAÇAR ROTA NO MAPA"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }

                // 4. ESTADO: Inicial (Tela Vazia)
                return const Text("Aguardando sua consulta...");
              },
            ),
          ],
        ),
      ),
    );
  }
}