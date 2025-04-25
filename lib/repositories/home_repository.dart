import 'package:flutter/widgets.dart';
import 'package:school_app/app/api_urls.dart';
import 'package:school_app/app/appConstants.dart';
import 'package:school_app/models/content_response.dart';
import 'package:school_app/providers/auth_provider.dart';
import 'package:school_app/services/http_service.dart';

class HomeRepository {

  HomeRepository({required this.httpService});

  final HttpService httpService;

  

  Future<MediaFilesResponse> getAllMedia() async {
   try {
      dynamic response = await httpService.get(ApiUrls.getContent(AuthProvider.token));
      return MediaFilesResponse.fromJson(response as Map<String, dynamic>);
    } catch (e, stackTrace) {
      debugPrint("Error: $e\nStackTrace: $stackTrace");
      rethrow;
    }
  }


  
}