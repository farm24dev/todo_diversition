// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoResponseEntity _$TodoResponseEntityFromJson(Map<String, dynamic> json) =>
    TodoResponseEntity(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodoResponseEntityToJson(TodoResponseEntity instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
  id: json['id'] as String?,
  title: json['title'] as String?,
  note: json['note'] as String?,
  date: (json['date'] as num?)?.toInt(),
  startTime: (json['startTime'] as num?)?.toInt(),
  endTime: (json['endTime'] as num?)?.toInt(),
  color: json['color'] as String?,
  status: json['status'] as String?,
  tag: json['tag'] as String?,
  createdAt: (json['createdAt'] as num?)?.toInt(),
  updatedAt: (json['updatedAt'] as num?)?.toInt(),
);

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'note': instance.note,
  'date': instance.date,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'color': instance.color,
  'status': instance.status,
  'tag': instance.tag,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
