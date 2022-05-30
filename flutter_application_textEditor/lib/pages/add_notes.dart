import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/src/widgets/text.dart' as text;

class AddNotes extends StatefulWidget {
  @override
  AddNoteState createState() => AddNoteState();
}

QuillController _controller = QuillController.basic();

class AddNoteState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: text.Text('Save'),
        icon: const Icon(Icons.save),
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: text.Text('Add Note'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuillToolbar.basic(controller: _controller),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlueAccent,
                    offset: const Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ),
                ]),
                child:
                    QuillEditor.basic(controller: _controller, readOnly: false),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
