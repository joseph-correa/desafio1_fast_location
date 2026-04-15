import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart'; 
import 'package:fast_location/src/routes/app_routes.dart';
import 'package:fast_location/src/routes/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inicializa o Hive
  await Hive.initFlutter();
  
  // 2. REGISTRA O ADAPTADOR
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(AddressModelAdapter());
  }

  runApp(const FastLocationApp());
}

// ESTA É A PARTE QUE ESTAVA FALTANDO NO SEU ARQUIVO:
class FastLocationApp extends StatelessWidget {
  const FastLocationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastLocation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Opcional: deixa o visual mais moderno
      ),
      // Definimos a rota inicial (Splash Screen)
      initialRoute: AppRoutes.initial,
      // Usamos o seu gerador de rotas para navegar entre as telas
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}