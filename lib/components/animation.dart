import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class FlareActing extends StatefulWidget {
  FlareActing({@required this.artBordNO});
  final int artBordNO;

  @override
  _FlareActingState createState() => _FlareActingState();
}

class _FlareActingState extends State<FlareActing> {
  @override
  void initState() {
    super.initState();
    animationPutter();
  }

  int artNO = 1;
  String animationName;
  void animationPutter() {
    setState(() {
      if (widget.artBordNO == 1)
        animationName = "CPU";
      else if (widget.artBordNO == 2)
        animationName = "RAM";
      else
        animationName = "Battery";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlareActor("assets/cpu.flr",
        artboard: "$animationName",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "Untitled");
  }
}
