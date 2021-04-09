class TaskEntity {
  final bool isCompleted;
  final String id;
  final String description;
  final String title;

  TaskEntity(this.title, this.id, this.description, this.isCompleted);

  @override
  int get hashCode =>
      isCompleted.hashCode ^ description.hashCode ^ title.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntity &&
          runtimeType == other.runtimeType &&
          isCompleted == other.isCompleted &&
          title == other.title &&
          description == other.description &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'isCompleted': isCompleted,
      'title': title,
      'description': description,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'TaskEntity{isCompleted: $isCompleted, title: $title, decription: $description, id: $id}';
  }

  static TaskEntity fromJson(Map<String, Object> json) {
    return TaskEntity(
      json['title'] as String,
      json['id'] as String,
      json['description'] as String,
      json['isCompleted'] as bool,
    );
  }
}