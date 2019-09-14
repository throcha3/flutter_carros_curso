import 'package:flutter/material.dart';
import 'package:flutter_carros_curso/drawer_list.dart';
import 'package:flutter_carros_curso/pages/carro/carro_api.dart';

import 'package:flutter_carros_curso/pages/carro/carros_listview.dart';
import 'package:flutter_carros_curso/utils/prefs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs()async {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = await Prefs.getInt("tabIdx");
    _tabController.addListener((){
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        bottom: TabBar(
          tabs: <Widget>[
            Tab(text: "Clássicos"),
            Tab(text: "Esportivos"),
            Tab(text: "Luxo"),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarrosListView(TipoCarro.classicos),
          CarrosListView(TipoCarro.esportivos),
          CarrosListView(TipoCarro.luxo),
        ],
      ),
      drawer: DrawerList(),
    );
  }
}
