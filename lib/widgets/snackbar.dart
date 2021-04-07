import 'package:flutter/material.dart';

ShowsnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.grey[600],
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
    content: FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
            size: 35,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Please enter the city name.",
            style: TextStyle(fontSize: 20, color: Colors.white),
          )
        ],
      ),
    ),
    duration: Duration(seconds: 2),
    shape:
        RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
  ));
}
