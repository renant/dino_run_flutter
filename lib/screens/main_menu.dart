import 'package:dino_run/widgets/menu.dart';
import 'package:dino_run/widgets/settings.dart';
import 'package:dino_run/widgets/store.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String _menuOpt = 'Menu';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.black.withOpacity(0.4),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50.0),
              child: showOptions(),
            ),
            key: new ValueKey<String>(_menuOpt),
          ),
        ),
      ),
    );
  }

  showOptions() {
    if (_menuOpt == 'Menu') {
      return Menu(
        onSettingsPressed: showSettings,
        onStorePressed: showStore,
      );
    }
    if (_menuOpt == 'Settings') {
      return Settings(
        onBackPressed: showMenu,
      );
    }
    if (_menuOpt == 'Store') {
      return Store(
        onBackPressed: showMenu,
      );
    }
  }

  void showMenu() {
    setState(() {
      _menuOpt = 'Menu';
    });
  }

  void showSettings() {
    setState(() {
      _menuOpt = 'Settings';
    });
  }

  void showStore() {
    setState(() {
      _menuOpt = 'Store';
    });
  }
}
