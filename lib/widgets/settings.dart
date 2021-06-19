import 'package:dino_run/game/audio_manager.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final Function()? onBackPressed;

  const Settings({
    Key? key,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Settings',
            style: TextStyle(fontSize: 60.0, color: Colors.white),
          ),
          ValueListenableBuilder(
            valueListenable: AudioManager.instance.listenableSfx!,
            builder: (context, bool isSfxOn, child) {
              return SwitchListTile(
                value: isSfxOn,
                title: Text(
                  'SFX',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                onChanged: (bool value) {
                  AudioManager.instance.setSfx(value);
                },
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: AudioManager.instance.listenableBgm!,
            builder: (context, bool isBgmOn, child) {
              return SwitchListTile(
                value: isBgmOn,
                title: Text(
                  'BGM',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                onChanged: (bool value) {
                  AudioManager.instance.setBgm(value);
                },
              );
            },
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios_rounded),
                  SizedBox(width: 10),
                  Text(
                    'Menu',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ],
              ),
              onPressed: onBackPressed),
        ],
      ),
    );
  }
}
