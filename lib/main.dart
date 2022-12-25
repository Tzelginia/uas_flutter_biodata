import 'package:flutter/material.dart';
import 'package:uas_flutter_biodata/page/create_page.dart';
import 'package:uas_flutter_biodata/page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biodata',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
                bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'TAMBAH BIODATA',
                ),
                Tab(
                  text: 'LIST BIODATA',
                )
              ],
            )),
            body: const TabBarView(
              children: [CreatePage(), HomePage()],
            ),
          )),
    );
  }
}
