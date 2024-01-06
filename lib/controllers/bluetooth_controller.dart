import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  //FlutterBluePlus ble = FlutterBluePlus;

  Future scanDevices() async {
    if(await Permission.bluetoothScan.request().isGranted){
      if(await Permission.bluetoothConnect.request().isGranted){
        FlutterBluePlus.onScanResults.listen((results) {
          if (results.isNotEmpty) {
            ScanResult r = results.last; // the most recently found device
            if(r.advertisementData.advName == 'PainDrain') {
              print('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
            }
            // print('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
          }
        },
        );
      }
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    }
  }

  Future connectDevice(BluetoothDevice device) async {
    var subscription = device.connectionState.listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
        // 1. typically, start a periodic timer that tries to
        //    reconnect, or just call connect() again right now
        // 2. you must always re-discover services after disconnection!
        print("Disconnect reason: ${device.disconnectReason}");
      }
    });
    if(device.isConnected){
      try {
        await device.connect();
        subscription.cancel();
        print("Device disconnected successfully");
      } catch(e){
        print("disconnection failed");
      }
    }
    else{
      try {
        await device.connect();
        print("is Connected");
      } catch(e){
        print("connection failed");
      }
    }
// listen for disconnection
//     var subscription = device.connectionState.listen((BluetoothConnectionState state) async {
//       if (state == BluetoothConnectionState.disconnected) {
//         // 1. typically, start a periodic timer that tries to
//         //    reconnect, or just call connect() again right now
//         // 2. you must always re-discover services after disconnection!
//         print("Disconnect reason: ${device.disconnectReason}");
//       }
//     });
//
//     if(!device.isConnected){
//       await device.connect();
//     }
//     else{
//       await device.disconnect();
//       subscription.cancel();
//     }


    // var subscription = device.connectionState.listen((BluetoothConnectionState state) async {
    //   if (state == BluetoothConnectionState.disconnected) {
    //     // 1. typically, start a periodic timer that tries to
    //     //    reconnect, or just call connect() again right now
    //     // 2. you must always re-discover services after disconnection!
    //     print("${device.disconnectReason}");
    //   }
    // });
    // if(device.isConnected){
    //   try {
    //     await device.connect();
    //     subscription.cancel();
    //     print("Device disconnected successfully");
    //   } catch(e){
    //     print("disconnection failed");
    //   }
    // }
    // else{
    //   try {
    //     await device.connect();
    //     print("is Connected");
    //   } catch(e){
    //     print("connection failed");
    //   }
    // }
    // var subscription = device.connectionState.listen((BluetoothConnectionState state) async {
    //   if (state == BluetoothConnectionState.disconnected) {
    //     // 1. typically, start a periodic timer that tries to
    //     //    reconnect, or just call connect() again right now
    //     // 2. you must always re-discover services after disconnection!
    //     print("${device.disconnectReason}");
    //   }
    // });

  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}