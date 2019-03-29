import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TodoListState();
  }
}

class TodoListState extends State {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [Text('Todo'), Text('Completed')];

    final List topBar = <Widget>[
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {},
      )
    ];

    return new Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        actions: <Widget>[topBar[_index]],
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
          });
        },
      ),
    );
  }
}
