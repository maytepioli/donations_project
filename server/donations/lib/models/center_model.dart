import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
//import 'package:meta/meta.dart';
/// {@template donations}
/// A very good dart package
/// {@endtemplate}
// part 'center.g.dart'; // Archivo generado automáticamente

@JsonSerializable()
class Center extends Equatable {
  /// {@macro donations}
  static final Uuid _uuidGenerator = Uuid();
  Center({
    String? uuid,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
  })  : uuid = uuid ?? _uuidGenerator.v4(),
        assert(uuid == null || uuid.isNotEmpty, 'id cannot be empty');

  final String uuid;
  final String name;
  final String address;
  final String phoneNumber;
  final String email;

  ///Metodo q convierte un json en un objeto
  factory Center.fromJson(Map<String, dynamic> json) {
    return Center(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
    );
  }

  ///Metodo q convierte un objeto en un json

  @override
  List<Object?> get props => [uuid, name, address, phoneNumber, email];
}
