import 'dart:convert';
import 'package:dio/dio.dart';
import '../model/address_model.dart';

class HomeRepository {
  final Dio _dio;
  HomeRepository(this._dio);

  Future<AddressModel> getAddress(String cep) async {

    final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');
    
    try {
      final response = await _dio.get('$cleanCep/json/');
      
      dynamic data = response.data;

      if (data is String) {
        data = jsonDecode(data);
      }

      if (data == null || data['erro'] == true || data['erro'] == "true") {
        throw Exception('CEP não encontrado');
      }

      return AddressModel.fromJson(data);
      
    } on DioError catch (e) {
      print("Erro de rede Dio: ${e.message}");
      throw Exception('Falha na conexão com o servidor');
    } catch (e) {
      print("Erro inesperado no Repository: $e");
      rethrow;
    }
  }
}