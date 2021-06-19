import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/repository/model/data.dart';
import 'package:flutter_app_test/repository/retrofit/api_client.dart';
import 'package:flutter_app_test/view/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// to set the root of app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Use REST Api  - Retrofit"),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showToast(context),
        label: Icon(Icons.cancel),
        backgroundColor: Colors.green,
      ),
    );
  }

  // build list view & manage states
  FutureBuilder<ResponseData> _buildBody(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<ResponseData>(
      future: client.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final ResponseData posts = snapshot.data;
          return _buildListView(context, posts);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build list view & its tile
  Widget _buildListView(BuildContext context, ResponseData posts) {
    return
      ListView.builder(itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.account_box, color: Colors.green, size: 50,),
            title: Text(
              posts.data[index]['name'], style: TextStyle(fontSize: 20),),
            subtitle: Text(posts.data[index]['email']),
            /*onTap: ()  => Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(posts.data[index]['name']))),*/
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ProductDetail(),
                settings: RouteSettings(
                  arguments: posts.data[index]['name'],
                ),
              ),
              );

            }
            //Go to the next screen with Navigator.push,
          ),
        );
      }, itemCount: posts.data.length,
      );
  }

  void _showToast(BuildContext context) {
    final snackBar = SnackBar(content: Text('Nothing add'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

class ProductDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final String todo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(todo),
      ),
    );
  }
}
