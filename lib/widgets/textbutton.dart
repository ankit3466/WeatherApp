import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TextWithButton extends StatelessWidget {
  final text;
  final style;
  final handler;
  final error;

  TextWithButton({
    @required this.text,
    this.style = const TextStyle(fontSize: 16),
    this.handler,
    @required this.error,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 15,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, color: Colors.red, height: 1.5),
          ),
        ),
        if (error != "")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                child: Text(
                  'Try Again',
                  style: TextStyle(fontSize: 25),
                ),
                textColor: Colors.blue,
                onPressed: handler,
              ),
              if (error == "AppSetting")
                TextButton(
                  onPressed: () async {
                    await Geolocator.openAppSettings();
                    handler();
                  },
                  child: Text("Open Setting",
                      style: TextStyle(fontSize: 25, color: Colors.blue)),
                ),
              if (error == "LocationSetting")
                TextButton(
                  onPressed: () async {
                    await Geolocator.openLocationSettings();
                  },
                  child: Text("Open Setting",
                      style: TextStyle(fontSize: 25, color: Colors.blue)),
                ),
            ],
          ),
        if (error == "")
          Container(
            //margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: handler,
              color: Colors.lightBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Try again",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
