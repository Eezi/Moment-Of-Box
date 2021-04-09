import 'dart:async';
import 'dart:core';

import 'task_entity.dart';

/// A class that Loads and Persists todos. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
///
/// The domain layer should depend on this abstract class, and each app can
abstract class TasksRepository {
  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Tasks from a Web Client.
  Future<List<TaskEntity>> loadTasks();

  // Persists tasks to local disk and the web
  Future saveTasks(List<TaskEntity> tasks);
}