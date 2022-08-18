import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player/database.dart';
import 'package:music_player/home_page.dart';

class CircleTrackWdget extends StatefulWidget {
  final String title;
  final List<Song> song;
  final String subtitle;
  final Function() notifyParent;
  const CircleTrackWdget(
      {Key? key,
      required this.title,
      required this.song,
      required this.subtitle,
      required this.notifyParent})
      : super(key: key);

  @override
  State<CircleTrackWdget> createState() => _CircleTrackWdgetState();
}

class _CircleTrackWdgetState extends State<CircleTrackWdget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              widget.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              widget.subtitle,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  // fontSize: 30,
                  color: Colors.grey),
            ),
          ),
          Container(
            height: 120,
            child: ListView.builder(
                itemCount: widget.song.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      currentSong = widget.song[index];
                      currentSlider = 0;
                      widget.notifyParent();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(widget.song[index].image),
                            radius: 40,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.song[index].name,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            widget.song[index].singer,
                            style: const TextStyle(color: Colors.white54),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
