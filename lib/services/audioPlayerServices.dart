import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:school_app/app/size_extensions.dart';

class Audioplayerservices {
  static void showAudioPlayer(BuildContext context, String audioUrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return AudioPlayerWidget(audioUrl: audioUrl);
      },
    );
  }
}
class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _player;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    try {
      await _player.setUrl(widget.audioUrl);
    } catch (e) {
      debugPrint("Audio load error: $e");
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h*0.1,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Row(
        children: [
          // Play/Pause
          _isLoading
              ? const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : StreamBuilder<PlayerState>(
                  stream: _player.playerStateStream,
                  builder: (context, snapshot) {
                    final playing = snapshot.data?.playing ?? false;
                    return IconButton(
                      icon: Icon(
                        playing ? Icons.pause_circle : Icons.play_circle,
                        size: 30,
                      ),
                      onPressed: playing ? _player.pause : _player.play,
                    );
                  },
                ),
                SizedBox(width: 5,),

          // Duration text
          StreamBuilder<Duration>(
            stream: _player.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              final total = _player.duration ?? Duration.zero;
              return Text(
                "${_formatDuration(position)} / ${_formatDuration(total)}",
                style: const TextStyle(fontSize: 14),
              );
            },
          ),

          const SizedBox(width: 10),

          // Slider
          Expanded(
            child: StreamBuilder<Duration>(
              stream: _player.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final total = _player.duration ?? Duration.zero;

                return Slider(
                  value: position.inSeconds.toDouble().clamp(0, total.inSeconds.toDouble()),
                  max: total.inSeconds.toDouble() > 0 ? total.inSeconds.toDouble() : 1,
                  onChanged: (value) {
                    _player.seek(Duration(seconds: value.toInt()));
                  },
                );
              },
            ),
          ),
            IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),

        ],
      ),
    );
  }


String _formatDuration(Duration d) {
  final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
}
