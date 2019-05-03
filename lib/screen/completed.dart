import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_assignment_03/utils/firestore_utils.dart';

class CompletedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('todo')
          .where('done', isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Text('Loading...'),
            );
          default:
            return snapshot.data.documents.length == 0
                ? Center(child: Text('No data found...'))
                : ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                      return CheckboxListTile(
                        title: Text(document['title']),
                        value: document['done'],
                        onChanged: (bool value) {
                          FirestoreUtils.update(document.documentID, value);
                        },
                      );
                    }).toList(),
                  );
        }
      },
    );
  }
}
