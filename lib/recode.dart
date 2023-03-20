import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class Recode extends StatefulWidget {
  const Recode({Key? key}) : super(key: key);

  @override
  State<Recode> createState() => _RecodeState();
}

class _RecodeState extends State<Recode> {

  final player = AudioPlayer();

  Record record = Record();

  stopRecording() async {
    _timer?.cancel();
    recordDuration = 0;
    recordingStarted = false;
    await record.stop();
    setState(() {

    });
  }

  String? audioFile;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      recordDuration++;
      setState(() {

      });
    });
  }

  emptyAudioFile() {
    audioFile = null;
    setState(() {

    });
  }

  getPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return path;
  }

  int recordDuration = 0;
  Timer? _timer;
  bool recordingStarted = false;
  var saveAudioFile;
  startRecording() async {
    recordingStarted = true;
    setState(() {});
    String _path = await getPath();
    final filePath = '$_path/${DateTime.now().toString()}.mp3';
    if (await record.hasPermission()) {
      log('this is record file: $filePath  $_path');
      await record.start(
        path: filePath,
        // encoder: AudioEncoder.aacLc,
      );
      _startTimer();
      record.onStateChanged();
      File file = File(filePath);
      if (await file.exists()) {
        audioFile = file.path;
      }


    } else {
      Permission.microphone.request();
      startRecording();
    }
  }

  // static Future saveInStorage(String fileName, File file, String extension) async {
  //   Permission.storage.request();
  //   String _localPath = await getPath();
  //   String filePath = _localPath + "/" + fileName.trim() + "_" + Uuid().v4() + extension;
  //   File fileDef = File(filePath);
  //   await fileDef.create(recursive: true);
  //   Uint8List bytes = await file.readAsBytes();
  //   await fileDef.writeAsBytes(bytes);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$recordDuration',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (recordingStarted) {
                  await stopRecording();
                } else {
                  await startRecording();
                }
              },
              child: Text(
                  recordingStarted ? 'Stop Recording' : 'Start Recording'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (audioFile != null) {
            print('this is audio file: $audioFile');
            File file = File(audioFile!);
            await player.play(file.path, isLocal: true, stayAwake: true, volume: 1.0);
          }else{
            print('no audio');
          }
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}