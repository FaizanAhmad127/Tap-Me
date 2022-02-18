import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vibration/vibration.dart';
import 'game_over.dart';


class TapGame extends StatefulWidget {
  int? score2;
  TapGame({required this.score2});


  @override
  _TapGameState createState() => _TapGameState();
}

class _TapGameState extends State<TapGame> {

  Timer? timer;
  int score=0;
  int seconds=15;
  Color tapColor=Colors.grey.shade300;
  bool isTapped=false;
  bool isClockStarted=true;
  List<int> randomNumbers=[];
  double buttonDepth=10;
  void playLocalAsset() async {
    AudioCache cache = AudioCache();
    await cache.play("sound.wav");
  }
  void vibratePhone()async
  {
    if (await Vibration.hasVibrator()??false) {
      if (await Vibration.hasAmplitudeControl()??false) {
        Vibration.vibrate(amplitude: 128);
      }
      else
        {
          Vibration.vibrate();
        }

    }
  }


  void startTimer() {
    const oneSec =  Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (seconds == 0) {
            timer.cancel();
            vibratePhone();
            Navigator.pushReplacement(context, PageTransition(
                duration: const Duration(milliseconds: 800),
                type: PageTransitionType.rightToLeftWithFade, child: GameOver(score2: score,)));
        } else {
          setState(() {
            seconds--;
          });
        }
      },
    );
  }

  List<int> getRandomNumbers()
  {
    Random random=Random();
    List<int> randomNumbers=[];
    for(int i=0;i<20;i++)
      {
        int n=random.nextInt(i+5)+(i*4);
        n==0?n=1:n=n;
        if(!randomNumbers.contains(n))
          {
            randomNumbers.add(n);
          }

      }
    return randomNumbers;
  }
  @override
  void dispose() {
    try{
      timer!.cancel();
    }
    catch(e)
    {
      print("Null checked");
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    score=widget.score2!;
    randomNumbers=getRandomNumbers();
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
        height: h,
        width: w,
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: h*0.2,
                    height: w*0.1,
                    child: Center(child: Text("Score: $score",style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.5
                    ),)),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(4.0, 4.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                          const BoxShadow(
                              color:  Colors.white,
                              offset: Offset(-4.0, -4.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                        ]),
                  ),
                  Container(
                    width: h*0.2,
                    height: w*0.1,
                    child: Center(child: FittedBox(
                      child: Text("Time: $seconds s",style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5
                      ),),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade500,
                              offset: const Offset(4.0, 4.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                          const BoxShadow(
                              color:  Colors.white,
                              offset: Offset(-4.0, -4.0),
                              blurRadius: 15.0,
                              spreadRadius: 1.0),
                        ]),
                  ),
                ],
              ),
              SizedBox(height: h*0.2,),
              GestureDetector(
                onLongPressStart: (d){
                  setState(() {
                    buttonDepth=0;

                  });
                },
               onLongPressEnd: (d){
                 setState(() {
                   buttonDepth=10;

                 });
               },

                onLongPress:(){

                      score++;
                      setState(() {
                        isTapped=false;
                      });


                },
                onTap: ()
                {
                  playLocalAsset();
                  if(isClockStarted)
                    {
                      startTimer();
                      isClockStarted=false;
                    }
                  if(isTapped)
                    {
                      vibratePhone();
                      Navigator.pushReplacement(context, PageTransition(
                          duration: Duration(milliseconds: 800),
                          type: PageTransitionType.rightToLeftWithFade, child: GameOver(score2: score,)));

                    }
                  if(!isTapped)
                    {
                      setState(() {
                        score++;
                        if(randomNumbers.contains(score))
                        {
                          isTapped=true;
                        }
                      });
                    }

                },
                child:
                Container(
                  width: h*0.4,
                  height: w*0.4,
                  child: Neumorphic(
                    duration: Duration(milliseconds: 200),
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                          depth: buttonDepth,
                          lightSource: LightSource.topLeft,
                        color: isTapped?Colors.red.shade600:tapColor,
                      ),
                      child: Center(child: FittedBox(
                        child: Text("Tap Me",style: TextStyle(
                            color: isTapped?tapColor:Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5
                        ),),
                      )),
                  ),
                ),















                // child: Container(
                //   width: h*0.4,
                //   height: w*0.4,
                //   child:  Center(child: FittedBox(
                //     child: Text("Tap Me",style: TextStyle(
                //       color: isTapped?tapColor:Colors.black,
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       letterSpacing: 1.5
                //     ),),
                //   )),
                //   decoration: BoxDecoration(
                //       color: isTapped?Colors.red.shade600:tapColor,
                //       shape: BoxShape.circle,
                //       boxShadow: [
                //         BoxShadow(
                //            color: Colors.grey.shade500,
                //             offset: const Offset(4.0, 4.0),
                //             blurRadius: 15.0,
                //             spreadRadius: 1.0),
                //          const BoxShadow(
                //             color:  Colors.white,
                //             offset: Offset(-4.0, -4.0),
                //             blurRadius: 15.0,
                //             spreadRadius: 1.0),
                //       ]),
                // ),
              ),
              // SizedBox(height: 0.1*h,),
              // AnimatedContainer(
              //   height: 0.07*h,
              //     width: 0.4*w,
              //     decoration: BoxDecoration(
              //       color: gameOverColor,
              //       borderRadius: BorderRadius.circular(5)
              //     ),
              //     duration: Duration(seconds: 1),
              //     child: Center(
              //       child: FittedBox(
              //         child: Text("Game Over",
              //             style: TextStyle(
              //               color: Colors.grey.shade300,
              //               letterSpacing: 1.5,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w700
              //             ),),
              //       ),
              //     )),
              // SizedBox(height: 0.05*h,),
              // GestureDetector(
              //   onTap:(){
              //     if(isGameOver)
              //       {
              //         setState(() {
              //           isGameOver=false;
              //           score=0;
              //           seconds=15;
              //           isTapped=false;
              //           gameOverColor=Colors.grey.shade300;
              //           playAgainColor=Colors.grey.shade300;
              //           isClockStarted=true;
              //           getRandomNumbers();
              //         });
              //
              //
              //       }
              //   },
              //   child: AnimatedContainer(
              //       height: 0.07*h,
              //       width: 0.4*w,
              //       decoration: BoxDecoration(
              //           color: playAgainColor,
              //           borderRadius: BorderRadius.circular(5)
              //       ),
              //       duration: Duration(seconds: 2),
              //       child: Center(
              //         child: FittedBox(
              //           child: Text("Play Again",
              //             style: TextStyle(
              //                 color: Colors.grey.shade300,
              //                 letterSpacing: 1.5,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w700
              //             ),),
              //         ),
              //       )),
              // ),
            ],
          ),
        ),

      ),
    );
  }
}
