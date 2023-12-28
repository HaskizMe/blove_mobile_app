import 'dart:async';
import 'dart:io';
import 'package:b_love_bear/custom_widgets/custom_confetti.dart';
import 'package:b_love_bear/custom_widgets/ios_style_action_menu.dart';
import 'package:b_love_bear/global_variables/screen_size_values.dart';
import 'package:b_love_bear/screens/accounts_screen.dart';
import 'package:b_love_bear/screens/bear_screen.dart';
import 'package:b_love_bear/screens/sent_messages_screen.dart';
import 'package:b_love_bear/screens/settings_screen.dart';
import 'package:b_love_bear/screens/setup_bear_screen.dart';
import 'package:b_love_bear/screens/show_steps_screen.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors/app_colors.dart';
import '../helper_files/audio_recording_helper.dart';
import '../helper_files/data_managment.dart';
import '../helper_files/navigation_helper.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:async/async.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late ConfettiController confettiController;
  bool showNavigationMenu = false;
  bool showStop = false;
  bool showRecording = true;
  bool showSend = false;
  late AudioPlayer audioPlayer;
  late AudioRecorder audioRecord;
  String? audioPath = '';
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



  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioRecord = AudioRecorder();
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
    audioRecord.dispose();
    audioPlayer.dispose();
    confettiController.dispose();
    timer?.cancel();
    super.dispose();
  }

  Future<void> recordButtonPressed() async {
    confettiController.play();
    try {
      await startRecording(audioPlayer, audioRecord);
      setState(() {
        showRecording = !showRecording;
        showStop = !showStop;
      });
    } catch(e){
      print("Error with start recording");
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        audioPath = path!;
        showStop = !showStop;
        showSend = !showSend;
      });
      print('audio path $audioPath');

    } catch (e) {
      print("Error with stop recording");
    }
  }

  Future<void> playRecording() async {

    try{
      Source urlSource =  UrlSource(audioPath!);
      await audioPlayer.play(urlSource);
    } catch(e) {
      print("Error with play recording");
    }
  }

  void reset() {
    try {
      File(audioPath!).delete();
    } catch (e) {
      print('Error deleting file: $e');
    }
    setState(() {
      showStop = false;
      showRecording = true;
      showSend = false;
    });
  }
  void sendMessage(){
    try {
      File(audioPath!).delete();
    } catch (e) {
      print('Error deleting file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!bears.any((bear) => bear.isSelected)){
      bears[0].isSelected = true;
    }
    if(ScreenSize.screenHeight < 800){
      topMenuPadding = 20.0;
    } else {
      topMenuPadding = 45.0;
    }

    if(ScreenSize.screenWidth < 490){
      textSize = 18;
    } else if(ScreenSize.screenWidth >= 800) {
      textSize = 30;
      iconSize = 70;
    } else{
      textSize = 28;
      iconSize = 30;
    }

    String bear = bears[bears.indexWhere((bear) => bear.isSelected)].name;
    return Scaffold(
      backgroundColor: AppColors.bLOVEBackground,
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CustomConfetti(controller: confettiController,)
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                // color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15.0, topMenuPadding, 0.0, 0.0),
                  child: MenuNavigation(
                    rebuildRecordPage: () {
                      setState(() {

                      });
                    }, recordPageContext: context,
                    iconSize: iconSize,
                  ),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const SizedBox(height: 60,),


                    Visibility(
                        visible: showSend,
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
                        visible: !showSend,
                        child: Container(
                          // color: Colors.blue,
                          child: Column(
                            children: [
                              // const SizedBox(height: 30,),

                              Text('STEP ONE:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: textSize),),
                              const SizedBox(height: 5,),
                              Text('PRESS THE RED ICON TO RECORD YOUR', style: TextStyle(fontSize: textSize),),
                              Text('bLOVE MESSAGE.', style: TextStyle(fontSize: textSize),),
                            ],
                          ),
                        )
                    ),
                    const SizedBox(height: 10,),
                    Visibility(
                      visible: showRecording,
                      child: IconButton(
                        icon: SvgPicture.asset('assets/RecordButtonBig.svg', width: 150, height: 150,),
                        padding: EdgeInsets.zero,
                        onPressed: isPlaying ? null : recordButtonPressed,
                      ),
                    ),
                    Visibility(
                      visible: showStop,
                      child: IconButton(
                          icon: SvgPicture.asset('assets/StopButtonBig.svg', width: 150, height: 150,),
                          padding: EdgeInsets.zero,
                          onPressed: stopRecording
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
                            onPressed: playRecording,
                            child: const Text('Play Recording', style: TextStyle(color: AppColors.heartRed, fontSize: 20),),
                          ),
                          TextButton(
                            onPressed: reset,
                            child: const Text('Reset', style: TextStyle(color: AppColors.heartRed),),
                          ),
                        ],
                      ),
                    const SizedBox(height: 30,),
                    Text(bear, style: TextStyle(fontSize: textSize),),
                    const SizedBox(height: 10,),
                    SvgPicture.asset(currentBearImage, width: ScreenSize.screenWidth * .6, height: ScreenSize.screenHeight * .35,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuNavigation extends StatefulWidget {
  final BuildContext recordPageContext;
  final VoidCallback rebuildRecordPage; // Callback to trigger a rebuild
  final double iconSize;
  const MenuNavigation({
    super.key,
    required this.recordPageContext,
    required this.rebuildRecordPage,
    required this.iconSize
  });

  @override
  State<MenuNavigation> createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  @override
  Widget build(BuildContext context) {
    handleLogOut() {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
          context: widget.recordPageContext,
          builder: (BuildContext context) {
            return const CustomActionSheet();
          }
      );
    }

    return PopupMenuButton<String>(
      icon: Icon(Icons.menu, size: widget.iconSize,),
      onSelected: (value) {
        // Handle menu item selection
        if (value == 'sentMessages') {
          handleNavigation(const SentMessages(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'bears') {
          handleNavigation(const Bears(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'showSteps'){
          handleNavigation(const ShowSteps(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'setupBear'){
          handleNavigation(const SetupBear(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'accounts'){
          handleNavigation(const Accounts(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'settings'){
          handleNavigation(const Settings(), widget.recordPageContext, widget.rebuildRecordPage,);
        } else if (value == 'logout'){
          handleLogOut();
        } else {
          print("Pop up Menu doesn't contain that string name");
        }
        // Add more conditions for other menu items
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<String>(
          value: 'sentMessages',
          child: ListTile(
            leading: Icon(Icons.mail),
            title: Text('Sent Messages'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'bears',
          child: ListTile(
            leading: Icon(Icons.pets),
            title: Text('Bears'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'showSteps',
          child: ListTile(
            leading: Icon(Icons.assignment_rounded),
            title: Text('Show Steps'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'setupBear',
          child: ListTile(
            leading: Icon(Icons.cached),
            title: Text('Setup Bear'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'accounts',
          child: ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Accounts'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'settings',
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout', style: TextStyle(color: AppColors.heartRed),),
          ),
        ),
        // Add more menu items as needed
      ],
    );
  }
}
