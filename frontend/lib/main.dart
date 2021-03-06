import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/tasks/tasks_state.dart';
import 'package:flutter_todo/models/task_model.dart';
import 'package:flutter_todo/models/colors.dart';
import 'package:flutter_todo/screens/taskEditor.dart';

import 'blocs/tasks/tasks_bloc.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  final TasksBloc tasksBloc = TasksBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
    bloc: tasksBloc,
    builder: (context, state) {
      return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tehtävälista',
      home: new TodoList(),
    );
    });
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<Task> _todoItems = [];
  bool pressed = false;

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _addLinethrough(Task task) {
    setState(() => task.isCompleted = !task.isCompleted);
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text(
                  'Poistetaanko "${_todoItems[index].title}" tehtävä?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('EI'),
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text('KYLLÄ'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(Task task, int index) {
    return ListTile(
      //trailing: Icon(Icons.check_box_outline_blank),
      title: Text(
        task.title,
        style: TextStyle(
            fontSize: 21,
            color: Colors.white,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      trailing: new IconButton(
          icon: Icon(Icons.delete_outline, color: AppColors.ErroColor, size: 30.0),
          onPressed: () => _promptRemoveTodoItem(index)),
      leading: new IconButton(
          icon: Icon(Icons.check_circle, color: AppColors.SuccessColor, size: 30.0),
          onPressed: () => _addLinethrough(task)),
      onTap: () => _pushUpdateTodoScreen(task, index),
    );
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: new Text('Tehtävälista', style: TextStyle(fontSize: 25)),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: AppColors.PrimaryColor),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return CreateTask(addTask: (String title, String description) {
        if (title.length > 0) {
          final newTask = Task(
              id: _todoItems.length.toString(),
              description: description,
              createdAt: DateTime.now(),
              title: title);
          setState(() => _todoItems.add(newTask));
        }
      });
    }));
  }

  void _pushUpdateTodoScreen(task, index) {

    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return CreateTask(updateTask: (String title, String description) {
        if (title.length > 0) {
          setState(() => {
          _todoItems[index].title = title, 
          _todoItems[index].description = description
          }  );
        }
      },
      task: task);
    }));
  }

}
