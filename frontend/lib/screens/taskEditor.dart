import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/models/colors.dart';

class CreateTask extends StatefulWidget {
  CreateTask({Key key}) : super(key: key);

  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<TodoList> {
  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('context: ${context}');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
          title: new Text('Lisää uusi tehtävä', style: TextStyle(fontSize: 23)),
          centerTitle: true,
          backgroundColor: Colors.black54),
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 350),
          children: <Widget>[
            titleTextField(),
            SizedBox(
              height: 20,
            ),
            descriptionTextField(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  circular = true;
                });
                if (_globalkey.currentState.validate()) {
                  Map<String, String> data = {
                    "titleline": title.text,
                    "description": description.text,
                  };
                }
              },
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: circular
                        ? CircularProgressIndicator()
                        : Text(
                            "Tallenna",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
      child: TextFormField(
          style: TextStyle(color: Colors.white),
          controller: title,
          onChanged: (val) => setState(() => title == val),
          validator: (value) {
            if (value.isEmpty) return "Title can't be empty";

            return null;
          },
          decoration: InputDecoration(
              fillColor: AppColors.PrimaryColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: AppColors.PrimaryColor,
                  width: 2.0,
                ),
              ),
              border: OutlineInputBorder(borderSide: BorderSide()),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: AppColors.PrimaryColor,
                width: 2,
              )),
              prefixIcon: Icon(
                Icons.title_rounded,
                color: AppColors.PrimaryColor,
              ),
              labelText: "Title",
              labelStyle: TextStyle(fontSize: 18, color: Colors.white),
              helperText: "It can't be empty",
              helperStyle: TextStyle(color: Colors.white))
          //hintText: "Käy kaupassa...",
          ),
    );
  }

  Widget descriptionTextField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: description,
      /*validator: (value) {
        if (value.isEmpty) return "About can't be empty";

        return null;
      },*/
      maxLines: 4,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: AppColors.PrimaryColor,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.PrimaryColor,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.description,
          color: AppColors.PrimaryColor,
        ),
        labelText: "Description",
        labelStyle: TextStyle(fontSize: 18, color: Colors.white),
        // helperText: "Details of your task",
        //helperStyle: TextStyle(color: Colors.white)
        //hintText: "",
      ),
    );
  }
}
