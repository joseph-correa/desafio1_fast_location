import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fast_location/src/http/http_client.dart'; 
import '../modules/initial/page/initial_page.dart';
import '../modules/home/page/home_page.dart';
import '../modules/home/controller/home_controller.dart';
import '../modules/home/service/home_service.dart';
import '../modules/home/repositories/home_repository.dart';
import '../modules/home/repositories/home_local_repository.dart';
import '../modules/history/page/history_page.dart';
import '../modules/history/controller/history_controller.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(builder: (_) => const InitialPage());

      case AppRoutes.home:
        final client = HttpClient(); 
        
        final repository = HomeRepository(client.dio);
        
        final service = HomeService(repository, HomeLocalRepository());
        final controller = HomeController(service);

        return MaterialPageRoute(
          builder: (_) => HomePage(controller: controller),
        );

      case AppRoutes.history:
        return MaterialPageRoute(
          builder: (_) => HistoryPage(controller: HistoryController()),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}