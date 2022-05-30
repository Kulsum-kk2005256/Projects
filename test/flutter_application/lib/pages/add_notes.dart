import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/src/widgets/text.dart' as text;
import 'package:flutter_application/main.dart' as m;

class AddNotes extends StatefulWidget {
  @override
  AddNoteState createState() => AddNoteState();
}

QuillController _controller = QuillController.basic();

class AddNoteState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: text.Text('Add Stuff'),
          leading: GestureDetector(
            onTap: () {/* Write listener code here */},
            child: Icon(
              Icons.close, // add custom icons also
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    m.addToList(
                        jsonEncode(_controller.document.toDelta().toJson()));
                    _controller.clear();
                  },
                  child: Icon(
                    Icons.save,
                    size: 26.0,
                  ),
                )),
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 26),
              child: QuillToolbar.basic(
                controller: _controller,
                showLink: false,
                showImageButton: false,
                showQuote: false,
                showInlineCode: false,
                showCameraButton: false,
                showVideoButton: false,
                showCodeBlock: false,
                multiRowsDisplay: false,
                showAlignmentButtons: false,
                showCenterAlignment: false,
                showDirection: false,
                showRedo: false,
                showUndo: false,
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 0),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurpleAccent,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Tags',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
