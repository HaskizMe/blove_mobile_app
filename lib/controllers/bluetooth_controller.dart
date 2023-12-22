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

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}