import 'dart:async';
import 'package:b_love_bear/custom_widgets/custom_confetti.dart';
import 'package:b_love_bear/global_variables/screen_size_values.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors/app_colors.dart';
import '../custom_widgets/menu_navigation.dart';
import '../helper_files/audio_recording_helper.dart';
import '../helper_files/data_managment.dart';


class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late ConfettiController confettiController;
  bool showInstructions = true;
  bool showNavigationMenu = false;
  bool showStop = false;
  bool showRecording = true;
  bool showSend = false;
  bool isRecording = false;
  late double topMenuPadding;
  late double screenWidth;
  double textSize = 18;
  Timer? timer;
  bool isPlaying = false;
  double iconSize = 18;
  String currentBearImage = 'assets/bLOVEbEARFrontBig.svg';
  final String bearWithoutGlowingHeart = 'assets/bLOVEbEARFrontBig.svg';
  final String bearWithGlowingHeart = 'assets/bLOVEbEARWithGlowingHeartBig.svg';
  late AudioRecorderManager audioManager; // Create an instance of AudioRecorderManager



  @override
  void initState() {
    audioManager = AudioRecorderManager(); // Initialize AudioRecorderManager
    confettiController = ConfettiController(duration: const Duration(milliseconds: 2500));
    confettiController.addListener(() {
      setState(() {
        isPlaying = confettiController.state == ConfettiControllerState.playing;
        if(isPlaying){
          timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
            setState(() {
              currentBearImage = (currentBearImage == bearWithoutGlowingHeart)
                  ? bearWithGlowingHeart
                  : bearWithoutGlowingHeart;
            });
          });
        }
        else if (!isPlaying) {
          timer?.cancel(); // Stop the timer when the animation is completed
          currentBearImage = bearWithoutGlowingHeart; // Set image to bearWithoutGlowingHeart
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    audioManager.dispose();
    confettiController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!bears.any((bear) => bear.isSelected)){
      bears[0].isSelected = true;
    }
    // if(ScreenSize.screenHeight < 800){
    //   topMenuPadding = 20.0;
    // } else {
    //   topMenuPadding = 45.0;
    // }
    //
    // if(ScreenSize.screenWidth < 490){
    //   textSize = 18;
    // } else if(ScreenSize.screenWidth >= 800) {
    //   textSize = 30;
    //   iconSize = 70;
    // } else{
    //   textSize = 28;
    //   iconSize = 30;
    // }

    String bear = bears[bears.indexWhere((bear) => bear.isSelected)].name;
    return
      Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.bLOVEBackground,
            appBar: AppBar(
              backgroundColor: AppColors.bLOVEBackground,
              leading: MenuNavigation(
                rebuildRecordPage: () {
                  setState(() {});
                  }, recordPageContext: context,
                iconSize: 26,
              ),
              actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.info_outline,
                    color: AppColors.heartRed,),
                  iconSize: 26,
                  onPressed: () {
                    setState(() {
                      showInstructions = !showInstructions;
                    });
                  },
                ),
              ),
              ],

            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: showSend && showInstructions,
                        child: Column(
                          children: [
                            // const SizedBox(height: 10,),
                            Text('STEP TWO:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize),),
                            const SizedBox(height: 5,),
                            Text("PRESS 'SEND' WHEN YOU'RE HAPPY", style: TextStyle(fontSize: textSize),),
                            Text("WITH YOUR bLOVE MESSAGE AND ARE", style: TextStyle(fontSize: textSize),),
                            Text("READY TO SEND IT TO YOUR bLOVE", style: TextStyle(fontSize: textSize),),
                            Text("BEAR.", style: TextStyle(fontSize: textSize),),
                          ],
                        )
                    ),

                    Visibility(
                        visible: !showSend && showInstructions,
                        child: Column(
                          children: [
                            Text('STEP ONE:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize),),
                            const SizedBox(height: 5,),
                            Text('PRESS THE RED ICON TO RECORD YOUR', style: TextStyle(fontSize: textSize),),
                            Text('bLOVE MESSAGE.', style: TextStyle(fontSize: textSize),),
                          ],
                        )
                    ),
                    const SizedBox(height: 10,),
                    Visibility(
                      visible: showRecording,
                      child: IconButton(
                        icon: SvgPicture.asset('assets/RecordButtonBig.svg', width: 150, height: 150,),
                        padding: EdgeInsets.zero,
                        onPressed: isPlaying ? null : () {
                          audioManager.startRecording();
                          setState(() {
                            showRecording = !showRecording;
                            showStop = !showStop;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: showStop,
                      child: IconButton(
                          icon: SvgPicture.asset('assets/StopButtonBig.svg', width: 150, height: 150,),
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            String? audioPath = await audioManager.stopRecording();
                            setState(() {
                              audioPath = audioPath!;
                              showStop = !showStop;
                              showSend = !showSend;
                            });
                          }
                      ),
                    ),
                    Visibility(
                      visible: showSend,
                      child: IconButton(
                        icon: SvgPicture.asset('assets/HeartSubmitButtonBig.svg' , width: 150, height: 150,),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          confettiController.play();
                          setState(() {
                            showSend = !showSend;
                            showRecording = !showRecording;
                          });
                        },
                      ),
                    ),
                    if(showSend)
                      Column(
                        children: [
                          TextButton(
                            onPressed: () { audioManager.playRecording(); },
                            child: const Text('Play Recording', style: TextStyle(color: AppColors.heartRed, fontSize: 20),),
                          ),
                          TextButton(
                            onPressed: () {
                              audioManager.reset();
                              setState(() {
                                showStop = false;
                                showRecording = true;
                                showSend = false;
                              });
                            },
                            child: const Text('Reset', style: TextStyle(color: AppColors.heartRed),),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10,),
                    Text(bear, style: TextStyle(fontSize: textSize),),
                    const SizedBox(height: 10,),
                    SvgPicture.asset(currentBearImage, width: ScreenSize.screenWidth * .6, height: ScreenSize.screenHeight * .3,),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CustomConfetti(controller: confettiController,),
          ),
        ],
      );
  }
}
