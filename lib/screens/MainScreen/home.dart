import 'package:flutter/material.dart';
import 'package:continents_app/screens/MainScreen/Oceans.dart';
import 'package:continents_app/screens/MainScreen/continents.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _screens = [
    const Continents(),
    const Ocean(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Discover Continents & Oceans',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 36.0),
            indicatorColor: Colors.white38,
            tabs: [
              Tab(
                icon: Icon(Icons.public),
                text: 'Continents',
              ),
              Tab(
                icon: Icon(Icons.waves),
                text: 'Oceans',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: _screens,
        ),
      ),
    );
  }
}
