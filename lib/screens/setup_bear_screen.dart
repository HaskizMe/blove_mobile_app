import 'package:b_love_bear/controllers/bluetooth_controller.dart';
import 'package:b_love_bear/custom_widgets/custom_button.dart';
import 'package:b_love_bear/custom_widgets/custom_loader.dart';
import 'package:b_love_bear/global_variables/screen_size_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../colors/app_colors.dart';
import 'package:flutter/cupertino.dart';

class SetupBear extends StatefulWidget {
  const SetupBear({super.key});

  @override
  State<SetupBear> createState() => _SetupBearState();
}

class _SetupBearState extends State<SetupBear> {
  bool showInstructionLayout = true;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
      child: Scaffold(
        backgroundColor: AppColors.bLOVEBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
          child: Center(
            child: showInstructionLayout
                ? InstructionsLayout(
              onSwitchLayout: () {
                setState(() {
                  showInstructionLayout = !showInstructionLayout;
                });
                },
            )
                : BluetoothConnect(onSwitchLayout: () {
              setState(() {
                showInstructionLayout = !showInstructionLayout;
              });
            },),
          )
        ),
      ),
    );
  }
}

class InstructionsLayout extends StatelessWidget {
  final VoidCallback onSwitchLayout;
  const InstructionsLayout({super.key, required this.onSwitchLayout});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("CONNECT YOU bLOVE bEAR TO THE"),
          const Text("CHARGER WITH INCLUDED USB CABLE."),
          const SizedBox(height: 10,),
          SvgPicture.asset("assets/bLOVEbEARBehindBig.svg", width: ScreenSize.screenWidth * .6, height: ScreenSize.screenHeight * .3,),
          const SizedBox(height: 20,),
          const Text("BEFORE YOU BEGIN SET UP, BE SURE"),
          const Text("BLUETOOTH IS ENABLED ON YOUR PHONE."),
          const SizedBox(height: 40,),
          IconButton(
            icon: SvgPicture.asset('assets/HeartNextButtonBig.svg', width: 150, height: 150,),
            padding: EdgeInsets.zero,
            onPressed: onSwitchLayout,
          ),
        ],
      ),
    );
  }
}

class BluetoothConnect extends StatefulWidget {
  final VoidCallback onSwitchLayout;

  const BluetoothConnect({super.key, required this.onSwitchLayout});

  @override
  State<BluetoothConnect> createState() => _BluetoothConnectState();
}

class _BluetoothConnectState extends State<BluetoothConnect> {
  bool isDeviceFound = false;
  bool isScanningWifi = false;
  bool isConnecting = false;
  String deviceName = "bLove";
  BluetoothDevice? myDevice;
  final controller = BluetoothController();

  @override
  void initState() {
    super.initState();
    // Start scanning for devices when the widget is initialized
    controller.scanDevices();

    // Listen to the scanResults stream and update the state accordingly
    controller.scanResults.listen((List<ScanResult> scanResults) {
      final bloveDevices = scanResults
          .where((data) => data.advertisementData.advName == "bLove")
          .toList();

      if(mounted) {
        setState(() {
          isDeviceFound = bloveDevices.isNotEmpty;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.bLOVEBackground,
          // This is the top of the main widget that displays the back button
          appBar: AppBar(
            leadingWidth: 100,
            leading: TextButton(
              onPressed: widget.onSwitchLayout,
              child: const Row(
                children: [
                  Icon(Icons.arrow_back_ios_new, color: AppColors.heartRed),
                  SizedBox(width: 2.0),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.heartRed,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: AppColors.bLOVEBackground,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Switches text based on if the button is scanning for devices or not
                    Text(
                      isDeviceFound
                        ? "YOUR bLOVE bEAR HAS BEEN FOUND!"
                        : "SEARCHING FOR YOUR bLOVE BEAR...",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10,),
                    GetBuilder<BluetoothController>(
                      init: BluetoothController(),
                      builder: (controller) {
                        return Column(
                          children: [
                            StreamBuilder<List<ScanResult>>(
                              stream: controller.scanResults,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  // Show all devices with the name "bLove"
                                  final bloveDevices = snapshot.data!
                                      .where((data) => data.advertisementData.advName == "bLove")
                                      .toList();
                                  // final bloveDevices = snapshot.data!;
                                  return Container(
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: CupertinoPicker(
                                      itemExtent: 30, // Set the item height
                                      onSelectedItemChanged: (int index) {
                                        // This is the selected item in the picker
                                        print("Blove device ${bloveDevices[index].advertisementData.advName}");
                                        myDevice = bloveDevices[index].device;
                                      },
                                      children: List<Widget>.generate(
                                        bloveDevices.length,
                                            (int index) {
                                          final data = bloveDevices[index];
                                          myDevice = bloveDevices[index].device;
                                          return Center(
                                            child: Text(data.advertisementData.advName),
                                          );
                                        },
                                      ),
                                    )
                                  );
                                } else {
                                  // Handle loading state or error state
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 30,),
                    SvgPicture.asset("assets/bLOVEbEARFrontBig.svg", width: ScreenSize.screenWidth * .6, height: ScreenSize.screenHeight * .3,),
                    const SizedBox(height: 20,),
                    const Text("CLICK ON THE bEAR.", style: TextStyle(fontSize: 18),),
                    const Text("WHEN YOUR bLOVE bEAR", style: TextStyle(fontSize: 18),),
                    const Text("IS CONNECTED", style: TextStyle(fontSize: 18),),
                    const Text("THE HEART WILL FLASH.", style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 20,),
                    IconButton(
                      icon: SvgPicture.asset('assets/HeartNextButtonBig.svg', width: 120, height: 120,),
                      padding: EdgeInsets.zero,
                      // Waiting to add functionality
                      onPressed: () async {
                        if(myDevice != null){
                          setState(() {
                            isConnecting = true;
                          });
                          if(await controller.connectDevice(myDevice!)) {
                            await controller.writeToDevice(myDevice!);
                            setState(() {
                              isScanningWifi = true;
                            });
                          }
                          setState(() {
                            isConnecting = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Visibility(
        //   visible: isConnecting,
        //   child: const Align(
        //     alignment: Alignment.center,
        //     child: CustomLoader(text: 'ATTEMPTING\n BLUETOOTH\nCONNECTION',),
        //   ),
        // ),
        Visibility(
          visible: isScanningWifi,
          child: const Align(
            alignment: Alignment.center,
            child: CustomLoader(text: 'RETRIEVING WIFI\n  INFORMATION',),
          ),
        ),

      ],
    );
  }
}



