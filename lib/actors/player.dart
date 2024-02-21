import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_demo1/pixel_adventure.dart';

enum PlayerState{idle, running}

// 캐릭터가 점프, 이동 등등 과 같은 
// 다양한 애니메이션을 할 것이기 때문에
// GroupComponent 사용
class Player extends SpriteAnimationGroupComponent 
with HasGameRef<PixelAdventure>{
  String character;
  Player({position, required this.character}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
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
}