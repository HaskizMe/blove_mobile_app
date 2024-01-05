import 'package:b_love_bear/controllers/bluetooth_controller.dart';
import 'package:b_love_bear/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../colors/app_colors.dart';

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
  bool isConnected = false;
  String deviceName = "bLove";

  void onButtonPressed(BluetoothController controller) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text(isScanning
                    ? "SEARCHING FOR YOUR bLOVE bEAR..."
                    :"SCAN TO FIND bLOVE bEAR!",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10,),
                GetBuilder<BluetoothController>(
                  init: BluetoothController(),
                  builder: (controller) {
                    return Column(
                      children: [
                        isScanning
                            ? const SizedBox(width: 30, height: 30, child: CircularProgressIndicator(color: AppColors.heartRed,),)
                            : CustomButton(
                            width: 200,
                            handleButton: () => onButtonPressed(controller),
                            buttonColor: AppColors.heartRed,
                            textColor: Colors.white,
                            height: 40,
                            borderRadius: 10.0,
                            buttonName: 'Scan',
                            borderColor: AppColors.heartRed,
                            fontSize: 18,
                        ),
                        const SizedBox(height: 20,),
                        SingleChildScrollView(
                          // Container to hold all the devices. Is Scrollable too
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: StreamBuilder<List<ScanResult>>(
                              stream: controller.scanResults,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  // This just contains a list of all the bLove Devices that it can connect to
                                  final bloveDevices = snapshot.data!
                                      .where((data) => data.advertisementData.advName == deviceName)
                                      .toList();
                                  if (bloveDevices.isNotEmpty) {
                                    return ListView.builder(
                                      itemCount: bloveDevices.length,
                                      itemBuilder: (context, index) {
                                        final data = bloveDevices[index];
                                        print("Name exists");
                                        return Card(
                                          child: ListTile(
                                            title: Text(data.advertisementData.advName),
                                            subtitle: Text(data.device.remoteId.toString()),
                                            trailing: isConnected ? const Icon(Icons.bluetooth_connected_rounded, color: Colors.blue,) : const Icon(Icons.bluetooth_connected_rounded),
                                            onTap: () {
                                              setState(() {
                                                isConnected = !isConnected;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    // Display container when no bLove Devices are found
                                    return Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(.1),
                                                  borderRadius: BorderRadius.circular(10.0)
                                              ),
                                            )
                                        )
                                    );
                                  }
                                } else {
                                  return const Center(child: Text("No Devices Found"));
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
                SvgPicture.asset("assets/bLOVEbEARFrontBig.svg", width: 200, height: 200,),
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



