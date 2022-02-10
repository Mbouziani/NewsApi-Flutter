import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news/Models/M_news.dart';

class NewsController extends GetxController {
  getData() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=c0bba916b1d24bdca7b2b08d3fbf7d16");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        return ArictlesNews.fromJson(jsonDecode(response.body));
      } catch (e) {
        Get.snackbar("error", e.toString());
      }
    }
  }
}
