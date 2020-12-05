import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame_santa/my_game.dart';
import 'package:flutter/material.dart';

class Background {
  final MyGame game;
  Sprite sprite;

  Background(this.game) {
    sprite = Sprite(Flame.images.fromCache('background.png'));
  }

  void render(Canvas c) {
    sprite.render(c);
  }
}
