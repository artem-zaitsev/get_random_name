import 'package:flutter/material.dart';
import 'package:get_random_name/loading_btn.dart';

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

  final snack = SnackBar(content: Text("Handle error!"));

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
              action: setName,
              actionIfError: () {
                setName("oops!");

                Scaffold.of(context).showSnackBar(snack);
              },
            )
          ],
        ),
      );
}
