import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

Future<void> startRecording(AudioPlayer player, AudioRecorder recorder) async {

  if (await recorder.hasPermission()) {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String destinationPath = '${appDocDir.path}/recorded_audio.mp3';

    await recorder.start(const RecordConfig(), path: destinationPath);
  }
}