import 'package:dino_run/screens/game_play.dart';
import 'package:flutter/material.dart';

/// This class displays the first menu on [MainMenu]
/// with play and settings buttons.
class Menu extends StatelessWidget {
  final Function()? onSettingsPressed;

  const Menu({
    Key? key,
    required this.onSettingsPressed,
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
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: onSettingsPressed,
        )
      ],
    );
  }
}
