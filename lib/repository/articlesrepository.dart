
import 'dart:convert';

import 'package:fitcal/constants/constants.dart';
import 'package:fitcal/model/articles_model.dart';
import 'package:http/http.dart' as http;


Future<Articles> fetchArticles() async {
  final response = await http
      .get(Uri.parse(apiurl));

  if (response.statusCode == 200) {
    
    return Articles.fromJson(jsonDecode(response.body));
  } else {
    
    throw Exception('Failed to load album');
  }
}