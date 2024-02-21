/*
  asset 사이트 : itch.io
  https://www.youtube.com/watch?v=Kwn1eHZP3C4&t=688s
  Tiled 로 맵 구성

  flame, flame_tiled 라이브러리 사용
*/

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_demo1/pixel_adventure.dart';

void main() {
  // SharedPreferences 등 비동기로 데이터를 다룬 다음
  // runApp을 실행해야하는 경우 아래 한줄을 반드시 추가해야합니다.
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  PixelAdventure game = PixelAdventure();
  runApp(GameWidget(game: kDebugMode ? PixelAdventure() : game)
  );
}
