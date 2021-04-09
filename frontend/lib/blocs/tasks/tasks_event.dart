import 'package:equatable/equatable.dart';
import 'package:flutter_todo/models/task_model.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class TaskLoadSuccess extends TasksEvent {}

class TaskAdded extends TasksEvent {
  final Task task;

  const TaskAdded(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'TaskAdded { task  : $task }';
}

class TaskUpdated extends TasksEvent {
  final Task task;

  const TaskUpdated(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'TaskUpdated { task: $task }';
}

class TaskDeleted extends TasksEvent {
  final Task task;

  const TaskDeleted(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'taskDeleted { task: $task }';
}

class ClearCompleted extends TasksEvent {}

class ToggleAll extends TasksEvent {}