import 'package:flutter_auth_getx/core/authentication_manager.dart';
import 'package:flutter_auth_getx/repo/service/video_service.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  AuthenticationManager _authManager = Get.find();
  VideoService videoService = Get.put(VideoService());

  Future<void> initializePlayer() async {
    final token = await _authManager.checkLoginStatus();
    final url = await videoService.fetchUrl(token);
    _videoPlayerController = VideoPlayerController.network(url);
    await Future.wait([
      _videoPlayerController.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Início'),
        actions: [
          IconButton(
              onPressed: () {
                _authManager.logOut();
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.width * 0.03),
        _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Chewie(
                  controller: _chewieController!,
                ))
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(height: 25),
                  CircularProgressIndicator(),
                  SizedBox(height: 25),
                  Text('Carregando video...'),
                ],
              )),
      ]),
    );
  }
}
