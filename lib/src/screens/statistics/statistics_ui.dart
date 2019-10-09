import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'StatisticsScreen',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'This Screen is under construction',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.build,
            size: 60,
          ),
        ],
      ),
    );
  }
}
