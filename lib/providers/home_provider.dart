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


//extracting subjects 
List<String> subjects = [];
void getAllSubjects() {
  final Set<String> subjectSet = {};

  for (var file in audioFiles) {
    if (file.category != null && file.category.trim().isNotEmpty) {
      subjectSet.add(file.category.trim());
    }
  }

  for (var file in videoFiles) {
    if (file.category != null && file.category.trim().isNotEmpty) {
      subjectSet.add(file.category.trim());
    }
  }

  for (var file in pdfFiles) {
    if (file.category != null && file.category.trim().isNotEmpty) {
      subjectSet.add(file.category.trim());
    }
  }

  subjects = subjectSet.toList();
}


//filtering according to subject

  List<AudioFile> filterAudioBySubject(String subject,) {
  return audioFiles.where((file) => file.category == subject).toList();
}
List<VideoFile> filterVideoBySubject(String subject, List<VideoFile> videoFiles) {
  return videoFiles.where((file) => file.category == subject).toList();
}
List<PdfFile> filterPdfBySubject(String subject, List<PdfFile> pdfFiles) {
  return pdfFiles.where((file) => file.category == subject).toList();
}



}
