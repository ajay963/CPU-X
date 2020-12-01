import 'package:cpu_x/components/constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cpu_x/components/animation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:android_device_info/android_device_info.dart';

class BatteryInfo extends StatefulWidget {
  @override
  _BatteryInfoState createState() => _BatteryInfoState();
}

class _BatteryInfoState extends State<BatteryInfo> {
  var _batteryInfo = {};
  int batteryPercentage;
  int batteryVoltage;
  int batteryTemperature;
  String batteryHealth;

  @override
  void initState() {
    super.initState();

    _getBatteryInfo();
  }

  Future<void> _getBatteryInfo() async {
    double temp;
    var batteryInfo = await AndroidDeviceInfo().getBatteryInfo();
    print(batteryInfo);

    if (batteryInfo['error'] != null) {
      print(batteryInfo['message']);
    }

    if (!mounted) return;

    setState(() {
      _batteryInfo = batteryInfo;
      //battery initializer
      batteryPercentage = _batteryInfo['batteryPercentage'];
      temp = _batteryInfo['batteryTemperature'];
      batteryTemperature = temp.toInt();
      batteryVoltage = _batteryInfo['batteryVoltage'];
      batteryHealth = _batteryInfo['batteryHealth'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBoxColor,
      appBar: AppBar(
        backgroundColor: kBoxColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: _batteryInfo.isEmpty
            ? Center(child: CircularProgressIndicator())
            : _buildBatteryInfo(),
      ),
    );
  }

  _buildBatteryInfo() {
    if (_batteryInfo['error'] != null) {
      return Center(
        child: LatoTxt(
            txt: 'Process Failed',
            fontFamily: 'Lato',
            size: 36,
            color: kFontBlack),
      );
    }
    return Container(
      color: kBoxColor,
      margin: EdgeInsets.only(top: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: LatoTxt(
                txt: 'Battery Info',
                fontFamily: 'Bahnschrift',
                size: 48,
                color: kFontBlack),
          ),
          Expanded(
              flex: 3,
              child: Container(
                height: 350,
                width: 350,
                child: FlareActing(artBordNO: 3),
              )),
          Expanded(flex: 6, child: batteryData()),
        ],
      ),
    );
  }

  batteryData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LatoTxt(
            txt: '$batteryPercentage%',
            fontFamily: 'Bahnschrift',
            size: 56,
            color: kDarkGreen),
        SizedBox(height: 10),
        LatoTxt(
            txt: 'Battery Left',
            fontFamily: 'Lato-Black',
            size: 36,
            color: kFontBlack),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 50,
          animation: true,
          lineHeight: 30.0,
          animationDuration: 2500,
          percent: batteryPercentage / 100,
          //center: Text('$batteryPercentage%'),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: kGreen,
          backgroundColor: kYellow,
        ),
        SizedBox(height: 20),
        LatoTxt(
            txt: 'Battery Health',
            fontFamily: 'Lato-Black',
            size: 36,
            color: kFontBlack),
        LatoTxt(
            txt: batteryHealth,
            fontFamily: 'Lato-Black',
            size: 36,
            color: kDarkGreen),
        SizedBox(height: 20),
        LatoTxt(
            txt: 'Battery Temp',
            fontFamily: 'Lato-Black',
            size: 36,
            color: kFontBlack),
        LatoTxt(
            txt: '$batteryTemperature celcius',
            fontFamily: 'Lato-Black',
            size: 36,
            color: kDarkGreen)
      ],
    );
  }
}

class LatoTxt extends StatelessWidget {
  final double size;
  final String fontFamily;
  final String txt;
  final Color color;
  LatoTxt(
      {@required this.txt,
      @required this.fontFamily,
      @required this.size,
      @required this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
