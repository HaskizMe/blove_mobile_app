import 'dart:io';

import 'package:b_love_bear/custom_widgets/custom_tile.dart';
import 'package:b_love_bear/screens/accounts_screen.dart';
import 'package:b_love_bear/screens/bear_screen.dart';
import 'package:b_love_bear/screens/sent_messages_screen.dart';
import 'package:b_love_bear/screens/settings_screen.dart';
import 'package:b_love_bear/screens/show_steps_screen.dart';
import 'package:b_love_bear/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../colors/app_colors.dart';
import '../helper_files/audio_recording_helper.dart';
import '../helper_files/navigation_helper.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  bool showNavigationMenu = false;
  bool showStop = false;
  bool showRecording = true;
  bool showSend = false;
  late AudioPlayer audioPlayer;
  late AudioRecorder audioRecord;
  String? audioPath = '';
  bool isRecording = false;


  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioRecord = AudioRecorder();
    super.initState();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> recordButtonPressed() async {
    try {
      startRecording(audioPlayer, audioRecord);
      setState(() {
        showRecording = !showRecording;
        showStop = !showStop;
      });
    }
    catch(e){
      print("Error with start recording");
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        //isRecording = false;
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
    }
    catch(e) {
      print("Error with play recording");
    }
  }

  void reset() {
    print("$audioPath");
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
    String bear = "Kris's bear";

    return GestureDetector(
      onTap: () {
        if (showNavigationMenu) {
          setState(() {
            showNavigationMenu = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.bLOVEBackground,
        appBar: AppBar(
          backgroundColor: AppColors.bLOVEBackground,
          leading: TextButton(
            onPressed: () {
              setState(() {
                showNavigationMenu = !showNavigationMenu;
              });
            },
            child: Icon(
              Icons.menu,
              color: showNavigationMenu ? Colors.grey : Colors.black,
            ),
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: showSend,
                        child: const Column(
                          children: [
                            Text('STEP TWO:', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text("PRESS 'SEND' WHEN YOU'RE HAPPY"),
                            Text("WITH YOUR bLOVE MESSAGE AND ARE"),
                            Text("READY TO SEND IT TO YOUR bLOVE"),
                            Text("BEAR."),
                            //SizedBox(height: 40,),
                          ],
                        )
                    ),
                    Visibility(
                        visible: !showSend,
                        child: const Column(
                          children: [
                            Text('STEP ONE:', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text('PRESS THE RED ICON TO RECORD YOUR'),
                            Text('bLOVE MESSAGE.'),
                            //SizedBox(height: 40,),
                          ],
                        )
                    ),
                    const SizedBox(height: 40,),
                    Visibility(
                      visible: showRecording,
                      child: IconButton(
                        icon: SvgPicture.asset('assets/RecordButtonBig.svg', width: 150, height: 150,),
                        padding: EdgeInsets.zero,
                      // ),                        //
                      onPressed: recordButtonPressed,
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
                            child: Text('Play Recording', style: TextStyle(color: AppColors.heartRed, fontSize: 20),),
                          ),
                          TextButton(
                            onPressed: reset,
                            child: Text('Reset', style: TextStyle(color: AppColors.heartRed),),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20,),
                    Text(bear, style: const TextStyle(fontSize: 20),),
                    const SizedBox(height: 10,),
                    SvgPicture.asset('assets/bLOVEbEARFrontBig.svg', width: 250, height: 250,),
                  ],
                ),
              ),
            ),
            if (showNavigationMenu)
              Positioned(
                top: 10.0,
                left: 10.0,
                child: Visibility(
                  visible: showNavigationMenu,
                  child: MenuNavigation(recordPageContext: context),
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
  const MenuNavigation({super.key, required this.recordPageContext});

  @override
  State<MenuNavigation> createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  @override
  Widget build(BuildContext context) {
    handleLogOut() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: 200,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTile(
                title: 'Sent Messages',
                bottomBorder: true,
                onTapCallback: () => handleNavigation(
                    const SentMessages(), widget.recordPageContext)),
            CustomTile(
                title: 'Bears',
                bottomBorder: true,
                onTapCallback: () =>
                    handleNavigation(const Bears(), widget.recordPageContext)),
            CustomTile(
                title: 'Show Steps',
                bottomBorder: true,
                onTapCallback: () => handleNavigation(
                    const ShowSteps(), widget.recordPageContext)),
            CustomTile(
                title: 'Accounts',
                bottomBorder: true,
                onTapCallback: () => handleNavigation(
                    const Accounts(), widget.recordPageContext)),
            CustomTile(
                title: 'Settings',
                bottomBorder: true,
                onTapCallback: () => handleNavigation(
                    const Settings(), widget.recordPageContext)),
            CustomTile(
                title: 'Log Out',
                bottomBorder: false,
                fontColor: AppColors.heartRed,
                onTapCallback: () => handleLogOut()),
          ],
        ),
      ),
    );
  }
}
