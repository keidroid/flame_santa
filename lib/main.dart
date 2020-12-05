import 'package:flame/flame.dart';
import 'package:flame_santa/my_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  await Flame.init(
      fullScreen: true, orientation: DeviceOrientation.landscapeRight);

  await Flame.util.setLandscape();
  await Flame.util.initialDimensions();
  await Flame.images.loadAll(<String>[
    'background.png',
    'explosion.png',
    'present.png',
    'santa.png',
  ]);

  var game = MyGame();
  runApp(MaterialApp(
    home: Container(
      color: Colors.white10,
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        gameButton("L", () {
          game.pressDownLeft();
        }, () {
          game.pressUp();
        }),
        Expanded(
            child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.fitHeight,
                child: ClipRect(
                    child:
                        SizedBox(width: 64, height: 64, child: game.widget)))),
        gameButton("R", () {
          game.pressDownRight();
        }, () {
          game.pressUp();
        }),
      ]),
    ),
  ));
}

Widget gameButton(
    String data, VoidCallback onPressDown, VoidCallback onPressUp) {
  return GestureDetector(
      onTapDown: (TapDownDetails details) {
        onPressDown();
      },
      onTapUp: (TapUpDetails details) {
        onPressUp();
      },
      onTapCancel: () {
        onPressUp();
      },
      child: new Container(
        width: 128,
        height: 128,
        color: Colors.white60,
        padding: const EdgeInsets.all(16.0),
        child: RaisedButton(
          child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(data, style: TextStyle(fontSize: 20))),
          color: Colors.white,
          shape: const CircleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          onPressed: () {}, // 指定しないと無効ボタンになる
        ),
      ));
}
