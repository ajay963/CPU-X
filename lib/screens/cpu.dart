import 'package:cpu_x/components/animation.dart';
import 'package:cpu_x/components/constants.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:android_device_info/android_device_info.dart';

class CPUInfo extends StatefulWidget {
  @override
  _CPUInfoState createState() => _CPUInfoState();
}

class _CPUInfoState extends State<CPUInfo> {
  String manufacturer;
  String osVersion;
  String model;
  String phoneType;
  int buildVersionSDK;
  bool isDeviceRooted;

  var _cpuInfo = {};

  @override
  void initState() {
    super.initState();

    _getCPUInfo();
  }

  Future<void> _getCPUInfo() async {
    var cpuInfo = await AndroidDeviceInfo().getSystemInfo();
    print(CPUInfo);

    if (cpuInfo['error'] != null) {
      print(cpuInfo['message']);
    }

    if (!mounted) return;

    setState(() {
      _cpuInfo = cpuInfo;
      //initialized device information
      manufacturer = _cpuInfo['manufacturer'];
      model = _cpuInfo['model'];
      osVersion = _cpuInfo['osVersion'];
      phoneType = _cpuInfo['phoneType'];
      buildVersionSDK = _cpuInfo['buildVersionSDK'];
      isDeviceRooted = _cpuInfo['isDeviceRooted'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBoxColor,
      appBar: AppBar(
        backgroundColor: kBoxColor,
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: kBoxColor,
        child: _cpuInfo.isEmpty
            ? Center(child: CircularProgressIndicator())
            : _buildBatteryInfo(),
      ),
    );
  }

  _buildBatteryInfo() {
    if (_cpuInfo['error'] != null) {
      return Text('Failed to get battery information.');
    }
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Expanded(
              flex: 1,
              child: Text(
                'Device Info',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Bahnschrift',
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: kFontBlack),
              )),
          Expanded(
              flex: 3,
              child: Container(
                height: 350,
                width: 350,
                child: FlareActing(
                  artBordNO: 1,
                ),
              )),
          Expanded(flex: 6, child: getDeviceData())
        ],
      ),
    );
  }

  getDeviceData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxtCards(getData: 'Brand: $manufacturer'),
        TxtCards(getData: 'Model: $model'),
        TxtCards(getData: 'OS version: $osVersion'),
        TxtCards(getData: 'Phone Type: $phoneType'),
        TxtCards(getData: 'SDK version: $buildVersionSDK'),
        TxtCards(getData: 'Rooted: $isDeviceRooted')
      ],
    );
  }
}

class TxtCards extends StatelessWidget {
  final String getData;
  TxtCards({@required this.getData});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kRed,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.only(left: 10, bottom: 5, top: 5),
      width: MediaQuery.of(context).size.width - 100,
      child: Text(
        getData,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: 'Lato-Bold',
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
        ),
      ),
    );
  }
}
