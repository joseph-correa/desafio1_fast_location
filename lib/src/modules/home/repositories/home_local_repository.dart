import 'package:hive/hive.dart';
import '../model/address_model.dart';

class HomeLocalRepository {
  Future<void> saveAddress(AddressModel address) async {
    final box = await Hive.openBox<AddressModel>('history_box');
    
    await box.put(address.cep, address);
  }
}