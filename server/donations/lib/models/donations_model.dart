import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
//import 'package:meta/meta.dart';
/// {@template donations}
/// A very good dart package
/// {@endtemplate}
@JsonSerializable()
class Donations extends Equatable {
  /// {@macro donations}
  static const Uuid _uuidGenerator = Uuid();
  Donations({
    String? uuid,
    required this.type,
    required this.name,
    String description = '',
    DateTime? creationDate,
  }): uuid = uuid ?? _uuidGenerator.v4(), 
    assert(uuid == null || uuid.isNotEmpty, 'id cannot be empty'),
    creationDate = creationDate ?? DateTime.now(),
    description = descriptionLenght(description);

  final String uuid;
  final String type;
  final String name;
  final String description;
  final DateTime creationDate;
  //List<String> imgUrls;
  //User creator;

  factory Donations.fromJson(Map<String, dynamic> json) {
    return Donations(
        uuid: json['uuid'] as String,
        //creator: json['creator'] as User,
        type: json['type'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        //imgUrls: json['imgUrls'] as List<String>,
    );
  }

  static String descriptionLenght(String description) {
    if (description.length > 100) {
      throw Exception('Description is too long');
    }
    return description;
  }

  ///Metodo q convierte un objeto en un json
  ///Metodos editObj, deleteObj
  ///
  @override
  List<Object?> get props => [uuid, type, name, description, creationDate];

}
