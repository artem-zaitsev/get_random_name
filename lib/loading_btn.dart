import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  const LoadingButton({Key key, this.isLoading, this.action}) : super(key: key);

  final Function action;

  final bool isLoading;

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  _buildButtonChild() {
    if (widget.isLoading) {
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
      onPressed: widget.isLoading ? null : widget.action,
      child: _buildButtonChild(),
      splashColor: Colors.tealAccent,
    );
  }
}
