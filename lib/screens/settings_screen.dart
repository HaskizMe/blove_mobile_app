import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controllers/bluetooth_controller.dart';
import '../global_variables/screen_size_values.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: GetBuilder<BluetoothController>(
          init: BluetoothController(),
          builder: (controller){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: StreamBuilder<List<ScanResult>>(
                        stream: controller.scanResults,
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            print("Snapshot ${snapshot.data}");
                            print("Has Data");
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index){
                                  final data =  snapshot.data![index];
                                  print("name ${data.device.advName}");
                                  if(data.device.advName == "PainDrain") {
                                    return Card(
                                      child: ListTile(
                                        title: Text(data.device.advName),
                                        subtitle: Text(data.device.remoteId.toString()),
                                        trailing: Text(data.rssi.toString()),
                                      ),
                                    );
                                  }
                                }
                            );
                          } else{
                            return const Center(child: Text("No Devices Found"),);
                          }
                        }
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () => controller.scanDevices(),
                    child: Text("scan"),
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}
