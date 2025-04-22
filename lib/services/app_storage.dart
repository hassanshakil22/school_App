import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LectureStorage {
  // Private methods to get paths

  // gets the path of the documents directory
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // For video lectures
  // makes a local file name with directory lectures/filename

  static Future<File> _localVideoFile(String filename) async {
    final path = await _localPath;
    return File('$path/lectures/$filename');
  }

  // For audio lectures
  // makes a local file name with directory audios/filename

  static Future<File> _localAudioFile(String filename) async {
    final path = await _localPath;
    return File('$path/audios/$filename');
  }

  // ========== Video Lecture Methods ========== //
  // copies the lecture from source file to the filename given which will be inputted in lectures folder in duocuments  
  static Future<File> saveVideoLecture(File sourceFile, String filename) async {
    final file = await _localVideoFile(filename);
    await file.create(recursive: true);
    return await sourceFile.copy(file.path);
  }

  static Future<File?> getVideoLecture(String filename) async {
    final file = await _localVideoFile(filename);
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  static Future<void> deleteVideoLecture(String filename) async {
    final file = await _localVideoFile(filename);
    if (await file.exists()) {
      await file.delete();
    }
  }

  // ========== Audio Lecture Methods ========== //
  // copies the lecture from source file to the filename given which will be inputted in lectures folder in duocuments 
  static Future<File> saveAudioLecture(File sourceFile, String filename) async {
    final file = await _localAudioFile(filename);
    await file.create(recursive: true);
    return await sourceFile.copy(file.path);
  }

  static Future<File?> getAudioLecture(String filename) async {
    final file = await _localAudioFile(filename);
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  static Future<void> deleteAudioLecture(String filename) async {
    final file = await _localAudioFile(filename);
    if (await file.exists()) {
      await file.delete();
    }
  }

  // ========== Utility Methods ========== //
  static Future<List<String>> getAllVideoLectures() async {
    final path = await _localPath;
    final dir = Directory('$path/lectures');
    if (await dir.exists()) {
      return dir.list()
          .where((entity) => entity is File)
          .map((file) => (file as File).path.split('/').last)
          .toList();
    }
    return [];
  }

  static Future<List<String>> getAllAudioLectures() async {
    final path = await _localPath;
    final dir = Directory('$path/audios');
    if (await dir.exists()) {
      return dir.list()
          .where((entity) => entity is File)
          .map((file) => (file as File).path.split('/').last)
          .toList();
    }
    return [];
  }
}