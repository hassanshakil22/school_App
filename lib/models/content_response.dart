class MediaFilesResponse {
  final List<AudioFile> audioFiles;
  final List<VideoFile> videoFiles;
  final List<PdfFile> pdfFiles;

  MediaFilesResponse({
    required this.audioFiles,
    required this.videoFiles,
    required this.pdfFiles,
  });

  factory MediaFilesResponse.fromJson(Map<String, dynamic> json) {
    return MediaFilesResponse(
      audioFiles: (json['audioFiles'] as List<dynamic>?)
              ?.map((item) => AudioFile.fromJson(item))
              .toList() ??
          [],
      videoFiles: (json['videoFiles'] as List<dynamic>?)
              ?.map((item) => VideoFile.fromJson(item))
              .toList() ??
          [],
      pdfFiles: (json['pdfFiles'] as List<dynamic>?)
              ?.map((item) => PdfFile.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'audioFiles': audioFiles.map((file) => file.toJson()).toList(),
      'videoFiles': videoFiles.map((file) => file.toJson()).toList(),
      'pdfFiles': pdfFiles.map((file) => file.toJson()).toList(),
    };
  }
}

// Shared base class (optional but reduces code duplication)
abstract class MediaFile {
  final int sn;
  final String id;
  final String name;
  final String category;
  final DateTime dateOfUpload;
  final bool lock;

  MediaFile({
    required this.sn,
    required this.id,
    required this.name,
    required this.category,
    required this.dateOfUpload,
    required this.lock,
  });
}

class AudioFile extends MediaFile {
  AudioFile({
    required super.sn,
    required super.id,
    required super.name,
    required super.category,
    required super.dateOfUpload,
    required super.lock,
  });

  factory AudioFile.fromJson(Map<String, dynamic> json) {
    return AudioFile(
      sn: json['sn'] ?? 0,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      dateOfUpload: DateTime.parse(json['dateOfUpload'] as String? ?? DateTime.now().toIso8601String()),
      lock: json['lock'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sn': sn,
      'id': id,
      'name': name,
      'category': category,
      'dateOfUpload': dateOfUpload.toIso8601String(),
      'lock': lock,
    };
  }
}

class VideoFile extends MediaFile {
  VideoFile({
    required super.sn,
    required super.id,
    required super.name,
    required super.category,
    required super.dateOfUpload,
    required super.lock,
  });

  factory VideoFile.fromJson(Map<String, dynamic> json) {
    return VideoFile(
      sn: json['sn'] ?? 0,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      dateOfUpload: DateTime.parse(json['dateOfUpload'] as String? ?? DateTime.now().toIso8601String()),
      lock: json['lock'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sn': sn,
      'id': id,
      'name': name,
      'category': category,
      'dateOfUpload': dateOfUpload.toIso8601String(),
      'lock': lock,
    };
  }
}

class PdfFile extends MediaFile {
  PdfFile({
    required super.sn,
    required super.id,
    required super.name,
    required super.category,
    required super.dateOfUpload,
    required super.lock,
  });

  factory PdfFile.fromJson(Map<String, dynamic> json) {
    return PdfFile(
      sn: json['sn'] ?? 0,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      dateOfUpload: DateTime.parse(json['dateOfUpload'] as String? ?? DateTime.now().toIso8601String()),
      lock: json['lock'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sn': sn,
      'id': id,
      'name': name,
      'category': category,
      'dateOfUpload': dateOfUpload.toIso8601String(),
      'lock': lock,
    };
  }
}