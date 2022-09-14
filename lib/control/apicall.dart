import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:machine_test_pixbay_api/model/modelclass.dart';

Future<Pixbay> getPictureFromApi({String? searchkeyword}) async {
 // print(searchkeyword);
  final response = await http.get(Uri.parse(
    
      "https://pixabay.com/api/?key=29897564-b0b40e450044858d8a337b8b0&q=$searchkeyword&image_type=photo"));
  print(response.body);
  if (response.statusCode == 200) {
    final data = Pixbay.fromJson(jsonDecode(response.body));

    return data;
  } else {
    throw Exception("Unable to load the data");
  }
}
