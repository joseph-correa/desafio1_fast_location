import '../model/address_model.dart';
import '../repositories/home_repository.dart';
import '../repositories/home_local_repository.dart';

class HomeService {
  final HomeRepository _repository;
  final HomeLocalRepository _localRepository;

  HomeService(this._repository, this._localRepository);

  Future<AddressModel?> searchCep(String cep) async {
    try {
      final address = await _repository.getAddress(cep);

      if (address != null) {
        await _localRepository.saveAddress(address);
      }

      return address;
    } catch (e) {
      rethrow;
    }
  }
}