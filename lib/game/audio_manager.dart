import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class AudioManager {
  AudioManager._internal();

  static AudioManager _instance = AudioManager._internal();

  static AudioManager get instance => _instance;

  Future<void> init() async {
    FlameAudio.bgm.initialize();
    // FlameAudio.bgm.play(, volume: 0.50);

    settings = await Hive.openBox("settings");

    if (settings!.get('bgm') == null) {
      settings!.put('bgm', true);
    }

    if (settings!.get('sfx') == null) {
      settings!.put('sfx', true);
    }

    _sfx = ValueNotifier(settings!.get('sfx'));
    _bgm = ValueNotifier(settings!.get('bgm'));
  }

  Box? settings;
  ValueNotifier<bool>? _sfx;
  ValueNotifier<bool>? _bgm;

  ValueNotifier<bool>? get listenableSfx => _sfx;
  ValueNotifier<bool>? get listenableBgm => _bgm;

  void setSfx(bool flag) {
    settings!.put('sfx', flag);
    _sfx!.value = flag;
  }

  void setBgm(bool flag) {
    settings!.put('bgm', flag);
    _bgm!.value = flag;
  }

  void startBgm() {
    if (_bgm!.value) {
      FlameAudio.bgm.play('bgloop.wav', volume: 0.4);
    }
  }

  // Pauses currently playing BGM if any.
  void pauseBgm() {
    if (_bgm!.value) {
      FlameAudio.bgm.pause();
    }
  }

  // Resumes currently paused BGM if any.
  void resumeBgm() {
    if (_bgm!.value) {
      FlameAudio.bgm.resume();
    }
  }

  // Stops currently playing BGM if any.
  void stopBgm() {
    if (_bgm!.value) {
      FlameAudio.bgm.stop();
    }
  }

  // Plays the given audio file once.
  void playSfx(String fileName) {
    if (_sfx!.value) {
      FlameAudio.audioCache.play(fileName, volume: 1);

      // FlameAudio.play(fileName);
    }
  }
}
