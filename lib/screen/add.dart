import 'package:flutter/material.dart';

class TodoForm {
  String subject;
}

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TodoForm todoForm = TodoForm();

    TextEditingController subjectController = TextEditingController();

    TextFormField todoTextField = TextFormField(
      controller: subjectController,
      decoration: InputDecoration(
        hintText: "Subject",
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
      },
      onSaved: (value) => todoForm.subject = value,
    );

    RaisedButton submitButton = RaisedButton(
      child: const Text('Save'),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('Processing Data')));
        }
      },
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('New Subject'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              todoTextField,
              submitButton,
            ],
          ),
        ),
      ),
    );
  }
}
