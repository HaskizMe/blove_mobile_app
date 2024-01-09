import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

// Class to control the audio functions
class AudioRecorderManager {
  late AudioPlayer _audioPlayer;
  late AudioRecorder _audioRecorder;
  late String _audioPath;
  bool _isAudioRecorderInitialized = false;

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
      _isAudioRecorderInitialized = true;
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
      if (_audioPath.isNotEmpty) {
        Source urlSource = UrlSource(_audioPath);
        await _audioPlayer.play(urlSource);
      } else {
        print("Error: Audio path is empty.");
      }
    } catch (e) {
      print("Error with play recording: $e");
    }
  }

  // This function will handle sending the the audio to bear
  Future<void> sendMessage() async {
    try {
      if (File(_audioPath).existsSync()) {
        File(_audioPath).delete();
      } else {
        print("Error: Audio file doesn't exist.");
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  // This resets the audio buttons so that an audio message can be discarded
  Future<void> reset() async {
    try {
      if (File(_audioPath).existsSync()) {
        File(_audioPath).delete();
      } else {
        print("Error: Audio file doesn't exist.");
      }
    } catch (e) {
      print('Error resetting: $e');
    }
  }

  // This is called when the widget tree is disposed to save memory
  void dispose() {
    if (_isAudioRecorderInitialized) {
      print("dispose called");
      _audioRecorder.dispose();
    }
    _audioPlayer.dispose();
  }
}