import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayMusic extends StatefulWidget {
  const PlayMusic({Key? key}) : super(key: key);

  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  late AudioPlayer player;
  late AudioCache cache;
  bool isPlaying = false;
  Duration currentPostion = Duration();
  Duration musicLength = Duration();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player = AudioPlayer();
    cache = AudioCache(fixedPlayer: player);
    cache.load('a.mp3');
    setUp();
  }

  setUp() {
    player.onAudioPositionChanged.listen((d) {
      setState(() {
        currentPostion = d;
      });
      player.onDurationChanged.listen((d) {
        setState(() {
          musicLength = d;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: Text(
              'Play Audio',
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            alignment: Alignment.center,
            color: Colors.blue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('${_formatDuration(currentPostion)}'),
              Container(
                  width: 300,
                  child: Slider(
                      value: currentPostion.inSeconds.toDouble(),
                      max: musicLength.inSeconds.toDouble(),
                      onChanged: (val) {
                        seekTo(val.toInt());
                      })),
              Text('${_formatDuration(musicLength)}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  if (currentPostion.inSeconds == 0 ||
                      currentPostion.inSeconds < 10) {
                    seekTo(0);
                  } else if (currentPostion.inSeconds > 10) {
                    seekTo(currentPostion.inSeconds - 10);
                  }
                },
                icon: Icon(Icons.replay_10),
                iconSize: 35,
              ),
              IconButton(
                onPressed: () {
                  if (isPlaying) {
                    setState(() {
                      isPlaying = false;
                    });
                    stopMusic();
                  } else {
                    setState(() {
                      isPlaying = true;
                    });
                    playMusic();
                  }
                },
                icon: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                iconSize: 35,
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () {
                  setState(() {
                    isPlaying = false;
                    player.stop();
                  });
                },
              ),
              IconButton(
                onPressed: () {
                  if (currentPostion < musicLength - Duration(seconds: 10)) {
                    seekTo(currentPostion.inSeconds + 10);
                  } else {
                    seekTo(musicLength.inSeconds);
                    setState(() {
                      isPlaying = false;
                    });
                    player.stop();
                  }
                },
                icon: Icon(Icons.forward_10),
                iconSize: 35,
              ),
            ],
          ),
          Text('Audio SpeedX:', style: TextStyle(fontSize: 20),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: (){
                  setState(() {
                    player.setPlaybackRate(1.0);
                  });
                },
                icon: Icon(
                  Icons.looks_one,
                ),iconSize: 35,
              ),
              IconButton(
                onPressed: (){
                  setState(() {
                    player.setPlaybackRate(2.0);
                  });
                },
                icon: Icon(
                  Icons.looks_two,
                ),iconSize: 35,
              ),
              IconButton(
                onPressed: (){
                  setState(() {
                    player.setPlaybackRate(3.0);
                  });
                },
                icon: Icon(
                  Icons.looks_3,
                ),iconSize: 35,
              ),
              IconButton(
                onPressed: (){
                  setState(() {
                    player.setPlaybackRate(4.0);
                  });
                },
                icon: Icon(
                  Icons.looks_4,
                ),iconSize: 35,
              )
            ],
          )
        ],
      ),
    );
  }

  playMusic() {
    cache.play('a.mp3');
  }

  stopMusic() {
    player.pause();
  }

  seekTo(int sec) {
    player.seek(Duration(seconds: sec));
  }

  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }
}
