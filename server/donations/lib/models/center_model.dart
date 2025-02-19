import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
part 'center_model.g.dart';
/// Clase modelo de centro
@JsonSerializable()
class Center extends Equatable {
  /// Constructor de la clase
  Center({
    String? uuid,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
  }): uuid = uuid ?? _uuidGenerator.v4(),
    assert(uuid == null || uuid.isNotEmpty, 'id cannot be empty');
  /// Deserializa un json a un objeto
  factory Center.fromJson(Map<String, dynamic> json) =>
    _$CenterFromJson(json);
  /// Generador de uuid para el centro
  static final Uuid _uuidGenerator = Uuid();
  /// Identificador unico del centro
  final String uuid;
  /// Nombre del centro
  final String name;
  /// Direccion del centro
  final String address;
  /// Numero de telefono del centro
  final String phoneNumber;
  /// Correo electronico del centro
  final String email;
  /// Serializa un objeto a un json
  Map<String, dynamic> toJson() => _$CenterToJson(this);
  @override
  List<Object?> get props => [uuid, name, address, phoneNumber, email];
}