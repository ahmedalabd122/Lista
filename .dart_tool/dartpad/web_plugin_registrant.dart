// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

// @dart = 2.13
// ignore_for_file: type=lint

import 'package:assets_audio_player_web/web/assets_audio_player_web.dart';
import 'package:audioplayers_web/audioplayers_web.dart';
import 'package:flutter_native_splash/flutter_native_splash_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  AssetsAudioPlayerWebPlugin.registerWith(registrar);
  AudioplayersPlugin.registerWith(registrar);
  FlutterNativeSplashWeb.registerWith(registrar);
  registrar.registerMessageHandler();
}
