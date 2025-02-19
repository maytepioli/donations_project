// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Center _$CenterFromJson(Map<String, dynamic> json) => Center(
      uuid: json['uuid'] as String?,
      name: json['name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$CenterToJson(Center instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
    };
