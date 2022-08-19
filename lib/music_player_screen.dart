import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player/database.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Song song;
  const MusicPlayerScreen({Key? key, required this.song}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

double currentSlider = 0;

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  bool isPlaying = false;
  bool previous = false;
  bool next = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'image',
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.song.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hello Colosseuem',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'India',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(right: 8, left: 15),
                child: Icon(
                  Icons.notifications_active_outlined,
                  size: 30,
                ),
              ),
            ],
          ),
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 14,
                  spreadRadius: 16,
                  color: Colors.black.withOpacity(0.2),
                ),
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    height: 280,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.song.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            widget.song.singer,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 2),
                                trackShape: const RectangularSliderTrackShape(),
                                trackHeight: 6),
                            child: Slider(
                              value: currentSlider,
                              max: widget.song.duration.toDouble(),
                              min: 0,
                              inactiveColor: Colors.white70,
                              activeColor: Colors.red,
                              onChanged: (val) {
                                currentSlider = val;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Duration(seconds: currentSlider.toInt())
                                    .toString()
                                    .split('.')[0]
                                    .substring(2),
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                Duration(seconds: widget.song.duration.toInt())
                                    .toString()
                                    .split('.')[0]
                                    .substring(2),
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  previous = !previous;
                                });
                              },
                              icon: const Icon(Icons.skip_previous_outlined,
                                  color: Colors.white, size: 40),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isPlaying = !isPlaying;
                                  print(isPlaying.toString());
                                });
                              },
                              icon: isPlaying
                                  ? const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 40,
                                    )
                                  : const Icon(Icons.pause,
                                      color: Colors.white, size: 40),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    next = !next;
                                  });
                                },
                                icon: const Icon(Icons.skip_next_outlined,
                                    color: Colors.white, size: 40)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(Icons.replay_outlined,
                                  color: Colors.white, size: 40),
                              Icon(Icons.shuffle, color: Colors.white, size: 40)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
