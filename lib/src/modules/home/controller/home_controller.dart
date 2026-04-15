import 'package:mobx/mobx.dart';
import '../model/address_model.dart';
import '../service/home_service.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final HomeService _service;

  _HomeControllerBase(this._service);

  @observable
  bool isLoading = false;

  @observable
  bool hasError = false; 

  @observable
  AddressModel? lastAddress;

  @action
  Future<void> searchCep(String cep) async {
    if (cep.isEmpty) return;

    try {
      isLoading = true;
      hasError = false;
      lastAddress = null;

      final result = await _service.searchCep(cep);
      
      if (result != null) {
        lastAddress = result;
      } else {
        hasError = true;
      }
    } catch (e) {
      hasError = true;
      lastAddress = null;
      print("Erro capturado no Controller: $e");
    } finally {
      isLoading = false;
    }
  }
}