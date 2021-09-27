import 'dart:io';
import 'package:flutter/material.dart';
import 'game.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AssetsAudioPlayer audioplayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    audioplayer.open(
      Audio('assets/music/background.mp3'),
      autoStart: true,
      loopMode: LoopMode.single,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0XFFF122A5C),
      body: Container(
        width: size.width,
        height: size.height,
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 100),
        child: ListView(
          children: [
            Container(
              width: size.width * 0.4,
              height: size.width * 0.4,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return GameScreen();
                    },
                  ),
                );
              },
              child: Button(size: size, title: "Play", mt: 80),
            ),
            Button(size: size, title: "Options", mt: 28),
            GestureDetector(
              onTap: () {
                exit(0);
              },
              child: Button(size: size, title: "Exit", mt: 28),
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.size,
    required this.mt,
    required this.title,
  }) : super(key: key);

  final Size size;
  final String title;
  final double mt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.only(top: mt),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
