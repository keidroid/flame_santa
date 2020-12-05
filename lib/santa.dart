import 'dart:math';
import 'dart:ui';

import 'package:flame/components/sprite_component.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flame/flame.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame_santa/my_game.dart';

class Santa {
  static const SPEED = 50.0;
  static const ANIMATION_FRAME = 0.1;
  static const ANIMATION_COUNT = 3;

  Vector2 position = Vector2(32, 52);
  final Vector2 size = Vector2.all(16);

  final MyGame game;
  SpriteSheet sprites;
  int animationIndex = 0;
  double time = 0.0;
  bool isRight = true;

  PlayerState state = PlayerState.Idle;

  Santa(this.game) {
    sprites = SpriteSheet.fromColumnsAndRows(
        image: Flame.images.fromCache('santa.png'),
        columns: ANIMATION_COUNT,
        rows: 2);
  }

  void update(double t) {
    if (state == PlayerState.RunLeft) {
      position.x -= SPEED * t;
    } else if (state == PlayerState.RunRight) {
      position.x += SPEED * t;
    }
    position.x = max(size.x * 0.5, min(position.x, game.size.x - size.x * 0.5));

    time += t;
    if (time > ANIMATION_FRAME) {
      animationIndex++;
      if (animationIndex >= ANIMATION_COUNT) {
        animationIndex = 0;
      }
      time = 0;
    }
    if (state == PlayerState.RunLeft) {
      isRight = false;
    } else if (state == PlayerState.RunRight) {
      isRight = true;
    }
  }

  void render(Canvas canvas) {
    // Componentを使用しない方法
    /*
    var sprite = sprites.getSprite(isRight ? 1 : 0, animationIndex);
    sprite.renderPosition(
        canvas,
        Vector2((position.x - size.x / 2).roundToDouble(),
            (position.y - size.y / 2).roundToDouble()));
    */
    // Componentを使用する方法
    var sprite = sprites.getSprite(0, animationIndex);
    var component = SpriteComponent.fromSprite(size, sprite);
    component.position = Vector2((position.x - size.x / 2).roundToDouble(),
        (position.y - size.y / 2).roundToDouble());
    component.angle = 0;
    component.renderFlipX = isRight;
    component.render(canvas);
  }
}
