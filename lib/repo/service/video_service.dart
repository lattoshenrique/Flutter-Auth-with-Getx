import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class VideoService extends GetConnect {
  final String loginUrl = 'https://mobiletest.seventh.com.br/video/bunny.mp4';

  Future fetchUrl(String token) async {
    final response = await get(loginUrl, headers: {"X-Access-Token": token});
    if (response.statusCode == HttpStatus.ok) {
      return jsonDecode(jsonEncode(response.body))['url'];
    } else {
      return null;
    }
  }
}
