import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

// Class to control the audio functions
class AudioRecorderManager {
  late AudioPlayer _audioPlayer;
  late AudioRecorder _audioRecorder;
  late String _audioPath;

  AudioRecorderManager() {
    _audioPlayer = AudioPlayer();
    _audioRecorder = AudioRecorder();
    _audioPath = '';
  }

  // Function that starts listening to the recording
  Future<void> startRecording() async {
    if (await _audioRecorder.hasPermission()) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      _audioPath = '${appDocDir.path}/recorded_audio.mp3';

      await _audioRecorder.start(const RecordConfig(), path: _audioPath);
    }
  }

  // Function that stops recording and prepares a path to the recording
  Future<String?> stopRecording() async {
    try {
      String? path = await _audioRecorder.stop();
      print('audio path $_audioPath');
      return path;
    } catch (e) {
      print("Error with stop recording");
      return null;
    }
  }

  // Finds the path to the recording and then plays it
  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(_audioPath);
      await _audioPlayer.play(urlSource);
    } catch (e) {
      print("Error with play recording: $e");
    }
  }

  // This function will handle sending the the audio to bear
  Future<void> sendMessage() async {
    try {
      File(_audioPath).delete();
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  // This resets the audio buttons so that an audio message can be discarded
  Future<void> reset() async {
    try {
      File(_audioPath).delete();
    } catch (e) {
      print('Error resetting: $e');
    }
  }

  // This is called when the widget tree is disposed to save memory
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
  }
}


// Future<void> startRecording(AudioPlayer player, AudioRecorder recorder) async {
//
//   if (await recorder.hasPermission()) {
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String destinationPath = '${appDocDir.path}/recorded_audio.mp3';
//
//     await recorder.start(const RecordConfig(), path: destinationPath);
//   }
// }
//
// Future<void> playRecording(String? audioPath, AudioPlayer audioPlayer) async {
//
//   try{
//     Source urlSource =  UrlSource(audioPath!);
//     await audioPlayer.play(urlSource);
//   } catch(e) {
//     print("Error with play recording");
//   }
// }
//
// Future<void> sendMessage(String? audioPath) async {
//   try {
//     File(audioPath!).delete();
//   } catch (e) {
//     print('Error sending message: $e');
//   }
// }
//
// Future<void> reset(String? audioPath) async {
//   try {
//     File(audioPath!).delete();
//   } catch (e) {
//     print('Error resetting: $e');
//   }
// }