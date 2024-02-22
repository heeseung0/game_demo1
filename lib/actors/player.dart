import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:game_demo1/pixel_adventure.dart';

enum PlayerState{idle, running}

enum PlayerDirection{left, right, none}

// 캐릭터가 점프, 이동 등등 과 같은 
// 다양한 애니메이션을 할 것이기 때문에
// GroupComponent 사용
class Player extends SpriteAnimationGroupComponent 
with HasGameRef<PixelAdventure>, KeyboardHandler{
  String character;
  Player({
    position,
    this.character = 'Ninja Frog',
  }) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;

  PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed = 
      keysPressed.contains(LogicalKeyboardKey.keyA) || 
      keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = 
      keysPressed.contains(LogicalKeyboardKey.keyD) || 
      keysPressed.contains(LogicalKeyboardKey.arrowRight);  

    if(isLeftKeyPressed && isRightKeyPressed){
      playerDirection = PlayerDirection.none;
    }else if(isLeftKeyPressed){
      playerDirection = PlayerDirection.left;
    }else if(isRightKeyPressed){
      playerDirection = PlayerDirection.right;
    }else{
      playerDirection = PlayerDirection.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimation(){
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation
    };
    
    // Set current animation
    current = PlayerState.idle;
  }
  
  SpriteAnimation _spriteAnimation(String stateName, int amountSprite) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$stateName (32x32).png')
      ,SpriteAnimationData.sequenced(
        amount: amountSprite,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _updatePlayerMovement(double dt){
    double dirX = 0.0;
    switch(playerDirection){
      case PlayerDirection.left:
        if(isFacingRight){
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        current = PlayerState.running;
        dirX -= moveSpeed;
        break;
      case PlayerDirection.right:
        if(!isFacingRight){
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        current = PlayerState.running;
        dirX += moveSpeed;
        break;  
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;  
      default:
    }

    velocity = Vector2(dirX, 0.0);
    position += velocity * dt;
  }
}