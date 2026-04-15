import 'package:hive/hive.dart';

part 'address_model.g.dart'; 

@HiveType(typeId: 0)
class AddressModel extends HiveObject {
  @HiveField(0)
  String? cep;

  @HiveField(1)
  String? logradouro;

  @HiveField(2)
  String? bairro;

  @HiveField(3)
  String? localidade;

  @HiveField(4)
  String? uf;

  AddressModel({this.cep, this.logradouro, this.bairro, this.localidade, this.uf});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: json['cep'],
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
    );
  }
}