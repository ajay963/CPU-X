import 'package:cpu_x/components/animation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:cpu_x/components/constants.dart';
import 'package:android_device_info/android_device_info.dart';

class MemoryInfo extends StatefulWidget {
  @override
  _MemoryInfoState createState() => _MemoryInfoState();
}

class _MemoryInfoState extends State<MemoryInfo> {
  double availableInternalMemorySize; //Bytes
  double availableExternalMemorySize; //Bytes
  double totalExternalMemorySize; //Bytes
  double totalInternalMemorySize;
  int totalType = 1; //Bytes
  int internaMemoryRatio;
  int externaMemoryRatio;
  var _memoryInfo = {};

  @override
  void initState() {
    super.initState();

    _getMemoryInfo();
  }

  //put Memory values

  Future<void> _getMemoryInfo() async {
    double tempCal;
    var memoryInfo = await AndroidDeviceInfo().getMemoryInfo();
    print(memoryInfo);

    if (memoryInfo['error'] != null) {
      print(memoryInfo['message']);
    }

    if (!mounted) return;

    setState(() {
      _memoryInfo = memoryInfo;
      //memory initilizer
      totalInternalMemorySize = _memoryInfo['totalInternalMemorySize'] / kGetGB;
      totalExternalMemorySize = _memoryInfo['totalExternalMemorySize'] / kGetGB;
      availableInternalMemorySize =
          _memoryInfo['availableInternalMemorySize'] / kGetGB;
      availableExternalMemorySize =
          _memoryInfo['availableExternalMemorySize'] / kGetGB;
      //percent initializer
      tempCal = (availableInternalMemorySize / totalInternalMemorySize) * 100;
      internaMemoryRatio = tempCal.toInt();
      tempCal = (availableExternalMemorySize / totalExternalMemorySize) * 100;
      externaMemoryRatio = tempCal.toInt();
    });
    print(totalInternalMemorySize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBoxColor,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: kBoxColor,
          elevation: 4),
      body: Container(
        child: _memoryInfo.isEmpty
            ? Center(child: CircularProgressIndicator())
            : buidMemoryInfo(),
      ),
    );
  }

  buidMemoryInfo() {
    return Container(
      color: kBoxColor,
      // padding: EdgeInsets.only(top: 20, left: 20),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: LatoTxt(
                    txt: ' Memory Info',
                    fontFamily: 'Bahnschrift',
                    size: 48,
                    color: Colors.black),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  height: 350,
                  width: 350,
                  child: FlareActing(artBordNO: 2),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    GetMemoryChart(
                        memoryType: 'Internal',
                        totalMemory: totalInternalMemorySize.toInt(),
                        freeMemory: availableInternalMemorySize.toInt(),
                        percent: internaMemoryRatio),
                    SizedBox(height: 20),
                    //if external Avaulable
                    (availableExternalMemorySize != availableInternalMemorySize)
                        ? GetMemoryChart(
                            memoryType: 'External',
                            totalMemory: totalExternalMemorySize.toInt(),
                            freeMemory: availableExternalMemorySize.toInt(),
                            percent: externaMemoryRatio)
                        : SizedBox(
                            height: 10,
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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

class GetMemoryChart extends StatelessWidget {
  final int totalMemory;
  final int freeMemory;
  final int percent;
  final String memoryType;
  GetMemoryChart(
      {@required this.memoryType,
      @required this.totalMemory,
      @required this.freeMemory,
      @required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 40, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LatoTxt(
                    txt: memoryType,
                    fontFamily: 'Bahnschrift',
                    size: 36,
                    color: kBlue),
                Container(
                  height: 6,
                  width: 150,
                  decoration: BoxDecoration(
                      color: kPurple,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                LatoTxt(
                    txt: 'Total',
                    fontFamily: 'Lato-black',
                    size: 24,
                    color: kBlue),
                LatoTxt(
                    txt: '$totalMemory GB',
                    fontFamily: 'Lato-black',
                    size: 24,
                    color: kPurple),
                LatoTxt(
                    txt: 'Free',
                    fontFamily: 'Lato-black',
                    size: 24,
                    color: kBlue),
                LatoTxt(
                    txt: '$freeMemory GB',
                    fontFamily: 'Lato-black',
                    size: 24,
                    color: kPurple),
              ],
            ),
          ),
          Container(
            child: Progress(percent: percent),
          )
        ],
      ),
    );
  }
}

class Progress extends StatelessWidget {
  final int percent;
  Progress({@required this.percent});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 16.0,
        animation: true,
        animationDuration: 500,
        percent: (100 - percent) / 100,
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
