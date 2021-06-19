
import 'package:flutter/material.dart';

class ListViewPagination extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ListViewPagination>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Container(

      ),
    );
  }

}