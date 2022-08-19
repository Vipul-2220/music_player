import 'package:flutter/material.dart';

class Song {
  final String name;
  final String singer;
  final String image;
  final int duration;
  final String url;
  final Color color;
  Song(this.url,
      {required this.name,
      required this.singer,
      required this.image,
      required this.duration,
      required this.color});
}

List<Song> mostPopular = [
  Song('bg1.mp3',
      name: "like it doesn't hurt",
      image: "assets/song1.jpg",
      singer: "Charle Cardin",
      duration: 300,
      color: Colors.grey),
  Song('bg2.mp3',
      name: "love on the brain",
      image: "assets/song2.jpg",
      singer: "Tvorchi",
      duration: 252,
      color: Colors.red),
  Song('bg3.mp3',
      name: "hail to the victor",
      image: "assets/song3.jpg",
      singer: "danito & athina",
      duration: 532,
      color: Colors.orange),
  Song('bg1.mp3',
      name: "idk",
      image: "assets/song4.jpg",
      singer: "ley you",
      duration: 264,
      color: Colors.blue)
];

List<Song> newRelease = [
  Song('bg1.mp3',
      name: "love on the brain",
      image: "assets/song2.jpg",
      singer: "Tvorchi",
      duration: 252,
      color: Colors.red),
  Song('bg2.mp3',
      name: "like it doesn't hurt",
      image: "assets/song1.jpg",
      singer: "Charle Cardin",
      duration: 300,
      color: Colors.grey),
  Song('bg3.mp3',
      name: "idk",
      image: "assets/song4.jpg",
      singer: "ley you",
      duration: 264,
      color: Colors.blue),
  Song('bg1.mp3',
      name: "hail to the victor",
      image: "assets/song3.jpg",
      singer: "danito & athina",
      duration: 532,
      color: Colors.orange),
];
