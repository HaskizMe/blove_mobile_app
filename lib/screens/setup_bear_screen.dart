import 'package:b_love_bear/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../colors/app_colors.dart';
import '../global_variables/screen_size_values.dart';

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
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      child: Scaffold(
        backgroundColor: AppColors.bLOVEBackground,
        body: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
          child: Center(
            child: showInstructionLayout
                ? InstructionsLayout(onSwitchLayout: () {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("CONNECT YOU bLOVE bEAR TO THE"),
        const Text("CHARGER WITH INCLUDED USB CABLE."),
        const SizedBox(height: 10,),
        SvgPicture.asset("assets/bLOVEbEARBehindBig.svg", width: 300, height: 300,),
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
  bool isScanning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bLOVEBackground,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(isScanning ? "SEARCHING FOR YOUR bLOVE bEAR..." :"SCAN TO FIND bLOVE bEAR"),
              const SizedBox(height: 30,),
              GetBuilder<BluetoothController>(
                init: BluetoothController(),
                builder: (controller) {
                  return Column(
                    children: [
                      isScanning
                          ? const SizedBox(width: 30, height: 30, child: CircularProgressIndicator(),)
                          : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isScanning = true;
                          });
                          // isScanning = true;
                          controller.scanDevices();
                          await Future.delayed(const Duration(seconds: 5));
                          setState(() {
                            isScanning = false;
                          });
                          print("done");
                        },
                        child: const Text("scan"),
                      ),
                      const SizedBox(height: 20,),
                      SingleChildScrollView(
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: StreamBuilder<List<ScanResult>>(
                            stream: controller.scanResults,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final data = snapshot.data![index];
                                    if (data.advertisementData.advName == "PainDrain") {
                                      print("Name exists");
                                      return Card(
                                        child: ListTile(
                                          title: Text(data.advertisementData.advName),
                                          subtitle: Text(data.device.remoteId.toString()),
                                          trailing: Text(data.rssi.toString()),
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                );
                              } else {
                                return const Center(child: Text("No Devices Found"),);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30,),
              SvgPicture.asset("assets/bLOVEbEARFrontBig.svg", width: 250, height: 250,),
              const SizedBox(height: 20,),
              const Text("CLICK ON THE bEAR."),
              const Text("WHEN YOUR bLOVE bEAR"),
              const Text("IS CONNECTED"),
              const Text("THE HEART WILL FLASH."),
            ],
          ),
        ),
      ),
    );
  }
}



