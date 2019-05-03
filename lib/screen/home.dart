import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/models/todo.dart';
import 'package:flutter_assignment_03/screen/completed.dart';
import 'package:flutter_assignment_03/screen/todolist.dart';
import 'package:flutter_assignment_03/utils/firestore_utils.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<AppBar> appBars = <AppBar>[
      AppBar(
        title: Text('Todo'),
        centerTitle: true,
        actions: <IconButton>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, 'AddTaskPage');
            },
          ),
        ],
      ),
      AppBar(
        title: Text('Todo'),
        centerTitle: true,
        actions: <IconButton>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              FirestoreUtils.deleteAllCompleted();
            },
          ),
        ],
      ),
    ];

    final List<Widget> pages = <Widget>[
      TaskList(),
      CompletedList(),
    ];

    return Scaffold(
      appBar: appBars[this._currentIndex],
      body: pages[this._currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          currentIndex: this._currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Task'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              title: Text('Completed'),
            ),
          ],
          onTap: (int i) {
            setState(() {
              this._currentIndex = i;
            });
          },
        ),
      ),
    );
  }
}
