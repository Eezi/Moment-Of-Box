import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_todo/models/task_model.dart';
import 'package:flutter_todo/blocs/tasks/tasks_event.dart';
import 'package:flutter_todo/blocs/tasks/tasks_state.dart';
import 'package:flutter_todo/blocs/tasks/tasks_repository.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksRepository tasksRepository;

  TasksBloc({@required this.tasksRepository}) : super(TasksLoadInProgress());

  @override
  Stream<TasksState> mapEventToState(TasksEvent event) async* {
    if (event is TasksLoadSuccess) {
      yield* _mapTasksLoadedToState();
    } else if (event is TaskAdded) {
      yield* _mapTaskAddedToState(event);
    } else if (event is TaskUpdated) {
      yield* _mapTaskUpdatedToState(event);
    } else if (event is TaskDeleted) {
      yield* _mapTaskDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TasksState> _mapTasksLoadedToState() async* {
    try {
      final tasks = await this.tasksRepository.loadTasks();
      yield TasksLoadSuccess(
        tasks.map(Task.fromEntity).toList(),
      );
    } catch (_) {
      yield TasksLoadFailure();
    }
  }

  Stream<TasksState> _mapTaskAddedToState(TaskAdded event) async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks = List.from((state as TasksLoadSuccess).tasks)
        ..add(event.task);
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapTaskUpdatedToState(TaskUpdated event) async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks = (state as TasksLoadSuccess).tasks.map((task) {
        //return task.id == event.updatedTasks.id ? event.updatedTasks : task;
      }).toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapTaskDeletedToState(TaskDeleted event) async* {
    if (state is TasksLoadSuccess) {
      final updatedTasks = (state as TasksLoadSuccess)
          .tasks
          .where((task) => task.id != event.task.id)
          .toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapToggleAllToState() async* {
    if (state is TasksLoadSuccess) {
      final allComplete =
          (state as TasksLoadSuccess).tasks.every((task) => task.isCompleted);
      final List<Task> updatedTasks = (state as TasksLoadSuccess)
          .tasks
          .map((task) => task.copyWith(isCompleted: !allComplete))
          .toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Stream<TasksState> _mapClearCompletedToState() async* {
    if (state is TasksLoadSuccess) {
      final List<Task> updatedTasks =
          (state as TasksLoadSuccess).tasks.where((task) => !task.isCompleted).toList();
      yield TasksLoadSuccess(updatedTasks);
      _saveTasks(updatedTasks);
    }
  }

  Future _saveTasks(List<Task> tasks) {
   /* return TasksRepository.saveTasks(
      tasks.map((task) => task.toEntity()).toList(),
    );*/
  }
}