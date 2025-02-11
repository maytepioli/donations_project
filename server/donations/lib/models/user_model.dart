import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
//import 'package:meta/meta.dart';
/// {@template donations}
/// A very good dart package
/// {@endtemplate}
@JsonSerializable()
class User extends Equatable {
  /// {@macro donations}
  static final Uuid _uuidGenerator = Uuid();
  User({
    String? uuid, 
    required this.name, 
    required this.password, 
    required this.email, 
    required this.phoneNumber,
  }): uuid = uuid ?? _uuidGenerator.v4(), 
  assert(uuid == null || uuid.isNotEmpty, 'id cannot be empty');

  final String uuid;
  final String name;
  final String password;
  final String email;
  final String phoneNumber;

  ///Metodo q convierte un json en un objeto
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'] as String, 
      name: json['name'] as String, 
      password: json['password'] as String, 
      email: json['email'] as String, 
      phoneNumber: json['phoneNumber'] as String,
      );
  }

  ///Metodo para deserializar un objeto a un json
  ///Metodo para vefificar el email valido
  ///Metodo para editar los datos del usuario
  @override
  List<Object?> get props => [uuid, name, password, email, phoneNumber];
}
