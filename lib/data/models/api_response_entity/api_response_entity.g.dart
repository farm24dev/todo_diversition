// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponseEntity _$ApiResponseEntityFromJson(Map<String, dynamic> json) =>
    ApiResponseEntity(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ApiResponseEntityToJson(ApiResponseEntity instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};
