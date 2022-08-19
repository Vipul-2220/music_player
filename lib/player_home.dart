import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player/database.dart';
import 'package:music_player/home_page.dart' as home;
import 'package:music_player/music_player_screen.dart';

class PLayerHome extends StatefulWidget {
  final Song song;
  const PLayerHome({Key? key, required this.song}) : super(key: key);

  @override
  State<PLayerHome> createState() => _PLayerHomeState();
}

class _PLayerHomeState extends State<PLayerHome> {
  bool isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    final player = AudioCache();
    final url = await player.load(widget.song.url);
    audioPlayer.setSourceDeviceFile(url.path);
    // audioPlayer.setSourceAsset(url.path);
  }

  @override
  void initState() {
    super.initState();

    setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void didChangeDependencies() {
    log('called');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, _, __) =>
                    MusicPlayerScreen(song: widget.song)));
      },
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'image',
                      child: CircleAvatar(
                        backgroundImage: AssetImage(widget.song.image),
                        radius: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.song.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.song.singer,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (isPlaying) {
                          await audioPlayer.pause();
                        } else {
                          await audioPlayer.resume();
                        }
                      },
                      icon: Icon(!isPlaying ? Icons.play_arrow : Icons.pause),
                      color: Colors.white,
                      iconSize: 30,
                    ),
                    ...const [
                      SizedBox(
                        width: 10,
                      ),
                      // Icon(
                      //   Icons.skip_next_outlined,
                      //   color: Colors.white,
                      //   size: 30,
                      // ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                    ],
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Duration(seconds: position.inSeconds.toInt())
                      .toString()
                      .split('.')[0]
                      .substring(2),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 4,
                      ),
                      trackShape: const RectangularSliderTrackShape(),
                      trackHeight: 4,
                    ),
                    child: Slider(
                      value: position.inSeconds.toDouble(),
                      max: widget.song.duration.toDouble(),
                      min: 0,
                      inactiveColor: Colors.grey[500],
                      activeColor: Colors.white,
                      onChanged: (val) async {
                        final posi = Duration(seconds: val.toInt());
                        // setState(() {
                        //   currentSlider = val;
                        // });
                        await audioPlayer.seek(posi);

                        await audioPlayer.resume();
                      },
                    ),
                  ),
                ),
                Text(
                  Duration(seconds: widget.song.duration)
                      .toString()
                      .split('.')[0]
                      .substring(2),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
