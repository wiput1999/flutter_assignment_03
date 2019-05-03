import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/models/todo.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TodoListState();
  }
}

class TodoListState extends State {
  int _index = 0;

  List<Todo> _todoItems = List();
  List<Todo> _doneItems = List();

  TodoProvider _db;

  TodoListState() {
    _db = TodoProvider();
  }

  @override
  void initState() {
    super.initState();
    _db.open().then((result) {
      getTodos();
    });
  }

  void getTodos() {
    _db.getTodos().then((r) {
      setState(() {
        _todoItems = r;
      });
    });
  }

  void getDone() {
    _db.getDones().then((r) {
      setState(() {
        _doneItems = r;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      _todoItems.length == 0
          ? Text('No data found...')
          : ListView(
              children: _todoItems.map((todo) {
                return CheckboxListTile(
                  title: Text(todo.subject),
                  value: todo.done,
                  onChanged: (bool value) {
                    setState(() {
                      todo.done = value;
                      _db.setTodoDone(todo);
                      getTodos();
                    });
                  },
                );
              }).toList(),
            ),
      _doneItems.length == 0
          ? Text('No data found...')
          : ListView(
              children: _doneItems.map((todo) {
                return CheckboxListTile(
                  title: Text(todo.subject),
                  value: todo.done,
                  onChanged: (bool value) {
                    setState(() {
                      todo.done = value;
                      _db.setTodoDone(todo);
                      getDone();
                    });
                  },
                );
              }).toList(),
            )
    ];

    final List topBar = <Widget>[
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          _db.deleteDone().then((_) {
            getDone();
          });
        },
      )
    ];

    return new Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        actions: <Widget>[topBar[_index]],
        automaticallyImplyLeading: false,
      ),
      body: Center(child: _children[_index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('Task')),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_all), title: Text("Completed"))
        ],
        onTap: (int index) {
          setState(() {
            _index = index;
            if (index == 0) {
              getTodos();
            } else {
              getDone();
            }
          });
        },
      ),
    );
  }
}
