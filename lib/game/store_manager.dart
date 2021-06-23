import 'package:dino_run/models/dino_store.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'dino.dart';

class StoreManager {
  StoreManager._internal();

  static StoreManager _instance = StoreManager._internal();

  static StoreManager get instance => _instance;

  Future<void> init() async {
    Hive.registerAdapter(DinoStoreAdapter());
    store = await Hive.openBox("store");
    dinos = await Hive.openBox<DinoStore>("dinos");

    if (store!.get('lifes') == null) {
      store!.put('lifes', 3);
    }

    if (store!.get('coins') == null) {
      store!.put('coins', 0);
    }

    if (store!.get('selectedDino') == null) {
      store!.put('selectedDino', DinoType.Green.index);
    }

    if (store!.get('score') == null) {
      store!.put('score', 0);
    }

    if (dinos!.get('dinoGreen') == null) {
      dinos!.put(
        'dinoGreen',
        DinoStore(
          name: 'Green Dino',
          asset: "assets/images/dinoGreen.gif",
          id: 'dinoGreen',
          dinoType: DinoType.Green.index,
          isPurchased: true,
          isSelected: true,
          price: 0,
        ),
      );
    }

    if (dinos!.get('dinoYellow') == null) {
      dinos!.put(
        'dinoYellow',
        DinoStore(
          name: 'Yellow Dino',
          asset: "assets/images/dinoYellow.gif",
          id: 'dinoYellow',
          dinoType: DinoType.Yellow.index,
          isPurchased: false,
          isSelected: false,
          price: 100,
        ),
      );
    }

    if (dinos!.get('dinoBlue') == null) {
      dinos!.put(
        'dinoBlue',
        DinoStore(
          name: 'Blue Dino',
          asset: "assets/images/dinoBlue.gif",
          id: 'dinoBlue',
          dinoType: DinoType.Blue.index,
          isPurchased: false,
          isSelected: false,
          price: 200,
        ),
      );
    }

    if (dinos!.get('dinoRed') == null) {
      dinos!.put(
        'dinoRed',
        DinoStore(
          name: 'Red Dino',
          asset: "assets/images/dinoRed.gif",
          id: 'dinoRed',
          dinoType: DinoType.Red.index,
          isPurchased: false,
          isSelected: false,
          price: 400,
        ),
      );
    }

    _lifes = ValueNotifier(store!.get('lifes'));
    _coins = ValueNotifier(store!.get('coins'));
    _score = ValueNotifier(store!.get('score'));
    _dinos = ValueNotifier(getAllDinos());
  }

  List<DinoStore> getAllDinos() {
    return [
      dinos!.get('dinoGreen'),
      dinos!.get('dinoYellow'),
      dinos!.get('dinoBlue'),
      dinos!.get('dinoRed'),
    ];
  }

  Box? store;
  Box? dinos;

  ValueNotifier<int>? _lifes;
  int? get totalLifes => _lifes!.value;
  ValueNotifier<int>? get listenableLifes => _lifes;
  void setLifes(int lifes) {
    store!.put('lifes', lifes);
    _lifes!.value = lifes;
  }

  ValueNotifier<int>? _score;
  int? get highestScore => _score!.value;
  ValueNotifier<int>? get listenableScore => _score;
  void setHighScore(int score) {
    if (score > highestScore!) {
      store!.put('score', score);
      _score!.value = score;
    }
  }

  ValueNotifier<int>? _coins;
  ValueNotifier<int>? get listenableCoins => _coins;
  int? get currentCoins => _coins!.value;
  void setCoins(int coins) {
    store!.put('coins', coins);
    _coins!.value = coins;
  }

  void addCoins(int coins) {
    setCoins(currentCoins! + coins);
  }

  DinoType get selectedDino => DinoType.values[store!.get('selectedDino')];

  void setSelectedDino(int value) {
    store!.put('selectedDino', value);
  }

  ValueNotifier<List<DinoStore>>? _dinos;
  ValueNotifier<List<DinoStore>>? get listenableDinos => _dinos;

  void purchaseExtraLife(int price) {
    setCoins(currentCoins! - price);
    setLifes(totalLifes! + 1);
  }

  void purchaseDino(DinoStore purchaseDino) {
    purchaseDino.isPurchased = true;
    purchaseDino.save();
    setCoins(currentCoins! - purchaseDino.price);
    _dinos!.value = getAllDinos();
  }

  void selectDino(DinoStore selectDino) {
    var currentDino = _getSelectedDino();

    currentDino!.isSelected = false;
    selectDino.isSelected = true;
    currentDino.save();
    selectDino.save();
    setSelectedDino(selectDino.dinoType);
    _dinos!.value = getAllDinos();
  }

  DinoStore? _getSelectedDino() {
    switch (selectedDino) {
      case DinoType.Green:
        return dinos!.get("dinoGreen");
      case DinoType.Yellow:
        return dinos!.get("dinoYellow");
      case DinoType.Blue:
        return dinos!.get("dinoBlue");
      case DinoType.Red:
        return dinos!.get("dinoRed");
      default:
        dinos!.get("");
    }
  }
}
