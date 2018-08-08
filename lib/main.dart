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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
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
  bool isLoading = false;

  final snack = SnackBar(content: Text("Handle error!"));

  void setName(String name) {
    setState(() {
      _name = name;
      isLoading = false;
    });
  }

  _generateName() async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response resp = await _getNameResponse();
      Map map = jsonDecode(resp.body);

      setName(map['name']);
    } catch (e) {
      setName("Oops!");

      Scaffold.of(context).showSnackBar(snack);
    }
  }

  _getNameResponse() => http.get(url);

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
            _buildRaisedButton()
          ],
        ),
      );

  RaisedButton _buildRaisedButton() => RaisedButton(
        onPressed: isLoading
            ? null
            : () {
                _generateName();
              },
        child: _buildButtonChild(),
        splashColor: Colors.tealAccent,
      );

  _buildButtonChild() {
    if (isLoading) {
      return Transform.scale(
        scale: 0.5,
        child: CircularProgressIndicator(),
      );
    } else {
      return Text("Click for name");
    }
  }
}
