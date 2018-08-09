import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String url = "http://uinames.com/api/";

class LoadingButton extends StatefulWidget {
  const LoadingButton({Key key, this.action, this.actionIfError})
      : super(key: key);

  final Function action;
  final Function actionIfError;

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {

  bool isLoading = false;

  _generateName() async {
    try {
      http.Response resp = await _getNameResponse();
      Map map = jsonDecode(resp.body);

      widget.action(map["name"]);

      toggleLoading();
    } catch (e) {
      widget.actionIfError();

      toggleLoading();
    }
  }

  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  _getNameResponse() => http.get(url);


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

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: isLoading
          ? null
          : () {
        _generateName();

        toggleLoading();
      },
      child: _buildButtonChild(),
      splashColor: Colors.tealAccent,
    );
  }
}
