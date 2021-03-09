import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentiment_analysis/models/sentana.dart';
import 'package:http/http.dart' as http;

class SentimentApi extends ChangeNotifier {
  SentimentApi([this.sentiment = '']);
  String sentiment;
  Future fetchData(String? str) async {
    sentiment = 'fdd';
    notifyListeners();
  }
}

class SentimentApiStateNotifier extends StateNotifier<String> {
  SentimentApiStateNotifier([String? state]) : super(state ?? '');
  static const _api_key = '8efd3bb598msha53101a5ee48075p1f9fd5jsn58ef17cac1e4';
  final _baseUrl =
      'https://twinword-twinword-bundle-v1.p.rapidapi.com/sentiment_analyze/';
  static const Map<String, String> _header = {
    'content-type': 'application/x-www-form-urlencoded',
    'x-rapidapi-key': _api_key,
    'x-rapidapi-host': 'twinword-twinword-bundle-v1.p.rapidapi.com',
    'useQueryString': 'true',
  };

  Future post({@required Map<String, String>? query}) async {
    try {
      final response = await http.post(_baseUrl, headers: _header, body: query);

      if (response.statusCode >= 400) {
        throw HttpException('An error occurred.');
      }

      if (response.statusCode == 200) {
        // state = SentAna.fromJson(json.decode(response.body));
        print(response.body);
        return SentAna.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print(e);

      return e;
    }
  }

  void getSentiment(String queryText) {
    state = 'L';
    post(query: {'text': queryText}).then((value) {
      state = 'Prediction is :' + value;
    }).catchError((e) {
      state = 'An error occurred.';
    });
  }
}
