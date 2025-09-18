import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'todo_response_entity.g.dart';

@JsonSerializable()
class TodoResponseEntity {
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<TodoModel>? data;

  TodoResponseEntity({this.success, this.message, this.data});

  factory TodoResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TodoResponseEntityToJson(this);
}

@JsonSerializable()
class TodoModel {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "note")
  String? note;
  @JsonKey(name: "date")
  int? date;
  @JsonKey(name: "startTime")
  int? startTime;
  @JsonKey(name: "endTime")
  int? endTime;
  @JsonKey(name: "color")
  String? color;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "tag")
  String? tag;
  @JsonKey(name: "createdAt")
  int? createdAt;
  @JsonKey(name: "updatedAt")
  int? updatedAt;

  TodoModel({
    this.id,
    this.title,
    this.note,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.status,
    this.tag,
    this.createdAt,
    this.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
