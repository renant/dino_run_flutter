import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'dino.dart';

class StoreManager {
  StoreManager._internal();

  static StoreManager _instance = StoreManager._internal();

  static StoreManager get instance => _instance;

  Future<void> init() async {
    store = await Hive.openBox("store");

    if (store!.get('lifes') == null) {
      store!.put('lifes', 3);
    }

    if (store!.get('coins') == null) {
      store!.put('coins', 0);
    }

    if (store!.get('selectedDino') == null) {
      store!.put('selectedDino', DinoType.Green.index);
    }

    _lifes = ValueNotifier(store!.get('lifes'));
    _coins = ValueNotifier(store!.get('coins'));
  }

  Box? store;

  ValueNotifier<int>? _lifes;
  int? get totalLifes => _lifes!.value;
  ValueNotifier<int>? get listenableLifes => _lifes;
  void setLifes(int lifes) {
    store!.put('lifes', lifes);
    _lifes!.value = lifes;
  }

  ValueNotifier<int>? _coins;
  ValueNotifier<int>? get listenableCoins => _coins;
  void setCoins(int coins) {
    store!.put('coins', coins);
    _coins!.value = coins;
  }

  DinoType get selectedDino => DinoType.values[store!.get('selectedDino')];

  void setSelectedDino(DinoType value) {
    store!.put('selectedDino', value);
  }
}
