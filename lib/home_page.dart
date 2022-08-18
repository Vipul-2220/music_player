import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player/circle_track_widget.dart';
import 'package:music_player/database.dart';
import 'package:music_player/player_home.dart';
import 'package:music_player/track_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        // ignore: deprecated_member_use
        brightness: Brightness.dark,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: const Icon(Icons.search),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Hello, Pathway',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'India',
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8, left: 15),
            child: Icon(Icons.notifications_active_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'most',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'popular',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 18, bottom: 20),
                  child: Text(
                    '960 playlists',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  height: 300,
                  child: TrackWidget(
                    notifyParent: refresh,
                  ),
                ),
                CircleTrackWdget(
                  title: 'new releases',
                  song: newRelease,
                  subtitle: '3456 songs',
                  notifyParent: refresh,
                ),
                CircleTrackWdget(
                  title: 'your playlist',
                  song: mostPopular,
                  subtitle: '346 songs',
                  notifyParent: refresh,
                ),
                const SizedBox(
                  height: 130,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PLayerHome(song: currentSong),
          ),
        ],
      ),
    );
  }

  refresh() {
    setState(() {});
  }
}

Song currentSong = Song(
  name: 'title',
  singer: 'singer',
  image: 'assets/song1.jpg',
  duration: 100,
  color: Colors.black,
);
double currentSlider = 0;
