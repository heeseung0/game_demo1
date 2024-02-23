import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_demo1/pixel_adventure.dart';

class BackgroundTile extends SpriteComponent
    with HasGameReference<PixelAdventure> {
  final String color;

  BackgroundTile({
    this.color = 'Gray',
    position,
  }) : super(
          position: position,
        );

  final double scrollSpeed = 0.6;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    size = Vector2.all(64.6);
    sprite = Sprite(game.images.fromCache('Background/$color.png'));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += scrollSpeed;
    position.x += scrollSpeed;
    double tileSize = 64; // 이거 중복인데 나중에 제거해야할 듯
    int scrollHieght = (game.size.y / tileSize).floor();
    int scrollWidth = (game.size.x / tileSize).floor();
    if (position.y > scrollHieght * tileSize) {
      position.y = -tileSize;
    }
    if (position.x > scrollWidth * tileSize) {
      position.x = -tileSize;
    }
    super.update(dt);
  }
}
