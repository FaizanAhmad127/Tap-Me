import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tap_game/tap_game.dart';



class GameStart extends StatefulWidget {
  const GameStart({Key? key}) : super(key: key);

  @override
  _GameStartState createState() => _GameStartState();
}

class _GameStartState extends State<GameStart> {
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.grey[800],
        title: const Center(
          child: Text("The Tap Game"),
        ),
      ),
      body: Container(
        height:   h,
    width: w,
    padding: EdgeInsets.only(top: 0.15*h),
    color: Colors.grey[300],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                ElasticInUp(child: Welcome(h: h,w: w,letter: "W",) ),
                ElasticInDown(child: Welcome(h: h,w: w,letter: "E",) ),
                ElasticInUp(child: Welcome(h: h,w: w,letter: "L") ),
                ElasticInDown(child: Welcome(h: h,w: w,letter: "C",) ),
                ElasticInUp(child: Welcome(h: h,w: w,letter: "O",) ),
                ElasticInDown(child: Welcome(h: h,w: w,letter: "M",) ),
                ElasticInUp(child: Welcome(h: h,w: w,letter: "E",) ),

              ],
            ),

        Container(
        height: 0.07*h,
        width: 0.4*w,
        child: NeumorphicButton(
          onPressed: ()
          {
            Navigator.pushReplacement(context, PageTransition(
              duration: Duration(milliseconds: 800),
            type: PageTransitionType.rightToLeftWithFade, child: TapGame(score2: 0,)));
          },
          style: NeumorphicStyle(
            shape: NeumorphicShape.convex,
            depth: 5,
            color: Colors.black,
            shadowDarkColor: Colors.grey.shade700,
          ),
          child: Center(
            child: FittedBox(
              child: Text("Start",
                style: TextStyle(
                    color: Colors.grey.shade300,
                    letterSpacing: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),),
            ),
          ),
        ),
      )
          ],
        ),
    ));
  }
}
class Welcome extends StatelessWidget {
  Welcome({Key? key,required this.h,required this.w,required this.letter}) : super(key: key);
  String letter;
  double h,w;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.01*w,
      height: 0.5*h,
      child: Text(
        letter,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}