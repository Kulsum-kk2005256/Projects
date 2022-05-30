import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_notes/pages/view_notes.dart';

import 'pages/add_notes.dart';

void main() {
  runApp(const MyApp());
}

List list = [];
void addToList(var json) {
  list.add(json);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: buildBottomBar(),
        body: buildPages(),
      );

  Widget buildBottomBar() {
    final style = TextStyle(color: Colors.white);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Text('', style: style),
          label: 'Add Notes',
        ),
        BottomNavigationBarItem(
          icon: Text('', style: style),
          label: 'View Notes',
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }

// var myJSON = jsonDecode(incomingJSONText);
// _controller = QuillController(
//           document: Document.fromJson(myJSON),
//           selection: TextSelection.collapsed(offset: 0));
  VewNotes() {
    return ListView.builder(
        padding: const EdgeInsets.all(100),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: Text('${jsonDecode(list[index])}')),
          );
        });
  }

  buildPages() {
    switch (index) {
      case 0:
        return AddNotes();
      default:
        return VewNotes();
    }
  }
}
