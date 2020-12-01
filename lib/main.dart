import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'components/constants.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/about.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        home: DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          backgroundColor: kBoxColor,
          appBar: AppBar(
            backgroundColor: kBoxColor,
            bottom: TabBar(
                indicatorWeight: 5,
                indicatorColor: kFontBlack,
                // indicatorPadding: EdgeInsets.all(20),
                // indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.all(10),
                labelColor: kCyan,
                tabs: <Widget>[
                  Icon(Icons.apps, size: 40, color: Colors.black),
                  Icon(Icons.mobile_friendly, size: 40, color: Colors.black)
                ]),
          ),
          body: TabBarView(
            children: <Widget>[
              SafeArea(child: Home()),
              SafeArea(child: AboutPage())
            ],
          )),
    ));
  }
}

class Progress extends StatelessWidget {
  final int percent;
  Progress({@required this.percent});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 16.0,
        animation: true,
        animationDuration: 500,
        percent: percent / 100,
        center: Text(
          '$percent%',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
              color: kBlue,
              fontFamily: 'Bahnschrift'),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: kPurple,
        backgroundColor: kBlue,
      ),
    );
  }
}
