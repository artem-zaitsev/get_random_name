import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({Key key, this.isLoading, this.action}) : super(key: key);

  final Function action;

  final bool isLoading;

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
      onPressed: isLoading ? null : action,
      child: _buildButtonChild(),
      splashColor: Colors.tealAccent,
    );
  }
}
