import 'package:flutter/material.dart';
class FloatIconBouton extends StatelessWidget {
  final Function onPressed;
  final Color buttonColor;
  final IconData icon;
  final Color color;
  final String heroTag;

  const FloatIconBouton(
      {Key key,
        @required this.onPressed,
        this.buttonColor,
        @required this.icon,
        this.color,
        this.heroTag
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: heroTag,
        onPressed: onPressed,
        backgroundColor: buttonColor ?? Colors.blue,
        child: Icon(icon));
  }
}