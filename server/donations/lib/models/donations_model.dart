// import 'package:donations/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'donations_model.g.dart'; 
/// Data source - in-memory cache
Map<String, Donations> donationsDb = {};
/// Clase modelo de donaciones
@JsonSerializable()
class Donations extends Equatable {
  /// Constructor de la clase
  Donations({
    String? uuid,
    // required this.creator,
    required this.type,
    required this.name,
    String description = '',
    DateTime? creationDate,
  }): uuid = uuid ?? _uuidGenerator.v4(), 
    assert(uuid == null || uuid.isNotEmpty, 'id cannot be empty'),
    creationDate = creationDate ?? DateTime.now(),
    description = descriptionLenght(description);

  /// Deserializa un json a un objeto
  factory Donations.fromJson(Map<String, dynamic> json) => 
    _$DonationsFromJson(json);

  /// Generador de uuid para la donacion
  static const Uuid _uuidGenerator = Uuid();

  /// Identificador unico de la donacion
  final String uuid;
  /// Creador de la donacion
  //late final User creator;
  /// Tipo de donacion
  final String type;
  /// Nombre de la donacion
  final String name;
  /// Descripcion de la donacion
  final String description;
  /// Fecha de creacion de la donacion
  final DateTime creationDate;
  //List<String> imgUrls;

  /// Serializa un objeto a un json
  Map<String, dynamic> toJson() => _$DonationsToJson(this);

  /// Funcion para controlar la longitud de la descripcion
  static String descriptionLenght(String description) {
    if (description.length > 100) {
      throw Exception('Description is too long');
    }
    return description;
  }

  @override
  List<Object?> get props => [
    uuid,
    //creator,
    type,
    name,
    description,
    creationDate,
    ];

}
