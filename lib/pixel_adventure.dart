import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:game_demo1/levels/level.dart';

class PixelAdventure extends FlameGame{
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;

  final world = Level();

  @override
  FutureOr<void> onLoad() {
    cam = CameraComponent.withFixedResolution(world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft; // 추가하지 않으면 왼쪽 맨 위로 기본 지정 됨.

    addAll([cam, world]);
    return super.onLoad();
  }

}