import 'package:flutter/material.dart';
// import 'package:flutter_notes/pages/view_notes.dart';

import 'pages/add_notes.dart';

void main() {
  runApp(const MyApp());
}

List titleList = [];
List list = [];
void addToList(var json) {
  list.add(json);
}

void addToTitleList(var title) {
  titleList.add(title);
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
    const style = TextStyle(color: Colors.white);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(
          icon: Text('', style: style),
          label: 'Add Notes',
        ),
        const BottomNavigationBarItem(
          icon: Text('', style: style),
          label: 'View Notes',
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }

  // ignore: non_constant_identifier_names
  ViewNotes() {
    return ListView.builder(
        padding: const EdgeInsets.all(100),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child:
                    Text('Title: ${titleList[index]}\nNote:  ${list[index]}')),
          );
        });
  }

  buildPages() {
    switch (index) {
      case 0:
        return const AddNotes();
      default:
        return ViewNotes();
    }
  }
}
