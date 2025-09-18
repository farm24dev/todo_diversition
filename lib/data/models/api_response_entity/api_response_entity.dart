import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'api_response_entity.g.dart';

@JsonSerializable()
class ApiResponseEntity {
    @JsonKey(name: "success")
    bool? success;
    @JsonKey(name: "message")
    String? message;

    ApiResponseEntity({
        this.success,
        this.message,
    });

    factory ApiResponseEntity.fromJson(Map<String, dynamic> json) => _$ApiResponseEntityFromJson(json);

    Map<String, dynamic> toJson() => _$ApiResponseEntityToJson(this);
}
