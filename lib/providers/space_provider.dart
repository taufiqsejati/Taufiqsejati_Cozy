import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taufiqsejati_cozy/models/space.dart';

class SpaceProvider extends ChangeNotifier {
  getRecommendedSpaces() async {
    String apiURL = 'https://bwa-cozy.herokuapp.com/recommended-spaces';
    var result = await http.get(Uri.parse(apiURL));

    print(result.statusCode);
    print(result.body);

    if (result.statusCode == 200) {
      List data = jsonDecode(result.body);
      List<Space> spaces = data.map((item) => Space.fromJson(item)).toList();
      return spaces;
    } else {
      return <Space>[];
    }
  }
}
