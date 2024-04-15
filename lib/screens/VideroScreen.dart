import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video {
  final String id;
  final String fecha;
  final String titulo;
  final String descripcion;
  final String link;

  Video({
    required this.id,
    required this.fecha,
    required this.titulo,
    required this.descripcion,
    required this.link,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      fecha: json['fecha'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      link: json['link'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Videos Defensa Civil',
      theme: ThemeData(
        primaryColor: const Color(0xFFD50000), // Color primario de la Defensa Civil
        hintColor: const Color(0xFFF9A825), // Color secundario de la Defensa Civil
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VideoScreen(),
    );
  }
}

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late Future<List<Video>> _futureVideos;

  @override
  void initState() {
    super.initState();
    _futureVideos = fetchVideos();
  }

  Future<List<Video>> fetchVideos() async {
    final response = await http.get(Uri.parse('https://adamix.net/defensa_civil/def/videos.php'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final videos = <Video>[];
      for (var video in jsonData['datos']) {
        videos.add(Video.fromJson(video));
      }
      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos Defensa Civil'),
      ),
      body: Center(
        child: FutureBuilder<List<Video>>(
          future: _futureVideos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      VideoPlayerScreen(video: snapshot.data![index]),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data![index].titulo,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(snapshot.data![index].descripcion),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final Video video;

  VideoPlayerScreen({required this.video});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.link,
      flags: YoutubePlayerFlags(
        autoPlay: false, // Cambiar a false para que aparezca pausado
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
      onReady: () {
        setState(() {
          // Pausar el video después de que esté listo
          _controller.pause();
        });
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
