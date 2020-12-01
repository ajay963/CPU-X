import 'package:cpu_x/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class AboutPage extends StatelessWidget {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: LatoTxt(
                    txt: ' About',
                    fontFamily: 'Bahnschrift',
                    size: 48,
                    color: kFontBlack)),
            Expanded(
                flex: 3,
                child: Container(
                  height: 350,
                  width: 350,
                  child: FlareActor("assets/gate.flr",
                      artboard: 'Gate',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: "Untitled"),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LatoTxt(
                          txt: 'verson 1.00.00',
                          fontFamily: 'Lato-Bold',
                          size: 28,
                          color: kFontBlack),
                      SizedBox(height: 10),
                      LatoTxt(
                          txt: 'Platform Used',
                          fontFamily: 'Bahnschrift',
                          size: 36,
                          color: Colors.black),
                      SizedBox(height: 10),
                      LatoTxt(
                          txt: kAbout,
                          fontFamily: 'Lato-Bold',
                          size: 28,
                          color: kFontBlack),
                      SizedBox(height: 10),
                      LatoTxt(
                          txt: 'E-mail: ajay963@outlook.com',
                          fontFamily: 'Lato-Bold',
                          size: 28,
                          color: kBlue)
                    ],
                  ),
                ))
          ],
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
