import 'package:flutter/material.dart';
import 'package:get_random_name/loading_btn.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String url = "http://uinames.com/api/";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("Flutter Random Name"),
        ),
        body: new MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _name = "";
  bool _isLoading = false;

  final snack = SnackBar(content: Text("Handle error!"));

  _generateName() async {
    toggleLoading();

    try {
      http.Response resp = await _getNameResponse();
      Map map = jsonDecode(resp.body);

      setName(map["name"]);
      toggleLoading();
    } catch (e) {
      setName("oops!");

      Scaffold.of(context).showSnackBar(snack);
      toggleLoading();
    }
  }

  void toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  _getNameResponse() => http.get(url);

  void setName(String name) {
    setState(() {
      _name = name;
    });
  }

  @override
  Widget build(BuildContext context) => Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '$_name',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            LoadingButton(
              isLoading: _isLoading,
              action: _generateName,
            )
          ],
        ),
      );
}
