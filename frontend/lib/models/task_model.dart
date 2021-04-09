import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo/blocs/tasks/task_entity.dart';

class Task extends Equatable{
  String id;
  String title;
  String description;
  final DateTime createdAt;
  DateTime updatedAt;
  bool isCompleted;

  Task({
    this.title, 
    this.description,
    this.isCompleted = false,
    this.createdAt,
    this.updatedAt,
    String id,
  });
  /*factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'], title: json['title'], updatedAt: json['updatedAt'], description: json['description'], isCompleted: json['isCompleted'], createdAt: json['createdAt']);
  }
  dynamic toJson() => {'id': id, 'title': title, 'description': description};*/

  Task copyWith({ bool isCompleted, String id, String descriptiton, String title }) {
    return Task(
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
      description: description ?? this.description,
      title: title ?? this.title,
    );
  }

  @override
  List<Object> get props => [isCompleted, id, description, title];

  @override
  String toString() {
    return 'Task { isCompleted: $isCompleted, title: $title, description: $description, id: $id }';
  }

  TaskEntity toEntity() {
    return TaskEntity(title, id, description, isCompleted);
  }

  static Task fromEntity(TaskEntity entity) {
    return Task(
      title: entity.title,
      isCompleted: entity.isCompleted ?? false,
      description: entity.description,
      id: entity.id,
    );
  }
}
