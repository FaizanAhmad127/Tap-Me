import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tap_game/game_start.dart';
import 'package:tap_game/tap_game.dart';

class GameOver extends StatefulWidget {
  int score2;
  GameOver({required this.score2});

  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {

  int score=0;
  double opacity=0;
  double mainMenuOpacity=0;
  double gameOverOpacity=0;
  bool canPressNow=false;
  @override
  void initState() {
    super.initState();
    score=widget.score2;

      Future.delayed(Duration(seconds: 1)).then((value) {
        setState(() {
          opacity=1;
          mainMenuOpacity=1;
          gameOverOpacity=1;
        });
      });
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        canPressNow=true;
      });
    });

  }


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
        padding: EdgeInsets.only(top: 0.1*h),
        color: Colors.grey[300],
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: opacity,
                child: NeumorphicText(
                    "GAME OVER",
                    style: NeumorphicStyle(
                        shadowLightColor: Colors.red,
                        shadowDarkColor: Colors.blue,
                        color: Colors.grey.shade800,
                        depth: 10,
                        border: NeumorphicBorder(
                            color: Colors.red,
                            width: 0.9
                        )
                    ),
                    textStyle: NeumorphicTextStyle(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,

                    )
                ),
              ),
              SizedBox(
                height: 0.07*h,
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 1500),
                opacity: opacity,
                child: NeumorphicText(
                    "You Scored: $score",
                    style: NeumorphicStyle(

                        color: Colors.grey.shade800,
                        depth: 10,
                        border: NeumorphicBorder(
                            color: Colors.green,
                            width: 0.2
                        )
                    ),
                    textStyle: NeumorphicTextStyle(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,

                    )
                ),
              ),
              SizedBox(
                height: 0.1*h,
              ),
              AnimatedOpacity(
                  opacity: mainMenuOpacity,
                  duration: Duration(milliseconds: 2000),
                  child: CustomButton(h: h, w: w,text: "Play Again",buttonColor: Colors.green,
                    score: score,
                    canPressNow: canPressNow,),
              ),
              SizedBox(height: 0.05*h,),
              AnimatedOpacity(
                opacity: mainMenuOpacity,
                duration: Duration(milliseconds: 2500),
                child: CustomButton(h: h, w: w,text: "Main Menu",buttonColor: Colors.blue.shade500,
                  score: score,
                canPressNow: canPressNow,),
              ),
            ],
          )
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
   CustomButton({
    Key? key,
    required this.h,
    required this.w,
    required this.text,
     required this.buttonColor,
     required this.score,
     required this.canPressNow

  }) : super(key: key);

  final double h;
  final double w;
  String text;
  Color buttonColor;
  int score;
  bool canPressNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.07*h,
      width: 0.4*w,
      child: NeumorphicButton(
        onPressed: ()
        {
          if(canPressNow==true)
            {
              if(text=="Main Menu")
              {
                Navigator.pushReplacement(context, PageTransition(
                    duration: Duration(milliseconds: 800),
                    type: PageTransitionType.rightToLeftWithFade, child: GameStart()));
              }
              else if(text=="Play Again")
              {
                Navigator.pushReplacement(context, PageTransition(
                    duration: Duration(milliseconds: 800),
                    type: PageTransitionType.rightToLeftWithFade, child: TapGame(score2: score,)));
              }
            }

        },
        style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          depth: 5,
          color: buttonColor,
            shadowDarkColor: buttonColor,
        ),
        child: Center(
          child: FittedBox(
            child: Text(text,
              style: TextStyle(
                  color: Colors.grey.shade300,
                  letterSpacing: 1.5,
                  fontSize: 16,
                  fontWeight: FontWeight.w700
              ),),
          ),
        ),
      ),
    );
  }
}
