import 'dart:math';
import 'dart:ui';

import 'package:flame/extensions/vector2.dart';
import 'package:flame/game.dart';
import 'package:flame_santa/background.dart';
import 'package:flame_santa/present.dart';
import 'package:flame_santa/santa.dart';
import 'package:flutter/material.dart';

class MyGame extends Game {
  static const SPAWN_PRESENT_MIN = 0.4;
  static const SPAWN_PRESENT_RANGE = 2.0;

  Vector2 size = Vector2(64, 64);
  double tileSize;
  Random random = Random();

  double deltaTime = 0;

  Background background;
  Santa santa;
  List<Present> presents = List<Present>();

  MyGame() {
    initialize();
  }

  Future initialize() async {
    background = Background(this);
    santa = Santa(this);

    onResize(size);
  }

  @override
  void onResize(Vector2 size) {
    this.size = size;
    tileSize = size.x / 8;

    super.onResize(size);
  }

  @override
  void update(double t) {
    santa.update(t);

    updatePresents(t);
  }

  void updatePresents(double t) {
    presents.forEach((Present present) => present.update(t));
    presents.removeWhere((Present present) => present.shouldRemove);
    deltaTime += t;
    if (deltaTime >
        SPAWN_PRESENT_MIN + random.nextDouble() * SPAWN_PRESENT_RANGE) {
      spawnPresent();
      deltaTime = 0;
    }
  }

  void spawnPresent() {
    presents.add(Present(
        this, random.nextInt(2), Vector2(random.nextInt(8) * tileSize, -10)));
  }

  @override
  void render(Canvas canvas) {
    background.render(canvas);
    presents.forEach((Present present) => present.render(canvas));
    santa.render(canvas);
  }

  void pressDownLeft() {
    santa.state = PlayerState.RunLeft;
  }

  void pressDownRight() {
    santa.state = PlayerState.RunRight;
  }

  void pressUp() {
    santa.state = PlayerState.Idle;
  }
}

enum PlayerState { Idle, RunLeft, RunRight }
