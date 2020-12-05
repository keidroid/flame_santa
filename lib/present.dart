import 'dart:ui';

import 'package:flame/extensions/vector2.dart';
import 'package:flame/flame.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame_santa/my_game.dart';

class Present {
  static const SPEED = 40.0;

  final Vector2 size = Vector2(10, 8);
  final MyGame game;
  final int index;

  Rect rect;
  SpriteSheet sprites;
  bool shouldRemove = false;

  Present(this.game, this.index, Vector2 position) {
    sprites = SpriteSheet.fromColumnsAndRows(
        image: Flame.images.fromCache('present.png'), columns: 2, rows: 1);
    rect = Rect.fromLTWH(position.x, position.y, size.x, size.y);
  }

  void render(Canvas c) {
    var sprite = sprites.getSprite(0, index);
    sprite.renderPosition(
        c, Vector2(rect.left.roundToDouble(), rect.top.roundToDouble()));
  }

  void update(double t) {
    rect = rect.translate(0, SPEED * t);
    if (rect.top > game.size.y) {
      shouldRemove = true;
    }
  }
}
