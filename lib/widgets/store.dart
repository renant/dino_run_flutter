import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dino_run/game/store_manager.dart';
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
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/images/coin/Gold_1.png', width: 25),
              SizedBox(
                width: 10,
              ),
              ValueListenableBuilder(
                  valueListenable: StoreManager.instance.listenableCoins!,
                  builder: (context, int value, child) {
                    return Text(value.toString(),
                        style: TextStyle(fontSize: 25, color: Colors.white));
                  }),
            ],
          ),
          createPurchaseLifes(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_left),
                iconSize: 42,
                color: Colors.white,
                onPressed: () => _controller.previousPage(),
              ),
              Container(
                width: 200,
                height: 100,
                child: CarouselSlider(
                  items: listDinos(),
                  options: CarouselOptions(),
                  carouselController: _controller,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right),
                iconSize: 42,
                color: Colors.white,
                onPressed: () => _controller.nextPage(),
              ),
            ],
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

  List<Widget> listDinos() {
    return [
      Container(
        child: Image.asset('assets/images/dinoGreen.gif'),
      ),
      Container(
        child: Image.asset('assets/images/dinoYellow.gif'),
      ),
      Container(
        child: Image.asset('assets/images/dinoBlue.gif'),
      ),
      Container(
        child: Image.asset('assets/images/dinoRed.gif'),
      )
    ];
  }

  createPurchaseLifes() {
    return ValueListenableBuilder(
        valueListenable: StoreManager.instance.listenableLifes!,
        builder: (context, int currentLifes, child) {
          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Get a extra life ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Image.asset('assets/images/coin/Gold_1.png', width: 10),
                      SizedBox(width: 5),
                      Text(
                        '25',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  createLifeList(currentLifes)
                ],
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          currentLifes == 6
                              ? Colors.red.shade600
                              : Colors.yellow.shade600)),
                  child: Text(
                    currentLifes == 6 ? 'MAX' : 'Purchase',
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  onPressed: () {
                    print('Purchase');
                  }),
            ],
          );
        });
  }
}
