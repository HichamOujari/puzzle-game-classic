import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '/models/JetonTypes.dart';
import '/models/direction.dart';
import '/models/jeton.dart';
import '/layouts/cube.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int nbrY = 18, nbrX = 10;
  late List<Jeton> listIndexOccuped = [];
  late List<int> listAllIndex = [];
  late List touchsDirection = [0, 0, 0];
  late int score = 0;

  setUpState() {
    if (listIndexOccuped.length != 0) {
      if (!isDown()) {
        setState(() {
          listIndexOccuped[listIndexOccuped.length - 1].moveDown();
        });
      } else
        randomJeton();
    } else
      randomJeton();
  }

  bool isDown() {
    var mJeton = listIndexOccuped[listIndexOccuped.length - 1];
    if (listIndexOccuped.length != 1)
      for (var i = 0; i < listIndexOccuped.length - 1; i++) {
        if (listIndexOccuped[i].isOccuped(mJeton.position[0] + 10) ||
            listIndexOccuped[i].isOccuped(mJeton.position[1] + 10) ||
            listIndexOccuped[i].isOccuped(mJeton.position[2] + 10) ||
            listIndexOccuped[i].isOccuped(mJeton.position[3] + 10)) {
          return true;
        }
      }
    var max = mJeton.position[0];
    if (mJeton.position[1] > max) max = mJeton.position[1];
    if (mJeton.position[2] > max) max = mJeton.position[2];
    if (mJeton.position[3] > max) max = mJeton.position[3];
    if (max >= nbrX * (nbrY - 1)) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    setUpState();
    /*Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      setUpState();
    });*/
  }

  bool canMove(newPos) {
    for (var i = 0; i < listIndexOccuped.length - 1; i++) {
      if (listIndexOccuped[i].isOccuped(newPos[0]) ||
          listIndexOccuped[i].isOccuped(newPos[1]) ||
          listIndexOccuped[i].isOccuped(newPos[2]) ||
          listIndexOccuped[i].isOccuped(newPos[3])) {
        return false;
      }
    }
    return true;
  }

  rotate() {
    var mJeton = listIndexOccuped[listIndexOccuped.length - 1];
    var types = [
      JetonTypes.FORMAT_I,
      JetonTypes.FORMAT_L,
      JetonTypes.LIGNE,
    ];
    var directions = [
      Direction.UP,
      Direction.DONW,
      Direction.LEFT,
      Direction.RIGHT,
    ];

    var sType = mJeton.type;
    var sDirection = mJeton.direction;
    if (sType == types[2] &&
        (sDirection == directions[0] || sDirection == directions[1])) {
      //[3, 4, 5, 6]
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 11,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 21,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 31
      ];

      if (canMove(newPos)) {
        listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
        listIndexOccuped[listIndexOccuped.length - 1].direction = directions[2];
      }
    } else if (sType == types[2] &&
        (sDirection == directions[2] || sDirection == directions[3])) {
      //[4, 14, 24, 34]
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0] - 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[0],
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 2
      ];

      if (canMove(newPos)) {
        listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
        listIndexOccuped[listIndexOccuped.length - 1].direction = directions[0];
      }
    } else if (sType == types[0] && sDirection == directions[0]) {
      //[4, 13, 14, 15]
      //  *
      // ***
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0],
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 10,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 11,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 20
      ];
      if (canMove(newPos)) {
        listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
        listIndexOccuped[listIndexOccuped.length - 1].direction = directions[3];
      }
    } else if (sType == types[0] && sDirection == directions[1]) {
      //[3, 14, 4, 5]
      //  ***
      //   *
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 10,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 11,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 21
      ];
      if (canMove(newPos)) {
        listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
        listIndexOccuped[listIndexOccuped.length - 1].direction = directions[2];
      }
    } else if (sType == types[0] && sDirection == directions[2]) {
      //[4, 13, 14, 24]
      //   *
      //  **
      //   *
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0],
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 9,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 10,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 11
      ];
      if (canMove(newPos)) {
        listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
        listIndexOccuped[listIndexOccuped.length - 1].direction = directions[0];
      }
    } else if (sType == types[0] && sDirection == directions[3]) {
      //[4, 14, 15, 24]
      //  *
      //  **
      //  *
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0] - 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 10,
        listIndexOccuped[listIndexOccuped.length - 1].position[0],
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 1
      ];
      if (canMove(newPos)) {
        listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
        listIndexOccuped[listIndexOccuped.length - 1].direction = directions[1];
      }
    } else if (sType == types[1] && sDirection == directions[0]) {
      //[4, 14, 24, 25]
      //  *
      //  *
      //  * *
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0],
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 10,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 2
      ];
      if (canMove(newPos)) {
        listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
        listIndexOccuped[listIndexOccuped.length - 1].direction = directions[3];
      }
    } else if (sType == types[1] && sDirection == directions[1]) {
      //[4, 15, 25, 5]
      //  **
      //   *
      //   *
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 10,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 11,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 2,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 12
      ];
      if (canMove(newPos)) {
        listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
        listIndexOccuped[listIndexOccuped.length - 1].direction = directions[2];
      }
    } else if (sType == types[1] && sDirection == directions[2]) {
      //[14, 15, 6, 16]
      //      *
      //  * * *
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0] - 10,
        listIndexOccuped[listIndexOccuped.length - 1].position[0],
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 10,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 11
      ];
      if (canMove(newPos)) {
        listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
        listIndexOccuped[listIndexOccuped.length - 1].direction = directions[0];
      }
    } else if (sType == types[1] && sDirection == directions[3]) {
      //[4, 14, 5, 6]
      //  * * *
      //  *
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0],
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 11,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 21,
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 1
      ];
      if (canMove(newPos)) {
        listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
        listIndexOccuped[listIndexOccuped.length - 1].direction = directions[1];
      }
    }
  }

  randomJeton() {
    if (listIndexOccuped.length != 0)
      listAllIndex
          .addAll(listIndexOccuped[listIndexOccuped.length - 1].position);
    var random = new Random();
    var types = [
      JetonTypes.FORMAT_I,
      JetonTypes.FORMAT_L,
      JetonTypes.LIGNE,
    ];

    var directions = [
      Direction.UP,
      Direction.DONW,
      Direction.LEFT,
      Direction.RIGHT,
    ];

    var sType = random.nextInt(3);
    var sDirection = random.nextInt(4);
    if (sType == 2 && (sDirection == 0 || sDirection == 1)) {
      listIndexOccuped.add(new Jeton(
        type: types[sType],
        color: Colors.yellow,
        direction: directions[sDirection],
        position: [3, 4, 5, 6],
      ));
    } else if (sType == 2 && (sDirection == 2 || sDirection == 3)) {
      listIndexOccuped.add(new Jeton(
        type: types[sType],
        color: Colors.red,
        direction: directions[sDirection],
        position: [4, 14, 24, 34],
      ));
    } else if (sType == 0 && sDirection == 0) {
      listIndexOccuped.add(new Jeton(
        type: types[sType],
        color: Colors.green,
        direction: directions[sDirection],
        position: [4, 13, 14, 15],
      ));
    } else if (sType == 0 && sDirection == 1) {
      listIndexOccuped.add(new Jeton(
        type: types[sType],
        color: Colors.blue,
        direction: directions[sDirection],
        position: [3, 14, 4, 5],
      ));
    } else if (sType == 0 && sDirection == 2) {
      listIndexOccuped.add(new Jeton(
        type: types[sType],
        color: Colors.indigo,
        direction: directions[sDirection],
        position: [4, 13, 14, 24],
      ));
    } else if (sType == 0 && sDirection == 3) {
      listIndexOccuped.add(new Jeton(
        type: types[sType],
        color: Colors.blueGrey,
        direction: directions[sDirection],
        position: [4, 14, 15, 24],
      ));
    } else if (sType == 1 && sDirection == 0) {
      listIndexOccuped.add(new Jeton(
        type: types[sType],
        color: Colors.deepOrange,
        direction: directions[sDirection],
        position: [4, 14, 24, 25],
      ));
    } else if (sType == 1 && sDirection == 1) {
      listIndexOccuped.add(new Jeton(
        type: types[sType],
        color: Colors.deepPurple,
        direction: directions[sDirection],
        position: [4, 15, 25, 5],
      ));
    } else if (sType == 1 && sDirection == 2) {
      listIndexOccuped.add(new Jeton(
        type: types[sType],
        color: Colors.amberAccent,
        direction: directions[sDirection],
        position: [14, 15, 6, 16],
      ));
    } else if (sType == 1 && sDirection == 3) {
      listIndexOccuped.add(new Jeton(
        type: types[sType],
        color: Colors.limeAccent,
        direction: directions[sDirection],
        position: [4, 14, 5, 6],
      ));
    }
    isDone();
  }

  isDone() {
    var count = 0;
    for (int i = 0; i < 18; i++) {
      count = 0;
      for (int j = 0; j < 10; j++) {
        if (listAllIndex.contains(i * 10 + j)) count++;
      }
      if (count == 10) {
        setState(() {
          score += 100;
        });
        for (int j = 0; j < 10; j++) {
          count = (listAllIndex.indexOf(i * 10 + j) ~/ 4);
          listIndexOccuped[count].position[
              listIndexOccuped[count].position.indexOf(i * 10 + j)] = -1;
          listAllIndex[listAllIndex.indexOf(i * 10 + j)] = -1;
        }
        for (var ele in listIndexOccuped) {
          if (ele.position[0] != -1 && ele.position[0] / 10 < i) {
            listAllIndex[listAllIndex.indexOf(ele.position[0])] += 10;
            ele.position[0] += 10;
          }
          if (ele.position[1] != -1 && ele.position[1] / 10 < i) {
            listAllIndex[listAllIndex.indexOf(ele.position[1])] += 10;
            ele.position[1] += 10;
          }
          if (ele.position[2] != -1 && ele.position[2] / 10 < i) {
            listAllIndex[listAllIndex.indexOf(ele.position[2])] += 10;
            ele.position[2] += 10;
          }
          if (ele.position[3] != -1 && ele.position[3] / 10 < i) {
            listAllIndex[listAllIndex.indexOf(ele.position[3])] += 10;
            ele.position[3] += 10;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - 60) / nbrY;
    final double itemWidth = size.width / nbrX;
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Container(
              height: size.height - 60,
              width: size.width,
              child: GestureDetector(
                onDoubleTap: () {
                  rotate();
                },
                onPanUpdate: (e) {
                  if ((e.localPosition.dx - touchsDirection[2]) *
                          (e.localPosition.dx - touchsDirection[2]) >
                      60) {
                    setState(() {
                      touchsDirection = [
                        touchsDirection[1],
                        touchsDirection[2],
                        e.localPosition.dx
                      ];
                    });
                    moveJeton();
                  }
                },
                child: GridView.count(
                  childAspectRatio: (itemWidth / itemHeight),
                  controller: new ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: nbrX,
                  children: List.generate(
                    nbrY * nbrX,
                    (index) => Cube(color: isOccuped(index)),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Score : $score Points",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 90,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      color: Colors.grey,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color isOccuped(int index) {
    for (var ele in listIndexOccuped) {
      if (ele.isOccuped(index)) return ele.color;
    }
    return Colors.black;
  }

  moveJeton() {
    if (touchsDirection[0] < touchsDirection[1] &&
        touchsDirection[1] < touchsDirection[2]) {
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0] + 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[1] + 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[2] + 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[3] + 1
      ];
      if (listIndexOccuped[listIndexOccuped.length - 1].position[0] % 10 != 9 &&
          listIndexOccuped[listIndexOccuped.length - 1].position[1] % 10 != 9 &&
          listIndexOccuped[listIndexOccuped.length - 1].position[2] % 10 != 9 &&
          listIndexOccuped[listIndexOccuped.length - 1].position[3] % 10 != 9) {
        if (canMove(newPos))
          setState(() {
            listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
          });
      }
    } else if (touchsDirection[0] > touchsDirection[1] &&
        touchsDirection[1] > touchsDirection[2]) {
      var newPos = [
        listIndexOccuped[listIndexOccuped.length - 1].position[0] - 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[1] - 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[2] - 1,
        listIndexOccuped[listIndexOccuped.length - 1].position[3] - 1
      ];
      if (listIndexOccuped[listIndexOccuped.length - 1].position[0] % 10 != 0 &&
          listIndexOccuped[listIndexOccuped.length - 1].position[1] % 10 != 0 &&
          listIndexOccuped[listIndexOccuped.length - 1].position[2] % 10 != 0 &&
          listIndexOccuped[listIndexOccuped.length - 1].position[3] % 10 != 0) {
        if (canMove(newPos))
          setState(() {
            listIndexOccuped[listIndexOccuped.length - 1].position = newPos;
          });
      }
    }
  }
}
