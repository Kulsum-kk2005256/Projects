import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/src/widgets/text.dart' as text;
import 'package:flutter_application/main.dart' as m;
import 'package:markdown/markdown.dart' as md;
import 'package:markdown/markdown.dart';
import 'package:markdown_quill/markdown_quill.dart';

class AddNotes extends StatefulWidget {
  @override
  AddNoteState createState() => AddNoteState();
}

QuillController _controller = QuillController.basic();

class AddNoteState extends State<AddNotes> {
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

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
                    final mdDocument = md.Document(encodeHtml: false);

                    final mdToDelta =
                        MarkdownToDelta(markdownDocument: mdDocument);

                    final deltaToMd = DeltaToMarkdown();
                    final markdown =
                        deltaToMd.convert(_controller.document.toDelta());

                    m.addToList(markdownToHtml(markdown));
                    m.addToTitleList(myController.text);
                    _controller.clear();
                    myController.clear();
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
                controller: myController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: QuillToolbar.basic(
                controller: _controller,
                showBoldButton: true,
                showFontSize: true,
                showLink: false,
                showImageButton: false,
                showQuote: false,
                showInlineCode: false,
                showCameraButton: false,
                showVideoButton: false,
                showCodeBlock: false,
                showAlignmentButtons: false,
                showCenterAlignment: false,
                showRightAlignment: false,
                showLeftAlignment: false,
                showJustifyAlignment: false,
                showHeaderStyle: false,
                showIndent: false,
                showDirection: false,
                showRedo: false,
                showUndo: false,
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.deepPurple)),
                child:
                    QuillEditor.basic(controller: _controller, readOnly: false),
              ),
            )),
            // SizedBox(
            //   height: 50, // <-- SEE HERE
            // ),
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
