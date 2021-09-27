import 'dart:ui';
import 'package:game/models/JetonTypes.dart';
import 'direction.dart';

class Jeton {
  late JetonTypes type;
  late List<int> position;
  late Direction direction;
  late Color color;

  Jeton({
    required this.type,
    required this.position,
    required this.color,
    required this.direction,
  });

  bool isOccuped(int index) {
    if (position.contains(index)) return true;
    return false;
  }

  void moveDown() {
    this.position[0] += 10;
    this.position[1] += 10;
    this.position[2] += 10;
    this.position[3] += 10;
  }
}
