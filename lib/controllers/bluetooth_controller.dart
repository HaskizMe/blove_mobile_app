import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  //FlutterBluePlus ble = FlutterBluePlus;
  String customServiceUUID = "3ac80bae-d848-425e-a046-4556a9d35b2a";
  String customCharacteristicUUID = "aa7705d5-bc3c-4f4d-b984-a638e1d90b8a";
  late BluetoothService customService;
  late BluetoothCharacteristic customCharacteristic;
  late List<BluetoothService> services;

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

  Future<bool> connectDevice(BluetoothDevice device) async {
    var subscription = device.connectionState.listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
        // 1. typically, start a periodic timer that tries to
        //    reconnect, or just call connect() again right now
        // 2. you must always re-discover services after disconnection!
        // await connectDevice(device);
        device.connect();
        List<int> value = await customCharacteristic.read();
        print("values read $value");

        print("Disconnect reason: ${device.disconnectReason}");
      }
    });
    if(device.isConnected){
      try {
        await device.disconnect();
        subscription.cancel();
        print("Device disconnected successfully");
      } catch(e){
        print("disconnection failed");
      }
    }
    else{
      try {
        await device.connect();
        services = await device.discoverServices();
        for (BluetoothService service in services) {
          if(service.uuid.toString() == customServiceUUID){
            print("Custom service found");
            customService = service;
          }
        }
        var customServiceCharacteristics = customService.characteristics;
        for(BluetoothCharacteristic characteristic in customServiceCharacteristics) {
          if(characteristic.uuid.toString() == customCharacteristicUUID){
            print("Custom characteristic found");
            customCharacteristic = characteristic;
          }
        }
        print("is Connected");
        return true;
      } catch(e){
        print("connection failed");
      }
    }
    return false;
  }

  Future<void> writeToDevice(BluetoothDevice device) async {
    List<int> command = "SCAN".codeUnits;
    print("command $command");
    await customCharacteristic.write(command);
    await connectDevice(device);
    List<int> value = await customCharacteristic.read();
    print("read values $value");
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}