// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************
// JsonSerializableGenerator
// **************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      uuid: json['uuid'] as String?,
      name: json['name'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      donation: json['donation'] as List<Donations>,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'password': instance.password,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'donations': instance.donation,
    };