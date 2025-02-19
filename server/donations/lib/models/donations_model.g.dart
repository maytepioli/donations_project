// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Donations _$DonationsFromJson(Map<String, dynamic> json) => Donations(
      uuid: json['uuid'] as String?,
      //creator: json['creator'] as User,
      type: json['type'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      creationDate: json['creationDate'] == null
          ? null
          : DateTime.parse(json['creationDate'] as String),
    );

Map<String, dynamic> _$DonationsToJson(Donations instance) => <String, dynamic>{
      'uuid': instance.uuid,
      //'creator': instance.creator,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'creationDate': instance.creationDate.toIso8601String(),
    };
