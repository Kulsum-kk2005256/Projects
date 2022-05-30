import 'dart:async';

import 'package:flutter_application_search/api/repos_api.dart';
import 'package:flutter_application_search/main.dart';
import 'package:flutter_application_search/model/repo.dart';
import 'package:flutter_application_search/widget/search_widget.dart';
import 'package:flutter/material.dart';

class RepoPage extends StatefulWidget {
  @override
  RepoPageState createState() => RepoPageState();
}

class RepoPageState extends State<RepoPage> {
  List repo = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final repo = await RepoApi.getRepo(query);
    // final i = repo.elementAt(2);

    setState(() => this.repo = repo);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: repo.length,
                itemBuilder: (context, index) {
                  final rep = repo[index];

                  return buildRepo(rep);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: searchRepo,
      );

  Future searchRepo(String query) async => debounce(() async {
        final repo = await RepoApi.getRepo(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.repo = repo;
        });
      });

  Widget buildRepo(RepoItem repo) => ListTile(
        title: Text(repo.name.toString()),
        subtitle: Text(repo.id.toString()),
      );
}
