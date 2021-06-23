import 'package:dino_run/game/store_manager.dart';
import 'package:dino_run/screens/game_play.dart';
import 'package:flutter/material.dart';

/// This class displays the first menu on [MainMenu]
/// with play and settings buttons.
class Menu extends StatelessWidget {
  final Function()? onSettingsPressed;
  final Function()? onStorePressed;
  final Function()? onCreditsPressed;

  const Menu({
    Key? key,
    required this.onSettingsPressed,
    required this.onStorePressed,
    required this.onCreditsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Dino Running',
          style: TextStyle(fontSize: 40.0, color: Colors.white),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
          child: Text(
            'Play',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => GamePlay(),
              ),
            );
          },
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 10),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
              child: Text(
                'Store',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: onStorePressed,
            ),
            SizedBox(width: 10),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: onSettingsPressed,
            ),
            SizedBox(width: 10),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
              child: Text(
                'Credits',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: onCreditsPressed,
            )
          ],
        ),
        SizedBox(height: 10),
        StoreManager.instance.highestScore! > 0
            ? Text(
                'Best Score: ${StoreManager.instance.highestScore!}',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              )
            : Container()
      ],
    );
  }
}
