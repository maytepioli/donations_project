import 'package:donations/models/donations_model.dart';
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
    List<Donations>? donation,
  }): uuid = uuid ?? _uuidGenerator.v4(), 
  assert(uuid == null || uuid.isNotEmpty, 'id cannot be empty'),
  donation = donation ?? [];

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
  /// Lista de donaciones del usuario
  final List<Donations> donation;


  /// Serializa un objeto a un json
  Map<String, dynamic> toJson() => _$UserToJson(this);
  
  /// Metodo copyWith
  User copyWith({ 
    String? name, 
    String? password,
    String? email,  
    String? phoneNumber,
    List<Donations>? donation
  }) {
    return User(
      uuid: this.uuid,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      donation: donation ?? this.donation,
    );
  }

  /// Metdo para agregar una nueva donacion
  Donations addDonation(Map<String, dynamic> donationData) {
    final newDonation = Donations.fromJson(donationData);
    donation.add(newDonation);

    return newDonation;
  }


  @override
  List<Object?> get props => [
    uuid,
    name,
    password,
    email,
    phoneNumber,
    donation,
    ];
}
