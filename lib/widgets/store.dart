import 'package:dino_run/game/store_manager.dart';
import 'package:dino_run/models/dino_store.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  final Function()? onBackPressed;

  Store({
    Key? key,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              createPurchaseLifes(),
              ValueListenableBuilder(
                  valueListenable: StoreManager.instance.listenableCoins!,
                  builder: (context, int value, child) {
                    return Row(
                      children: [
                        Image.asset('assets/images/coin/Gold_1.png', width: 25),
                        SizedBox(
                          width: 10,
                        ),
                        Text(value.toString(),
                            style:
                                TextStyle(fontSize: 25, color: Colors.white)),
                      ],
                    );
                  }),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text('Select your Dino!',
              style: TextStyle(fontSize: 25, color: Colors.white)),
          SizedBox(
            height: 10,
          ),
          ValueListenableBuilder(
              valueListenable: StoreManager.instance.listenableDinos!,
              builder: (context, List<DinoStore> dinos, child) {
                return Container(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: listDinos(dinos),
                    ));
              }),
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
              onPressed: widget.onBackPressed),
        ],
      ),
    );
  }

  Row createLifeList(int numberLifes) {
    final list = <Widget>[];

    for (int i = 0; i < 6; ++i) {
      list.add(Icon(i < numberLifes ? Icons.favorite : Icons.favorite_border,
          color: Colors.red, size: 30.0));
    }

    return Row(
      children: list,
    );
  }

  List<Widget> listDinos(List<DinoStore> dinos) {
    return dinos.map((dino) {
      return createDino(dino);
    }).toList();
  }

  Widget createDino(DinoStore dino) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            child: Image.asset(dino.asset),
          ),
          dino.isPurchased
              ? Text(
                  'Acquired',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              : Row(
                  children: [
                    SizedBox(width: 5),
                    Image.asset('assets/images/coin/Gold_1.png', width: 10),
                    SizedBox(width: 5),
                    Text(
                      dino.price.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
          ValueListenableBuilder(
              valueListenable: StoreManager.instance.listenableCoins!,
              builder: (context, int currentCoins, child) {
                return ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      dino.isPurchased
                          ? (dino.isSelected
                              ? Colors.greenAccent
                              : Colors.lightBlue)
                          : dino.price > currentCoins
                              ? Colors.grey.shade200
                              : Colors.yellow.shade600,
                    )),
                    child: Text(
                      dino.isPurchased
                          ? (dino.isSelected ? "Selected" : "Select")
                          : 'Purchase',
                      style: TextStyle(fontSize: 10.0, color: Colors.black87),
                    ),
                    onPressed: dino.isPurchased
                        ? (dino.isSelected
                            ? null
                            : () {
                                StoreManager.instance.selectDino(dino);
                              })
                        : (dino.price > currentCoins
                            ? null
                            : () {
                                StoreManager.instance.purchaseDino(dino);
                              }));
              }),
        ],
      ),
    );
  }

  createPurchaseLifes() {
    return ValueListenableBuilder(
        valueListenable: StoreManager.instance.listenableLifes!,
        builder: (context, int currentLifes, child) {
          var price = 25;
          if (currentLifes == 4) {
            price = 50;
          }
          if (currentLifes == 5) {
            price = 100;
          }

          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  currentLifes != 6
                      ? Row(
                          children: [
                            Text(
                              'Get a extra life ',
                              style: TextStyle(color: Colors.white),
                            ),
                            Image.asset('assets/images/coin/Gold_1.png',
                                width: 10),
                            SizedBox(width: 5),
                            Text(
                              price.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(height: 5),
                  createLifeList(currentLifes)
                ],
              ),
              SizedBox(
                width: 10,
              ),
              ValueListenableBuilder(
                  valueListenable: StoreManager.instance.listenableCoins!,
                  builder: (context, int currentCoins, child) {
                    return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                currentLifes == 6
                                    ? Colors.red.shade600
                                    : (price > currentCoins
                                        ? Colors.grey.shade200
                                        : Colors.yellow.shade600))),
                        child: Text(
                          currentLifes == 6 ? 'MAX' : 'Purchase',
                          style:
                              TextStyle(fontSize: 10.0, color: Colors.black87),
                        ),
                        onPressed: currentLifes == 6 || price > currentCoins
                            ? null
                            : () {
                                StoreManager.instance.purchaseExtraLife(price);
                              });
                  }),
            ],
          );
        });
  }
}
