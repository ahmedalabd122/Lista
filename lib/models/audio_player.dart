import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DoneAudioPlayer extends StatefulWidget {
  DoneAudioPlayer({Key? key}) : super(key: key);

  @override
  State<DoneAudioPlayer> createState() => _DoneAudioPlayerState();
}

class _DoneAudioPlayerState extends State<DoneAudioPlayer> {
  AudioCache doneplayer = AudioCache();
  bool isPlaying = false;
  

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
