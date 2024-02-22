import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/painting.dart';
import 'package:game_demo1/components/player.dart';
import 'package:game_demo1/components/level.dart';

class PixelAdventure extends FlameGame
  with HasKeyboardHandlerComponents, DragCallbacks{
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  bool showJoystick = true;


  @override
  FutureOr<void> onLoad() async{
    // Load all images into cache
    await images.loadAllImages();

    final world = Level(
      levelName: 'Level-01',
      player: player,
    );

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );
    cam.priority = 0;
    cam.viewfinder.anchor = Anchor.topLeft; // 추가하지 않으면 왼쪽 맨 위로 기본 지정 됨.

    addAll([cam, world]);

    if(showJoystick){
      addJoystick();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if(showJoystick){
      updateJoystick();
    }
    super.update(dt);
  }


  void addJoystick(){
    joystick = JoystickComponent(
      priority: 99,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, right: 32),
    );

    add(joystick);
  }

  void updateJoystick(){
    switch(joystick.direction){
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;  
      default:
        player.horizontalMovement = 0;
        break;
    }
  }
}