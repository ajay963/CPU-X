import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:cpu_x/components/constants.dart';
import 'battery.dart';
import 'memory.dart';
import 'cpu.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CPUInfo()));
              },
              child: Card(
                  getData: "Device",
                  getAnimationName: 'CPU',
                  getColor: kCpuRed)),
          SizedBox(
            height: kBoxSpacing,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BatteryInfo()));
            },
            child: Card(
                getData: "Battery",
                getAnimationName: 'Battery',
                getColor: kDarkGreen),
          ),
          SizedBox(
            height: kBoxSpacing,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MemoryInfo()));
              },
              child: Card(
                  getData: "Memory", getAnimationName: 'RAM', getColor: kBlue))
        ],
      ),
    );
  }
}

class Card extends StatefulWidget {
  final String getData;

  final Color getColor;
  final String getAnimationName;
  // final String kText = "";
  Card(
      {@required this.getData,
      @required this.getAnimationName,
      @required this.getColor});

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: kBoxColor,
            boxShadow: [
              BoxShadow(
                color: kBoxWhiteShadow,
                offset: Offset(-3, -3),
                blurRadius: 6,
              ),
              BoxShadow(
                color: kBoxBlackShadow,
                offset: Offset(3, 3),
                blurRadius: 6,
              )
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                height: 140,
                width: 140,
                child: FlareActor(
                  'assets/cpu.flr',
                  sizeFromArtboard: false,
                  artboard: widget.getAnimationName,
                  fit: BoxFit.contain,
                  animation: 'Untitled',
                ),
              ),
            ),
            Expanded(
                child: TxtStack(
                    getData: widget.getData, getColor: widget.getColor))
          ],
        ));
  }
}

class TxtStack extends StatelessWidget {
  final String getData;
  final Color getColor;
  TxtStack({@required this.getData, @required this.getColor});
  final String boxInfo = kCardInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: EdgeInsets.only(bottom: 10, top: 10),
            color: getColor,
            child: Text(
              getData,
              style: TextStyle(
                fontFamily: 'Bahnschrift',
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: kBoxColor,
              ),
            ),
          ),
          Container(
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: boxInfo,
                    style: TextStyle(
                        color: kFontBlack,
                        fontSize: 18,
                        fontFamily: 'Lato-Bold',
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: getData,
                    style: TextStyle(
                        fontSize: 18,
                        color: getColor,
                        fontFamily: 'Lato-Black',
                        fontWeight: FontWeight.bold))
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class FlareActing extends StatefulWidget {
  final int artBoardNO;
  FlareActing({@required this.artBoardNO});

  @override
  _FlareActingState createState() => _FlareActingState();
}

class _FlareActingState extends State<FlareActing> {
  String animationName;

  @override
  void initState() {
    super.initState();
    animationPutter();
  }

  void animationPutter() {
    setState(() {
      if (widget.artBoardNO == 1)
        animationName = "CPU";
      else if (widget.artBoardNO == 2)
        animationName = "RAM";
      else
        animationName = "Battery";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlareActor(
        'assets/cpu.flr',
        artboard: animationName,
        fit: BoxFit.fitWidth,
        animation: 'Untitled',
      ),
    );
  }
}
