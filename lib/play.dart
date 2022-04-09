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
            height: 550,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Text(
                '''


                                      MALINKUNDANG

    Hidup ibu dan anak ini serba kekurangan. Meski begitu, sang ibu selalu berusaha keras untuk memberikan kehidupan yang layak untuk anak laki-lakinya.
Ketika Malin beranjak dewasa, dia pergi merantai bersama seorang saudagar kaya. Ia pun berjanji akan pulang dan menjemput ibunya setelah kaya raya.
"Malin akan pulang setelah berhasil. Malin akan menjemput ibu. Doakan Malin ya," katanya pada sang ibu sebelum pergi.

    Bertahun-tahun kemudian, Malin Kundang berhasil menjadi pedagang yang kaya. Ia pun menikah dengan putri seorang kepala kampung. Sayangnya, kehidupannya yang bergelimang harta membuat Malin lupa dengan sang ibu. Ia malam berbohong dengan sang istri dan mengaku bahwa ibunya telah meninggal dunia.
Suatu hari, Malin dan istrinya terpaksa berlabuh ke pulau tempat kampung halamannya karena cuaca buruk. Istri Malin juga memaksa suaminya untuk turun ke pulau dan membeli ikan. Malin cemas karena dia takut bertemu ibunya.
Saat dia turun dari kapal, semua orang menyambunya dan menyebutnya 'saudagar kaya'. Tak jauh dari situ, ibu Malin yang kebetulan sedang membantu nelayan, melihat sosok putranya. Ia lalu mendekat untuk memastikannya.
"Malin...Malin Kundang anakku," kata sang ibu langsung memeluk Malin.

    "Hei, kau wanita tua, diapa kau hingga berani memanggilku anakmu?"

    Istri Malin lalu berusaha menengahi dan meminta sang ibu menunjukkan bukti bahwa Malin adalah anaknya. Ibu Malin pun mengatakan luka di tangan Malin yang telah ada sejak kecil. Istri Malin pun menyadari bahwa ucapan wanita tua di hadapannya memang benar.
"Suamiku, mengapa kau mengingkari ibumu sendiri?" tanya istri Malin.

    Malin Kundang tak peduli dan tetap tak ingin mengakui ibunya. Sang ibu lalu meratap dan tepat saat itu hujan deras. Tiba-tiba petir menyambar tetap di kaki Malin dan mendadak tubuhnya menjadi kaku seperti batu. Malin amat ketakutan dan dia menyadari telah durhaka dan berdosa pada ibunya.
"Ibu, tolong ampuni aku. Tolong selamatkan aku," teriak Malin.

    Ibu Malin berusaha menolong tapi terlambat karena anaknya sudah berubah menjadi batu. Dari cerita ini, anak bisa mendapatkan pesan moral untuk menepati janji, serta tidak durhaka kepada orang tua
    
    ''',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            alignment: Alignment.center,
            color: Colors.black87,
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
          Text(
            'Audio SpeedX:',
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    player.setPlaybackRate(1.0);
                  });
                },
                icon: Icon(
                  Icons.looks_one,
                ),
                iconSize: 35,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    player.setPlaybackRate(2.0);
                  });
                },
                icon: Icon(
                  Icons.looks_two,
                ),
                iconSize: 35,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    player.setPlaybackRate(3.0);
                  });
                },
                icon: Icon(
                  Icons.looks_3,
                ),
                iconSize: 35,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    player.setPlaybackRate(4.0);
                  });
                },
                icon: Icon(
                  Icons.looks_4,
                ),
                iconSize: 35,
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
