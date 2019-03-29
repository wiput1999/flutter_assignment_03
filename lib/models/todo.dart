import 'dart:async';
import 'package:sqflite/sqflite.dart';

final String tableTodo = "todo";
final String columnId = "_id";
final String columnSubject = "subject";
final String columnDone = "done";

class Todo {
  int id;
  String subject;
  bool done;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnSubject: subject,
      columnDone: done == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }

  Todo();

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    subject = map[columnSubject];
    done = map[columnDone] == 1;
  }
}

class TodoProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableTodo (
            $columnId integer primary key autoincrement,
            $columnSubject text not null,
            $columnDone integer not null
          )
        ''');
      },
    );
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());

    return todo;
  }

  Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(
      tableTodo,
      columns: [columnId, columnSubject, columnDone],
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return new Todo.fromMap(maps.first);
    }

    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(
      tableTodo,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  Future close() async => db.close();
}
