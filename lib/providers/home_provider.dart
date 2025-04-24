import 'package:flutter/material.dart';
import 'package:school_app/models/content_response.dart';
import 'package:school_app/providers/auth_provider.dart';
import 'package:school_app/repositories/home_repository.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepository homeRepository;
  HomeProvider({required this.homeRepository});

  Loading loading = Loading();

  void setLoading(bool isLoading) {
    loading.setLoading(isLoading);
    notifyListeners();
  }

  List<AudioFile> audioFiles = [];
  List<VideoFile> videoFiles = [];
  List<PdfFile> pdfFiles = [];

  Future<void> loadMedia() async {
    setLoading(true);
    MediaFilesResponse response = await homeRepository
        .getAllMedia()
        .whenComplete(() => setLoading(false));

    // Access the pre-separated lists
    audioFiles = response.audioFiles;
    videoFiles = response.videoFiles;
    pdfFiles = response.pdfFiles;
    notifyListeners();
  }
  
}
