import 'dart:io';

import 'package:dino_run/ads/ad_state.dart';
import 'package:dino_run/game/store_manager.dart';
import 'package:dino_run/screens/main_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dino_run/game/game.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameOverMenu extends StatefulWidget {
  final MyGame game;

  const GameOverMenu({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  _GameOverMenuState createState() => _GameOverMenuState();
}

class _GameOverMenuState extends State<GameOverMenu> {
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        AdState.instance.initializations!.then((status) => {
              setState(() {
                banner = BannerAd(
                  adUnitId: AdState.instance.bannerAdUntil,
                  size: AdSize.banner,
                  request: AdRequest(),
                  listener: AdState.instance.adListener,
                )..load();
              })
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.black.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Game Over',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              SizedBox(height: 10),
              Text(
                  widget.game.score.toInt() <
                          StoreManager.instance.highestScore!
                      ? 'Your Score was ${widget.game.score.toInt()}'
                      : 'New High Score! Your Score was ${StoreManager.instance.highestScore!}',
                  style: TextStyle(fontSize: 30, color: Colors.white)),
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.replay_outlined),
                        SizedBox(width: 10),
                        Text(
                          'Retry',
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ],
                    ),
                    onPressed: () {
                      resetGame();
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey)),
                    child: Text(
                      'Main Menu',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MainMenu(),
                        ),
                      );
                    },
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        banner == null
                            ? SizedBox(height: 50)
                            : Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: AdWidget(
                                  ad: banner!,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void resetGame() {
    this.widget.game.resetGame();
  }
}
