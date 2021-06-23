import 'package:dino_run/game/audio_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Credits extends StatelessWidget {
  final Function()? onBackPressed;

  const Credits({
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
            'Credits',
            style: TextStyle(fontSize: 30.0, color: Colors.white),
          ),
          SizedBox(height: 10),
          Center(
            child: new RichText(
              text: new TextSpan(
                children: [
                  new TextSpan(
                    text: 'Credits assets to ',
                    style: new TextStyle(color: Colors.white),
                  ),
                  new TextSpan(
                    text: 'ScissorMarks',
                    style: new TextStyle(color: Colors.blue),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launch('https://twitter.com/ScissorMarks');
                      },
                  ),
                  new TextSpan(
                    text: ', ',
                    style: new TextStyle(color: Colors.white),
                  ),
                  new TextSpan(
                    text: 'Pixel Frog',
                    style: new TextStyle(color: Colors.blue),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launch('https://pixelfrog-assets.itch.io/');
                      },
                  ),
                  new TextSpan(
                    text: ' and ',
                    style: new TextStyle(color: Colors.white),
                  ),
                  new TextSpan(
                    text: 'Jesse Munguia',
                    style: new TextStyle(color: Colors.blue),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        launch('https://jesse-m.itch.io/');
                      },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: new RichText(
              text: new TextSpan(children: [
                new TextSpan(
                  text: 'Credits for teach me to ',
                  style: new TextStyle(color: Colors.white),
                ),
                new TextSpan(
                  text: 'DevKage',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                          'https://www.youtube.com/channel/UCgofYEUiBiD5lybABz5Kyag');
                    },
                ),
              ]),
            ),
          ),
          SizedBox(height: 10),
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
