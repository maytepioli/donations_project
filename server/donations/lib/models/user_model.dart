import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
part 'user_model.g.dart';
/// Clase modelo de usuario
@JsonSerializable()
class User extends Equatable {
  /// Constructor de la clase
  User({
    String? uuid,
    required this.name,
    required this.password,
    required this.email,
    required this.phoneNumber,
  }): uuid = uuid ?? _uuidGenerator.v4(),
  assert(uuid == null || uuid.isNotEmpty, 'id cannot be empty');
  /// Deserializa un json a un objeto
  factory User.fromJson(Map<String, dynamic> json) =>
    _$UserFromJson(json);
  /// Generador de uuid para el usuario
  static final Uuid _uuidGenerator = Uuid();
  /// Identificador unico del usuario
  final String uuid;
  /// Nombre del usuario
  final String name;
  /// Contraseña del usuario
  final String password;
  /// Correo electronico del usuario
  final String email;
  /// Numero de telefono del usuario
  final String phoneNumber;
  /// Serializa un objeto a un json
  Map<String, dynamic> toJson() => _$UserToJson(this);
  /// Metodo copyWith
  User copyWith({
    String? name,
    String? password,
    String? email,
    String? phoneNumber,
  }) {
    return User(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
  ///Metodo para deserializar un objeto a un json
  ///Metodo para vefificar el email valido
  @override
  List<Object?> get props => [uuid, name, password, email, phoneNumber];
}
