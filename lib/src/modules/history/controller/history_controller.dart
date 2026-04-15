import 'package:mobx/mobx.dart';
import 'package:hive/hive.dart';
import '../../home/model/address_model.dart';

part 'history_controller.g.dart';

class HistoryController = _HistoryControllerBase with _$HistoryController;

abstract class _HistoryControllerBase with Store {
  @observable
  ObservableList<AddressModel> historyList = ObservableList<AddressModel>();

  @action
  Future<void> loadHistory() async {
    final box = await Hive.openBox<AddressModel>('history_box');
    historyList.clear();
    historyList.addAll(box.values.toList().reversed); 
  }
}